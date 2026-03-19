import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../../core/data/graphql/graphql_client.dart';
import '../../../../core/data/graphql/media_headers_provider.dart';
import '../../../../core/data/graphql/url_resolver.dart';
import '../../../../core/data/preferences/shared_preferences_provider.dart';
import '../providers/video_player_provider.dart';
import '../../domain/entities/scene.dart';

class SceneVideoPlayer extends ConsumerStatefulWidget {
  final Scene scene;
  const SceneVideoPlayer({required this.scene, super.key});

  @override
  ConsumerState<SceneVideoPlayer> createState() => _SceneVideoPlayerState();
}

class _SceneVideoPlayerState extends ConsumerState<SceneVideoPlayer> {
  static const _preferSceneStreamsKey = 'prefer_scene_streams';
  static Future<void>? _pathsStreamPrewarmFuture;

  bool _isStarting = false;
  String? _autoStartedSceneId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startPlaybackIfNeeded();
    });
  }

  @override
  void didUpdateWidget(covariant SceneVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scene.id != widget.scene.id) {
      _autoStartedSceneId = null;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startPlaybackIfNeeded();
      });
    }
  }

  Future<void> _startPlaybackIfNeeded({bool force = false}) async {
    if (!mounted || _isStarting) return;

    final playerState = ref.read(playerStateProvider);
    if (!force && _autoStartedSceneId == widget.scene.id) return;
    if (!force && playerState.activeScene?.id == widget.scene.id) return;

    setState(() => _isStarting = true);
    try {
      final prefs = ref.read(sharedPreferencesProvider);
      final preferSceneStreams = prefs.getBool(_preferSceneStreamsKey) ?? true;

      final choice = preferSceneStreams
          ? await _resolvePreferredStream()
          : null;
      final streamUrl = choice?.url ?? widget.scene.paths.stream ?? '';
      var mimeType = choice?.mimeType ?? _guessMimeType(streamUrl);
      final streamLabel = choice?.label;
      var streamSource = choice == null
          ? (preferSceneStreams ? 'paths.stream' : 'paths.stream(direct)')
          : 'sceneStreams';
      final mediaHeaders = ref.read(mediaHeadersProvider);

      await _prewarmPathsStreamOnce(mediaHeaders);

      if (streamUrl.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No stream URL available')),
        );
        return;
      }

      if (mimeType == 'unknown') {
        final probedMime = await _probeMimeTypeFromHeaders(
          streamUrl,
          mediaHeaders,
        );
        if (probedMime != null && probedMime.isNotEmpty) {
          mimeType = probedMime;
          streamSource = '$streamSource+header';
        }
      }

      _autoStartedSceneId = widget.scene.id;
      await ref
          .read(playerStateProvider.notifier)
          .playScene(
            widget.scene,
            streamUrl,
            mimeType: mimeType,
            streamLabel: streamLabel,
            streamSource: streamSource,
            httpHeaders: mediaHeaders,
          );
    } finally {
      if (mounted) {
        setState(() => _isStarting = false);
      }
    }
  }

  Future<void> _prewarmPathsStreamOnce(Map<String, String> headers) {
    final existingFuture = _pathsStreamPrewarmFuture;
    if (existingFuture != null) return existingFuture;

    final rawStreamUrl = widget.scene.paths.stream ?? '';
    final client = ref.read(graphqlClientProvider);
    final graphqlEndpoint = client.link is HttpLink
        ? (client.link as HttpLink).uri
        : Uri.parse(
            rawStreamUrl.isEmpty ? 'https://localhost/graphql' : rawStreamUrl,
          );
    final streamUrl = resolveGraphqlMediaUrl(
      rawUrl: rawStreamUrl,
      graphqlEndpoint: graphqlEndpoint,
    );
    if (streamUrl.isEmpty) {
      _pathsStreamPrewarmFuture = Future<void>.value();
      return _pathsStreamPrewarmFuture!;
    }

    final future = _prewarmStreamRequest(streamUrl, headers);
    _pathsStreamPrewarmFuture = future;
    return future;
  }

  Future<void> _prewarmStreamRequest(
    String streamUrl,
    Map<String, String> headers,
  ) async {
    final uri = Uri.tryParse(streamUrl);
    if (uri == null) return;

    final client = HttpClient();
    client.connectionTimeout = const Duration(seconds: 3);

    try {
      final req = await client
          .openUrl('GET', uri)
          .timeout(const Duration(seconds: 3));
      headers.forEach(req.headers.set);
      req.headers.set('Range', 'bytes=0-0');

      final res = await req.close().timeout(const Duration(seconds: 4));
      await res.drain<void>();
    } catch (_) {
      // Best effort prewarm only; ignore failures.
    } finally {
      client.close(force: true);
    }
  }

  Future<_StreamChoice?> _resolvePreferredStream() async {
    final client = ref.read(graphqlClientProvider);
    final result = await client.query(
      QueryOptions(
        document: gql('''
          query SceneStreamsForPlayer(\$id: ID!) {
            findScene(id: \$id) {
              sceneStreams {
                url
                mime_type
                label
              }
            }
          }
        '''),
        variables: <String, dynamic>{'id': widget.scene.id},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      return null;
    }

    final streams =
        ((result.data?['findScene']?['sceneStreams']) as List?)
            ?.whereType<Map<String, dynamic>>()
            .toList() ??
        const <Map<String, dynamic>>[];
    if (streams.isEmpty) return null;

    final graphqlEndpoint = client.link is HttpLink
        ? (client.link as HttpLink).uri
        : Uri.parse(widget.scene.paths.stream ?? 'https://localhost/graphql');

    _StreamChoice? best;
    for (final stream in streams) {
      final resolvedUrl = resolveGraphqlMediaUrl(
        rawUrl: stream['url'] as String?,
        graphqlEndpoint: graphqlEndpoint,
      );
      if (resolvedUrl.isEmpty) continue;

      final mime = (stream['mime_type'] as String?)?.trim();
      final label = (stream['label'] as String?)?.trim();
      final guessed = _guessMimeType(resolvedUrl, label: label);
      final choice = _StreamChoice(
        url: resolvedUrl,
        mimeType: (mime == null || mime.isEmpty) ? guessed : mime,
        label: label,
      );

      if (best == null || choice.score > best.score) {
        best = choice;
      }
    }

    return best;
  }

  Future<String?> _probeMimeTypeFromHeaders(
    String url,
    Map<String, String> headers,
  ) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    final client = HttpClient();
    client.connectionTimeout = const Duration(seconds: 3);

    try {
      Future<String?> requestAndExtract(
        String method, {
        bool withRange = false,
      }) async {
        final req = await client
            .openUrl(method, uri)
            .timeout(const Duration(seconds: 3));
        headers.forEach(req.headers.set);
        if (withRange) {
          req.headers.set('Range', 'bytes=0-0');
        }

        final res = await req.close().timeout(const Duration(seconds: 3));
        await res.drain<void>();

        final contentType = res.headers.value(HttpHeaders.contentTypeHeader);
        if (contentType == null || contentType.trim().isEmpty) return null;
        return contentType.split(';').first.trim().toLowerCase();
      }

      final fromHead = await requestAndExtract('HEAD');
      if (fromHead != null && fromHead.isNotEmpty) return fromHead;

      final fromGet = await requestAndExtract('GET', withRange: true);
      if (fromGet != null && fromGet.isNotEmpty) return fromGet;
      return null;
    } catch (_) {
      return null;
    } finally {
      client.close(force: true);
    }
  }

  String _guessMimeType(String url, {String? label}) {
    final uri = Uri.tryParse(url);
    final path = (uri?.path ?? url).toLowerCase();
    final lowerLabel = (label ?? '').toLowerCase();

    if (path.endsWith('.m3u8') || lowerLabel.contains('hls')) {
      return 'application/vnd.apple.mpegurl';
    }
    if (path.endsWith('.mpd') || lowerLabel.contains('dash')) {
      return 'application/dash+xml';
    }
    if (path.endsWith('.mp4') || lowerLabel.contains('mp4')) {
      return 'video/mp4';
    }
    if (path.endsWith('.webm') || lowerLabel.contains('webm')) {
      return 'video/webm';
    }
    return 'unknown';
  }

  @override
  Widget build(BuildContext context) {
    final playerState = ref.watch(playerStateProvider);

    if (playerState.activeScene?.id != widget.scene.id) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.black,
          child: Center(
            child: _isStarting
                ? const CircularProgressIndicator()
                : IconButton(
                    icon: const Icon(
                      Icons.play_arrow,
                      size: 64,
                      color: Colors.white,
                    ),
                    onPressed: () => _startPlaybackIfNeeded(force: true),
                  ),
          ),
        ),
      );
    }

    final chewieController = playerState.chewieController;

    if (chewieController == null) {
      return const AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          Positioned.fill(child: Chewie(controller: chewieController)),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(180),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'mime: ${playerState.streamMimeType ?? 'unknown'}'
                '${playerState.streamLabel == null || playerState.streamLabel!.isEmpty ? '' : '  label: ${playerState.streamLabel}'}'
                '${playerState.streamSource == null || playerState.streamSource!.isEmpty ? '' : '  src: ${playerState.streamSource}'}'
                '${playerState.startupLatencyMs == null ? '' : '  start: ${playerState.startupLatencyMs}ms'}',
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StreamChoice {
  const _StreamChoice({required this.url, required this.mimeType, this.label});

  final String url;
  final String mimeType;
  final String? label;

  int get score {
    final lowerMime = mimeType.toLowerCase();
    final lowerLabel = (label ?? '').toLowerCase();
    if (lowerMime.contains('mpegurl') || lowerMime.contains('hls')) return 300;
    if (lowerMime.contains('dash')) return 250;
    if (lowerMime.contains('mp4') && lowerLabel.contains('direct')) return 220;
    if (lowerMime.contains('mp4')) return 200;
    return 100;
  }
}

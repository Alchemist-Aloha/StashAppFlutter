import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_player/video_player.dart';
import '../../domain/entities/scene.dart';

part 'video_player_provider.g.dart';

class GlobalPlayerState {
  final Scene? activeScene;
  final VideoPlayerController? videoPlayerController;
  final ChewieController? chewieController;
  final bool isPlaying;
  final String? streamMimeType;
  final String? streamLabel;
  final String? streamSource;
  final int? startupLatencyMs;
  final bool? prewarmAttempted;
  final bool? prewarmSucceeded;
  final int? prewarmLatencyMs;

  GlobalPlayerState({
    this.activeScene,
    this.videoPlayerController,
    this.chewieController,
    this.isPlaying = false,
    this.streamMimeType,
    this.streamLabel,
    this.streamSource,
    this.startupLatencyMs,
    this.prewarmAttempted,
    this.prewarmSucceeded,
    this.prewarmLatencyMs,
  });

  GlobalPlayerState copyWith({
    Scene? activeScene,
    VideoPlayerController? videoPlayerController,
    ChewieController? chewieController,
    bool? isPlaying,
    String? streamMimeType,
    String? streamLabel,
    String? streamSource,
    int? startupLatencyMs,
    bool? prewarmAttempted,
    bool? prewarmSucceeded,
    int? prewarmLatencyMs,
    bool clearActive = false,
  }) {
    return GlobalPlayerState(
      activeScene: clearActive ? null : (activeScene ?? this.activeScene),
      videoPlayerController: clearActive
          ? null
          : (videoPlayerController ?? this.videoPlayerController),
      chewieController: clearActive
          ? null
          : (chewieController ?? this.chewieController),
      isPlaying: isPlaying ?? this.isPlaying,
      streamMimeType: clearActive
          ? null
          : (streamMimeType ?? this.streamMimeType),
      streamLabel: clearActive ? null : (streamLabel ?? this.streamLabel),
      streamSource: clearActive ? null : (streamSource ?? this.streamSource),
      startupLatencyMs: clearActive
          ? null
          : (startupLatencyMs ?? this.startupLatencyMs),
      prewarmAttempted: clearActive
          ? null
          : (prewarmAttempted ?? this.prewarmAttempted),
      prewarmSucceeded: clearActive
          ? null
          : (prewarmSucceeded ?? this.prewarmSucceeded),
      prewarmLatencyMs: clearActive
          ? null
          : (prewarmLatencyMs ?? this.prewarmLatencyMs),
    );
  }
}

@riverpod
class PlayerState extends _$PlayerState {
  @override
  GlobalPlayerState build() {
    ref.onDispose(() {
      _disposeControllers();
    });
    return GlobalPlayerState();
  }

  Future<void> playScene(
    Scene scene,
    String streamUrl, {
    String? mimeType,
    String? streamLabel,
    String? streamSource,
    Map<String, String>? httpHeaders,
    bool? prewarmAttempted,
    bool? prewarmSucceeded,
    int? prewarmLatencyMs,
  }) async {
    if (state.activeScene?.id == scene.id &&
        state.videoPlayerController != null) {
      state.videoPlayerController?.play();
      state = state.copyWith(
        isPlaying: true,
        streamMimeType: mimeType,
        streamLabel: streamLabel,
        streamSource: streamSource,
        prewarmAttempted: prewarmAttempted,
        prewarmSucceeded: prewarmSucceeded,
        prewarmLatencyMs: prewarmLatencyMs,
      );
      return;
    }

    // Stop current
    await _disposeControllers();

    final stopwatch = Stopwatch()..start();
    final videoController = VideoPlayerController.networkUrl(
      Uri.parse(streamUrl),
      httpHeaders: httpHeaders ?? const <String, String>{},
    );

    state = state.copyWith(
      activeScene: scene,
      videoPlayerController: videoController,
      isPlaying: false,
      streamMimeType: mimeType,
      streamLabel: streamLabel,
      streamSource: streamSource,
      startupLatencyMs: null,
      prewarmAttempted: prewarmAttempted,
      prewarmSucceeded: prewarmSucceeded,
      prewarmLatencyMs: prewarmLatencyMs,
    );

    try {
      await videoController.initialize();
      stopwatch.stop();

      final chewieController = ChewieController(
        videoPlayerController: videoController,
        autoPlay: true,
        looping: false,
        aspectRatio: videoController.value.aspectRatio,
        allowFullScreen: true,
        placeholder: Container(color: Colors.black),
      );

      state = state.copyWith(
        chewieController: chewieController,
        isPlaying: true,
        startupLatencyMs: stopwatch.elapsedMilliseconds,
      );

      videoController.addListener(_videoListener);
    } catch (e) {
      debugPrint('Error initializing video player: $e');
      stop();
    }
  }

  void togglePlayPause() {
    final controller = state.videoPlayerController;
    if (controller != null) {
      if (controller.value.isPlaying) {
        controller.pause();
        state = state.copyWith(isPlaying: false);
      } else {
        controller.play();
        state = state.copyWith(isPlaying: true);
      }
    }
  }

  void stop() {
    _disposeControllers();
    state = GlobalPlayerState();
  }

  Future<void> _disposeControllers() async {
    state.videoPlayerController?.removeListener(_videoListener);
    state.chewieController?.dispose();
    await state.videoPlayerController?.dispose();
  }

  void _videoListener() {
    final controller = state.videoPlayerController;
    if (controller != null) {
      if (controller.value.isPlaying != state.isPlaying) {
        state = state.copyWith(isPlaying: controller.value.isPlaying);
      }
    }
  }
}

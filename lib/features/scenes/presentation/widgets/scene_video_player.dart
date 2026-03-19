import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/video_player_provider.dart';
import '../../domain/entities/scene.dart';

class SceneVideoPlayer extends ConsumerWidget {
  final Scene scene;
  const SceneVideoPlayer({required this.scene, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerStateProvider);

    if (playerState.activeScene?.id != scene.id) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.black,
          child: Center(
            child: IconButton(
              icon: const Icon(Icons.play_arrow, size: 64, color: Colors.white),
              onPressed: () {
                // We need the stream URL.
                // For now, we'll use a placeholder or assume the repository provides it.
                // TODO: Fetch stream URL via repository if not already in scene.paths.stream
                final streamUrl = scene.paths.stream ?? '';
                if (streamUrl.isNotEmpty) {
                  ref
                      .read(playerStateProvider.notifier)
                      .playScene(scene, streamUrl);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No stream URL available')),
                  );
                }
              },
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
      child: Chewie(controller: chewieController),
    );
  }
}

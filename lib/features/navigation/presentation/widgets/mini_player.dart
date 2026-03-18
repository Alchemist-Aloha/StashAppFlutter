import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../scenes/presentation/providers/video_player_provider.dart';

class MiniPlayer extends ConsumerWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeScene = ref.watch(playerStateProvider);
    if (activeScene == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () => context.push('/scene/${activeScene.id}'),
      child: Container(
        height: 60,
        color: Colors.grey[900],
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(activeScene.thumbUrl ?? '', fit: BoxFit.cover, errorBuilder: (c, e, s) => const Placeholder()),
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(activeScene.title, maxLines: 1, overflow: TextOverflow.ellipsis)),
            IconButton(onPressed: () => ref.read(playerStateProvider.notifier).stop(), icon: const Icon(Icons.close)),
          ],
        ),
      ),
    );
  }
}

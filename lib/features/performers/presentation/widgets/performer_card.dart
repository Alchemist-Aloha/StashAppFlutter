import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/widgets/stash_image.dart';
import '../../domain/entities/performer.dart';
import '../../../../core/presentation/theme/app_theme.dart';

class PerformerCard extends ConsumerWidget {
  final Performer performer;
  final VoidCallback? onTap;

  const PerformerCard({required this.performer, this.onTap, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: ClipOval(
              child: AspectRatio(
                aspectRatio: 1,
                child: StashImage(
                  imageUrl: performer.imagePath ?? '',
                  fit: BoxFit.cover,
                  memCacheWidth: 200,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            performer.name,
            style: TextStyle(
              color: context.colors.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${performer.sceneCount} scenes',
            style: TextStyle(
              color: context.colors.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

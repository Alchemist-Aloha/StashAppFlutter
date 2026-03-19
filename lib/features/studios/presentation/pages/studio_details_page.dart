import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/data/graphql/media_headers_provider.dart';
import '../providers/studio_media_provider.dart';
import '../providers/studio_details_provider.dart';

class StudioDetailsPage extends ConsumerWidget {
  final String studioId;

  const StudioDetailsPage({required this.studioId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studioAsync = ref.watch(studioDetailsProvider(studioId));
    final mediaAsync = ref.watch(studioMediaProvider(studioId));
    final mediaHeaders = ref.watch(mediaHeadersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Studio Details')),
      body: studioAsync.when(
        data: (studio) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 240,
                width: double.infinity,
                color: Colors.grey[900],
                child: studio.imagePath != null && studio.imagePath!.isNotEmpty
                    ? Image.network(
                        studio.imagePath!,
                        headers: mediaHeaders,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                              child: Icon(
                                Icons.apartment,
                                size: 72,
                                color: Colors.white54,
                              ),
                            ),
                      )
                    : const Center(
                        child: Icon(
                          Icons.apartment,
                          size: 72,
                          color: Colors.white54,
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      studio.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _statRow('Scenes', studio.sceneCount.toString()),
                    _statRow('Performers', studio.performerCount.toString()),
                    _statRow('Images', studio.imageCount.toString()),
                    _statRow('Galleries', studio.galleryCount.toString()),
                    if (studio.rating100 != null)
                      _statRow('Rating', studio.rating100.toString()),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          'Media',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () =>
                              context.push('/studio/${studio.id}/media'),
                          child: const Text('View all'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    mediaAsync.when(
                      data: (mediaItems) {
                        if (mediaItems.isEmpty) {
                          return const Text(
                            'No media available.',
                            style: TextStyle(color: Colors.white70),
                          );
                        }

                        return SizedBox(
                          height: 138,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: mediaItems.length,
                            separatorBuilder: (_, index) =>
                                const SizedBox(width: 10),
                            itemBuilder: (context, index) {
                              final item = mediaItems[index];
                              return InkWell(
                                onTap: () =>
                                    context.push('/scene/${item.sceneId}'),
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          item.thumbnailUrl,
                                          headers: mediaHeaders,
                                          width: 200,
                                          height: 112,
                                          fit: BoxFit.cover,
                                          errorBuilder: (c, e, s) => Container(
                                            width: 200,
                                            height: 112,
                                            color: Colors.grey[800],
                                            child: const Icon(
                                              Icons.movie,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        item.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      loading: () => const SizedBox(
                        height: 60,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      error: (err, stack) => Text(
                        'Failed to load media: $err',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                    if (studio.details != null &&
                        studio.details!.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      const Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        studio.details!,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _statRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

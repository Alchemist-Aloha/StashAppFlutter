import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/data/graphql/media_headers_provider.dart';
import '../providers/tag_media_provider.dart';
import '../providers/tag_details_provider.dart';

class TagDetailsPage extends ConsumerWidget {
  final String tagId;

  const TagDetailsPage({required this.tagId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagAsync = ref.watch(tagDetailsProvider(tagId));
    final mediaAsync = ref.watch(tagMediaProvider(tagId));
    final mediaHeaders = ref.watch(mediaHeadersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Tag Details')),
      body: tagAsync.when(
        data: (tag) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 240,
                width: double.infinity,
                color: Colors.grey[900],
                child: tag.imagePath != null && tag.imagePath!.isNotEmpty
                    ? Image.network(
                        tag.imagePath!,
                        headers: mediaHeaders,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                              child: Icon(
                                Icons.local_offer,
                                size: 72,
                                color: Colors.white54,
                              ),
                            ),
                      )
                    : const Center(
                        child: Icon(
                          Icons.local_offer,
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
                      tag.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _statRow('Scenes', tag.sceneCount.toString()),
                    _statRow('Images', tag.imageCount.toString()),
                    _statRow('Galleries', tag.galleryCount.toString()),
                    _statRow('Performers', tag.performerCount.toString()),
                    const SizedBox(height: 20),
                    const Text(
                      'Media',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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
                    if (tag.description != null &&
                        tag.description!.trim().isNotEmpty) ...[
                      const SizedBox(height: 20),
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tag.description!,
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

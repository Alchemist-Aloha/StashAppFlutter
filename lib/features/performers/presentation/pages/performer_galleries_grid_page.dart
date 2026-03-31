import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/widgets/list_page_scaffold.dart';
import '../../../../core/presentation/widgets/media_widgets.dart';
import '../../../../core/data/graphql/media_headers_provider.dart';
import '../providers/performer_galleries_provider.dart';
import '../../galleries/domain/entities/gallery.dart';
import 'package:go_router/go_router.dart';
import '../../images/presentation/providers/image_list_provider.dart';

class PerformerGalleriesGridPage extends ConsumerWidget {
  final String performerId;

  const PerformerGalleriesGridPage({required this.performerId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final galleriesAsync = ref.watch(performerGalleriesProvider(performerId));
    final mediaHeaders = ref.watch(mediaHeadersProvider);

    return ListPageScaffold<PerformerGalleryItem>(
      title: 'Performer Galleries',
      searchHint: 'Search galleries...',
      onSearchChanged: (query) {
        // TODO: Implement search if needed, but performerGalleries is simple right now
      },
      provider: galleriesAsync,
      onRefresh: () => ref.refresh(performerGalleriesProvider(performerId).future),
      itemBuilder: (context, item) {
        return MediaCard(
          title: item.title,
          imageUrl: item.thumbnailUrl,
          imageHeaders: mediaHeaders,
          onTap: () {
            ref.read(imageFilterStateProvider.notifier).setGalleryId(item.galleryId);
            context.push('/galleries/images');
          },
        );
      },
    );
  }
}

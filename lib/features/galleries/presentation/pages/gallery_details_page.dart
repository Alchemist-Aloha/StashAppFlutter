import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/theme/app_theme.dart';
import '../../../../core/presentation/widgets/error_state_view.dart';
import '../../../../core/presentation/widgets/stash_image.dart';
import '../../../../core/utils/l10n_extensions.dart';
import '../../../images/presentation/pages/images_page.dart';
import '../../../images/presentation/providers/image_list_provider.dart';
import '../../domain/entities/gallery.dart';
import '../providers/gallery_details_provider.dart';
import '../providers/gallery_list_provider.dart';

/// Browses a gallery's images with compact, scroll-collapsing gallery details.
class GalleryDetailsPage extends ConsumerStatefulWidget {
  const GalleryDetailsPage({required this.galleryId, super.key});

  final String galleryId;

  @override
  ConsumerState<GalleryDetailsPage> createState() => _GalleryDetailsPageState();
}

class _GalleryDetailsPageState extends ConsumerState<GalleryDetailsPage> {
  late final ScrollController _scrollController;
  var _detailsCollapsed = false;
  var _collapseOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_handleScroll);
    _scheduleGalleryImages();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _collapseOffset = context.dimensions.spacingLarge * 2;
  }

  @override
  void didUpdateWidget(covariant GalleryDetailsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.galleryId == widget.galleryId) return;
    _scheduleGalleryImages();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.dispose();
  }

  void _scheduleGalleryImages() {
    final galleryId = widget.galleryId;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || galleryId != widget.galleryId) return;
      ref.read(imageFilterStateProvider.notifier).setGalleryId(galleryId);
    });
  }

  void _handleScroll() {
    final shouldCollapse = _scrollController.offset > _collapseOffset;
    if (shouldCollapse == _detailsCollapsed || !mounted) return;
    setState(() => _detailsCollapsed = shouldCollapse);
  }

  Future<void> _refresh() async {
    await ref
        .read(galleryRepositoryProvider)
        .getGalleryById(widget.galleryId, refresh: true);
    ref.invalidate(galleryDetailsProvider(widget.galleryId));
    await Future.wait([
      ref.read(galleryDetailsProvider(widget.galleryId).future),
      ref.read(imageListProvider.notifier).refresh(),
    ]);
  }

  void _expandDetails() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final galleryAsync = ref.watch(galleryDetailsProvider(widget.galleryId));

    return ImagesPage(
      title:
          galleryAsync.asData?.value.displayName ??
          context.l10n.details_gallery,
      topContent: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.topCenter,
        child: galleryAsync.when(
          data: (gallery) => _detailsCollapsed
              ? _CollapsedGalleryDetails(
                  key: const Key('gallery_details_collapsed'),
                  gallery: gallery,
                  onExpand: _expandDetails,
                )
              : _CompactGalleryDetails(
                  key: const Key('gallery_details_expanded'),
                  gallery: gallery,
                ),
          loading: () => const LinearProgressIndicator(),
          error: (error, stack) => ErrorStateView(
            message: context.l10n.common_error(error.toString()),
            onRetry: () =>
                ref.invalidate(galleryDetailsProvider(widget.galleryId)),
          ),
        ),
      ),
      scrollController: _scrollController,
      onRefresh: _refresh,
    );
  }
}

class _CollapsedGalleryDetails extends StatelessWidget {
  const _CollapsedGalleryDetails({
    required this.gallery,
    required this.onExpand,
    super.key,
  });

  final Gallery gallery;
  final VoidCallback onExpand;

  @override
  Widget build(BuildContext context) {
    final dims = context.dimensions;
    final subtitle = [
      if (gallery.studioName?.trim().isNotEmpty == true) gallery.studioName!,
      if (gallery.date?.trim().isNotEmpty == true) gallery.date!,
      '${gallery.imageCount ?? 0} ${context.l10n.images_title}',
    ].join(' • ');

    return Card(
      margin: EdgeInsets.fromLTRB(
        dims.spacingSmall,
        dims.spacingSmall,
        dims.spacingSmall,
        0,
      ),
      child: ListTile(
        dense: true,
        title: Text(
          gallery.displayName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: IconButton(
          tooltip: context.l10n.details_show_more,
          onPressed: onExpand,
          icon: const Icon(Icons.expand_more_rounded),
        ),
      ),
    );
  }
}

class _CompactGalleryDetails extends StatelessWidget {
  const _CompactGalleryDetails({required this.gallery, super.key});

  final Gallery gallery;

  @override
  Widget build(BuildContext context) {
    final dims = context.dimensions;
    final hasCover = gallery.coverPath?.trim().isNotEmpty == true;

    return Card(
      margin: EdgeInsets.fromLTRB(
        dims.spacingSmall,
        dims.spacingSmall,
        dims.spacingSmall,
        0,
      ),
      elevation: 0,
      color: Theme.of(
        context,
      ).colorScheme.primaryContainer.withValues(alpha: 0.12),
      child: Padding(
        padding: EdgeInsets.all(dims.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(dims.spacingSmall),
                  child: SizedBox.square(
                    dimension: dims.buttonHeight * 1.75,
                    child: hasCover
                        ? StashImage(
                            imageUrl: gallery.coverPath!,
                            fit: BoxFit.cover,
                            memCacheWidth: 240,
                          )
                        : ColoredBox(
                            color: context.colors.surfaceVariant,
                            child: Icon(
                              Icons.photo_library_outlined,
                              size: dims.buttonHeight,
                            ),
                          ),
                  ),
                ),
                SizedBox(width: dims.spacingMedium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gallery.displayName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: dims.spacingSmall),
                      Wrap(
                        spacing: dims.spacingSmall,
                        runSpacing: dims.spacingSmall,
                        children: [
                          if (gallery.date?.trim().isNotEmpty == true)
                            Chip(label: Text(gallery.date!)),
                          if (gallery.rating100 != null)
                            Chip(
                              avatar: Icon(
                                Icons.star_rounded,
                                size: dims.performerAvatarSize,
                                color: context.colors.ratingColor,
                              ),
                              label: Text(
                                (gallery.rating100! / 20).toStringAsFixed(1),
                              ),
                            ),
                          Chip(
                            avatar: const Icon(Icons.image_outlined),
                            label: Text('${gallery.imageCount ?? 0}'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (gallery.details?.trim().isNotEmpty == true) ...[
              SizedBox(height: dims.spacingSmall),
              Text(
                gallery.details!.trim(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyMedium,
              ),
            ],
            if (gallery.studioName?.trim().isNotEmpty == true) ...[
              SizedBox(height: dims.spacingSmall),
              ActionChip(
                avatar: const Icon(Icons.business_outlined),
                label: Text(gallery.studioName!),
                onPressed: gallery.studioId == null
                    ? null
                    : () => context.push('/studios/studio/${gallery.studioId}'),
              ),
            ],
            if (gallery.performerNames.isNotEmpty) ...[
              SizedBox(height: dims.spacingSmall),
              Text(
                context.l10n.performers_title,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: dims.spacingSmall),
              Wrap(
                spacing: dims.spacingSmall,
                runSpacing: dims.spacingSmall,
                children: List.generate(
                  gallery.performerNames.length,
                  (index) => ActionChip(
                    avatar: const Icon(Icons.person_outline),
                    label: Text(gallery.performerNames[index]),
                    onPressed: index < gallery.performerIds.length
                        ? () => context.push(
                            '/performers/performer/${gallery.performerIds[index]}',
                          )
                        : null,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

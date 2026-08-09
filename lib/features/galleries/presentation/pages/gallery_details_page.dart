import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/theme/app_theme.dart';
import '../../../../core/presentation/widgets/error_state_view.dart';
import '../../../../core/presentation/widgets/stash_image.dart';
import '../../../../core/utils/l10n_extensions.dart';
import '../../../images/presentation/providers/image_list_provider.dart';
import '../../../images/presentation/widgets/image_card.dart';
import '../../../scenes/presentation/widgets/scene_strip.dart';
import '../../domain/entities/gallery.dart';
import '../providers/gallery_details_provider.dart';
import '../providers/gallery_list_provider.dart';

class GalleryDetailsPage extends ConsumerStatefulWidget {
  const GalleryDetailsPage({required this.galleryId, super.key});

  final String galleryId;

  @override
  ConsumerState<GalleryDetailsPage> createState() => _GalleryDetailsPageState();
}

class _GalleryDetailsPageState extends ConsumerState<GalleryDetailsPage> {
  int _selectedTab = 0;

  Future<void> _refresh() async {
    await ref
        .read(galleryRepositoryProvider)
        .getGalleryById(widget.galleryId, refresh: true);
    ref.invalidate(galleryDetailsProvider(widget.galleryId));
    ref.invalidate(galleryImagesProvider(widget.galleryId));
    ref.invalidate(galleryScenesProvider(widget.galleryId));
    await ref.read(galleryDetailsProvider(widget.galleryId).future);
  }

  void _openGalleryImages([String? imageId]) {
    ref.read(imageFilterStateProvider.notifier).setGalleryId(widget.galleryId);
    ref.invalidate(imageListProvider);
    context.push(
      imageId == null ? '/galleries/images' : '/galleries/images/$imageId',
    );
  }

  @override
  Widget build(BuildContext context) {
    final galleryAsync = ref.watch(galleryDetailsProvider(widget.galleryId));

    return DefaultTabController(
      length: 4,
      initialIndex: _selectedTab,
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.details_gallery)),
        body: galleryAsync.when(
          data: (gallery) => RefreshIndicator(
            onRefresh: _refresh,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: _GalleryHeader(gallery: gallery)),
                SliverToBoxAdapter(
                  child: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    onTap: (index) => setState(() => _selectedTab = index),
                    tabs: [
                      Tab(text: context.l10n.common_details),
                      Tab(
                        text:
                            '${context.l10n.images_title} (${gallery.imageCount ?? 0})',
                      ),
                      Tab(
                        text:
                            '${context.l10n.gallery_chapters_title} (${gallery.chapters.length})',
                      ),
                      Tab(text: context.l10n.scenes_title),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(context.dimensions.spacingMedium),
                  sliver: SliverToBoxAdapter(
                    child: switch (_selectedTab) {
                      0 => _GalleryDetailsTab(gallery: gallery),
                      1 => _buildImagesTab(),
                      2 => _GalleryChaptersTab(chapters: gallery.chapters),
                      _ => _buildScenesTab(),
                    },
                  ),
                ),
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => ErrorStateView(
            message: context.l10n.common_error(error.toString()),
            onRetry: () =>
                ref.refresh(galleryDetailsProvider(widget.galleryId)),
          ),
        ),
      ),
    );
  }

  Widget _buildImagesTab() {
    final imagesAsync = ref.watch(galleryImagesProvider(widget.galleryId));
    return imagesAsync.when(
      data: (images) {
        if (images.isEmpty) return _EmptyRelation(icon: Icons.image_outlined);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: _openGalleryImages,
                icon: const Icon(Icons.open_in_new_rounded),
                label: Text(context.l10n.common_view_all),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth >= 900
                    ? 5
                    : constraints.maxWidth >= 600
                    ? 4
                    : 2;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                  ),
                  itemCount: images.length,
                  itemBuilder: (context, index) => ImageCard(
                    image: images[index],
                    onTap: () => _openGalleryImages(images[index].id),
                  ),
                );
              },
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => ErrorStateView(
        message: context.l10n.common_error(error.toString()),
        onRetry: () => ref.refresh(galleryImagesProvider(widget.galleryId)),
      ),
    );
  }

  Widget _buildScenesTab() {
    final scenesAsync = ref.watch(galleryScenesProvider(widget.galleryId));
    return scenesAsync.when(
      data: (scenes) => scenes.isEmpty
          ? const _EmptyRelation(icon: Icons.movie_outlined)
          : SceneStrip(
              scenes: scenes,
              onTap: (scene) =>
                  context.push('/scenes/scene/${scene.id}', extra: true),
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => ErrorStateView(
        message: context.l10n.common_error(error.toString()),
        onRetry: () => ref.refresh(galleryScenesProvider(widget.galleryId)),
      ),
    );
  }
}

class _GalleryHeader extends StatelessWidget {
  const _GalleryHeader({required this.gallery});

  final Gallery gallery;

  @override
  Widget build(BuildContext context) {
    final dims = context.dimensions;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 240 * dims.fontSizeFactor,
          width: double.infinity,
          child: gallery.coverPath?.isNotEmpty == true
              ? StashImage(
                  imageUrl: gallery.coverPath!,
                  fit: BoxFit.cover,
                  memCacheWidth: 900,
                )
              : ColoredBox(
                  color: context.colors.surfaceVariant,
                  child: Icon(
                    Icons.photo_library_outlined,
                    size: 72 * dims.fontSizeFactor,
                    color: context.colors.onSurfaceVariant.withValues(
                      alpha: 0.5,
                    ),
                  ),
                ),
        ),
        Padding(
          padding: EdgeInsets.all(dims.spacingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                gallery.displayName,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: dims.spacingSmall),
              Wrap(
                spacing: dims.spacingSmall,
                runSpacing: dims.spacingSmall,
                children: [
                  if (gallery.date?.isNotEmpty == true)
                    Chip(label: Text(gallery.date!)),
                  if (gallery.rating100 != null)
                    Chip(
                      avatar: Icon(
                        Icons.star_rounded,
                        size: 18 * dims.fontSizeFactor,
                        color: context.colors.ratingColor,
                      ),
                      label: Text((gallery.rating100! / 20).toStringAsFixed(1)),
                    ),
                  Chip(
                    label: Text(
                      '${gallery.imageCount ?? 0} ${context.l10n.images_title}',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GalleryDetailsTab extends StatelessWidget {
  const _GalleryDetailsTab({required this.gallery});

  final Gallery gallery;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[
      if (gallery.code?.trim().isNotEmpty == true)
        _DetailRow(
          icon: Icons.qr_code_rounded,
          label: context.l10n.gallery_code_title,
          value: gallery.code!,
        ),
      if (gallery.photographer?.trim().isNotEmpty == true)
        _DetailRow(
          icon: Icons.camera_alt_outlined,
          label: context.l10n.gallery_photographer_title,
          value: gallery.photographer!,
        ),
      if (gallery.filePaths.isNotEmpty)
        _DetailRow(
          icon: Icons.folder_outlined,
          label: context.l10n.files,
          value: gallery.filePaths.join('\n'),
        ),
      if (gallery.urls.isNotEmpty)
        _DetailRow(
          icon: Icons.link_rounded,
          label: context.l10n.common_url,
          value: gallery.urls.join('\n'),
        ),
      if (gallery.organized != null)
        _DetailRow(
          icon: Icons.inventory_2_outlined,
          label: context.l10n.organized_title,
          value: gallery.organized!
              ? context.l10n.common_yes
              : context.l10n.common_no,
        ),
      if (gallery.createdAt?.isNotEmpty == true)
        _DetailRow(
          icon: Icons.add_circle_outline_rounded,
          label: context.l10n.created_at_title,
          value: gallery.createdAt!,
        ),
      if (gallery.updatedAt?.isNotEmpty == true)
        _DetailRow(
          icon: Icons.update_rounded,
          label: context.l10n.updated_at_title,
          value: gallery.updatedAt!,
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (gallery.details?.trim().isNotEmpty == true)
          _DetailCard(child: Text(gallery.details!)),
        if (rows.isNotEmpty) _DetailCard(child: Column(children: rows)),
        if (gallery.studioName?.trim().isNotEmpty == true)
          _DetailCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.business_outlined),
              title: Text(context.l10n.studios_title),
              subtitle: Text(gallery.studioName!),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: gallery.studioId == null
                  ? null
                  : () => context.push('/studios/studio/${gallery.studioId}'),
            ),
          ),
        if (gallery.performerNames.isNotEmpty)
          _RelationshipChips(
            title: context.l10n.performers_title,
            names: gallery.performerNames,
            onTap: (index) => context.push(
              '/performers/performer/${gallery.performerIds[index]}',
            ),
          ),
        if (gallery.tagNames.isNotEmpty)
          _RelationshipChips(
            title: context.l10n.details_tags,
            names: gallery.tagNames,
            onTap: (index) =>
                context.push('/tags/tag/${gallery.tagIds[index]}'),
          ),
      ],
    );
  }
}

class _GalleryChaptersTab extends StatelessWidget {
  const _GalleryChaptersTab({required this.chapters});

  final List<GalleryChapter> chapters;

  @override
  Widget build(BuildContext context) {
    if (chapters.isEmpty) {
      return const _EmptyRelation(icon: Icons.bookmarks_outlined);
    }
    return _DetailCard(
      child: Column(
        children: chapters
            .map(
              (chapter) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.bookmark_outline_rounded),
                title: Text(chapter.title),
                subtitle: Text(
                  context.l10n.gallery_chapter_image(chapter.imageIndex),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _RelationshipChips extends StatelessWidget {
  const _RelationshipChips({
    required this.title,
    required this.names,
    required this.onTap,
  });

  final String title;
  final List<String> names;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final dims = context.dimensions;
    return _DetailCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.textTheme.titleSmall),
          SizedBox(height: dims.spacingSmall),
          Wrap(
            spacing: dims.spacingSmall,
            runSpacing: dims.spacingSmall,
            children: List.generate(
              names.length,
              (index) => ActionChip(
                label: Text(names[index]),
                onPressed: () => onTap(index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.only(bottom: context.dimensions.spacingMedium),
    elevation: 0,
    color: Theme.of(
      context,
    ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
    child: Padding(
      padding: EdgeInsets.all(context.dimensions.spacingMedium),
      child: child,
    ),
  );
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Icon(icon),
    title: Text(label),
    subtitle: Text(value),
  );
}

class _EmptyRelation extends StatelessWidget {
  const _EmptyRelation({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: context.dimensions.spacingLarge),
    child: Column(
      children: [
        Icon(
          icon,
          size: 48 * context.dimensions.fontSizeFactor,
          color: context.colors.onSurfaceVariant,
        ),
        SizedBox(height: context.dimensions.spacingSmall),
        Text(context.l10n.common_no_items),
      ],
    ),
  );
}

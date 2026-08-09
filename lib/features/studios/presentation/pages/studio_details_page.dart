import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/theme/app_theme.dart';
import '../../../../core/presentation/widgets/error_state_view.dart';
import '../../../../core/presentation/widgets/stash_image.dart';
import '../../../../core/utils/l10n_extensions.dart';
import '../../../galleries/presentation/providers/entity_gallery_filter_scope.dart';
import '../../../galleries/presentation/widgets/gallery_strip.dart';
import '../../../images/presentation/providers/image_list_provider.dart';
import '../../../images/presentation/widgets/image_card.dart';
import '../../../scenes/domain/entities/scene.dart';
import '../../../scenes/presentation/providers/entity_media_filter_scope.dart';
import '../../../scenes/presentation/providers/playback_queue_provider.dart';
import '../../../scenes/presentation/widgets/scene_strip.dart';
import '../../../setup/presentation/providers/navigation_customization_provider.dart';
import '../../domain/entities/studio.dart';
import '../providers/studio_details_provider.dart';
import '../providers/studio_list_provider.dart';
import '../providers/studio_random_navigation_provider.dart';

class StudioDetailsPage extends ConsumerStatefulWidget {
  const StudioDetailsPage({required this.studioId, super.key});

  final String studioId;

  @override
  ConsumerState<StudioDetailsPage> createState() => _StudioDetailsPageState();
}

class _StudioDetailsPageState extends ConsumerState<StudioDetailsPage> {
  int _selectedTab = 0;

  Future<void> _openRandomStudio() async {
    final randomStudio = await ref
        .read(studioRandomNavigationControllerProvider)
        .getRandomStudio(excludeStudioId: widget.studioId);
    if (!mounted) return;
    if (randomStudio == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.studios_no_random)));
      return;
    }
    context.push('/studios/studio/${randomStudio.id}');
  }

  Future<void> _refresh() async {
    ref.invalidate(studioDetailsProvider(widget.studioId));
    ref.invalidate(
      entityMediaPreviewProvider(EntityMediaFilterKind.studio, widget.studioId),
    );
    ref.invalidate(
      entityGalleryPreviewProvider(
        EntityGalleryFilterKind.studio,
        widget.studioId,
      ),
    );
    ref.invalidate(studioImagesProvider(widget.studioId));
    await ref.read(studioDetailsProvider(widget.studioId).future);
  }

  void _openStudioImages([String? imageId]) {
    final filter = imageFilterForEntityGalleries(
      kind: EntityGalleryFilterKind.studio,
      entityId: widget.studioId,
    );
    final notifier = ref.read(imageFilterStateProvider.notifier);
    notifier.updateFilter(filter);
    notifier.clearGalleryId();
    ref.invalidate(imageListProvider);
    context.push(
      imageId == null ? '/galleries/images' : '/galleries/images/$imageId',
    );
  }

  @override
  Widget build(BuildContext context) {
    final studioAsync = ref.watch(studioDetailsProvider(widget.studioId));
    final randomNavigationEnabled = ref.watch(randomNavigationEnabledProvider);

    return DefaultTabController(
      length: 5,
      initialIndex: _selectedTab,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.details_studio),
          actions: [
            studioAsync.maybeWhen(
              data: (studio) => IconButton(
                tooltip: context.l10n.common_edit,
                icon: const Icon(Icons.edit_outlined),
                onPressed: () => context.push(
                  '/studios/studio/${studio.id}/edit',
                  extra: studio,
                ),
              ),
              orElse: () => const SizedBox.shrink(),
            ),
          ],
        ),
        floatingActionButton: randomNavigationEnabled
            ? FloatingActionButton.small(
                onPressed: _openRandomStudio,
                tooltip: context.l10n.random_studio,
                child: const Icon(Icons.casino_outlined),
              )
            : null,
        body: studioAsync.when(
          data: (studio) => RefreshIndicator(
            onRefresh: _refresh,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: _StudioHeader(
                    studio: studio,
                    onToggleFavorite: () => _toggleFavorite(studio),
                  ),
                ),
                SliverToBoxAdapter(
                  child: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    onTap: (index) => setState(() => _selectedTab = index),
                    tabs: [
                      Tab(text: context.l10n.common_details),
                      Tab(
                        text:
                            '${context.l10n.scenes_title} (${studio.sceneCount})',
                      ),
                      Tab(
                        text:
                            '${context.l10n.details_galleries} (${studio.galleryCount})',
                      ),
                      Tab(
                        text:
                            '${context.l10n.images_title} (${studio.imageCount})',
                      ),
                      Tab(
                        text:
                            '${context.l10n.studio_hierarchy_title} (${studio.childStudios.length})',
                      ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(context.dimensions.spacingMedium),
                  sliver: SliverToBoxAdapter(
                    child: switch (_selectedTab) {
                      0 => _StudioDetailsTab(studio: studio),
                      1 => _buildScenesTab(studio),
                      2 => _buildGalleriesTab(studio),
                      3 => _buildImagesTab(),
                      _ => _StudioHierarchyTab(studio: studio),
                    },
                  ),
                ),
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => ErrorStateView(
            message: context.l10n.common_error(error.toString()),
            onRetry: () => ref.refresh(studioDetailsProvider(widget.studioId)),
          ),
        ),
      ),
    );
  }

  Future<void> _toggleFavorite(Studio studio) async {
    try {
      await ref
          .read(studioRepositoryProvider)
          .setStudioFavorite(studio.id, !studio.favorite);
      ref.invalidate(studioDetailsProvider(studio.id));
      ref.invalidate(studioListProvider);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.l10n.details_failed_update_favorite(error.toString()),
          ),
        ),
      );
    }
  }

  Widget _buildScenesTab(Studio studio) {
    final mediaAsync = ref.watch(
      entityMediaPreviewProvider(EntityMediaFilterKind.studio, widget.studioId),
    );
    return mediaAsync.when(
      data: (scenes) {
        if (scenes.isEmpty) {
          return const _StudioEmpty(icon: Icons.movie_outlined);
        }
        final List<Scene> shuffled = scenes.toList()
          ..shuffle(Random(studio.id.hashCode));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () =>
                    context.push('/studios/studio/${studio.id}/media'),
                icon: const Icon(Icons.open_in_new_rounded),
                label: Text(context.l10n.common_view_all),
              ),
            ),
            SceneStrip(
              scenes: shuffled,
              queueId: PlaybackQueueIds.studioStrip(studio.id),
              onTap: (scene) =>
                  context.push('/scenes/scene/${scene.id}', extra: true),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => ErrorStateView(
        message: context.l10n.common_error(error.toString()),
        onRetry: () => ref.refresh(
          entityMediaPreviewProvider(
            EntityMediaFilterKind.studio,
            widget.studioId,
          ),
        ),
      ),
    );
  }

  Widget _buildGalleriesTab(Studio studio) {
    final galleriesAsync = ref.watch(
      entityGalleryPreviewProvider(
        EntityGalleryFilterKind.studio,
        widget.studioId,
      ),
    );
    return galleriesAsync.when(
      data: (galleries) => galleries.isEmpty
          ? const _StudioEmpty(icon: Icons.photo_library_outlined)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () =>
                        context.push('/studios/studio/${studio.id}/galleries'),
                    icon: const Icon(Icons.open_in_new_rounded),
                    label: Text(context.l10n.common_view_all),
                  ),
                ),
                GalleryStrip(
                  galleries: galleries,
                  onTap: (gallery) =>
                      context.push('/galleries/gallery/${gallery.id}'),
                ),
              ],
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => ErrorStateView(
        message: context.l10n.common_error(error.toString()),
        onRetry: () => ref.refresh(
          entityGalleryPreviewProvider(
            EntityGalleryFilterKind.studio,
            widget.studioId,
          ),
        ),
      ),
    );
  }

  Widget _buildImagesTab() {
    final imagesAsync = ref.watch(studioImagesProvider(widget.studioId));
    return imagesAsync.when(
      data: (images) {
        if (images.isEmpty) {
          return const _StudioEmpty(icon: Icons.image_outlined);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: _openStudioImages,
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
                    onTap: () => _openStudioImages(images[index].id),
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
        onRetry: () => ref.refresh(studioImagesProvider(widget.studioId)),
      ),
    );
  }
}

class _StudioHeader extends StatelessWidget {
  const _StudioHeader({required this.studio, required this.onToggleFavorite});

  final Studio studio;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final dims = context.dimensions;
    final hasImage =
        studio.imagePath?.isNotEmpty == true &&
        !studio.imagePath!.contains('default=true');
    return Column(
      children: [
        if (hasImage)
          SizedBox(
            height: 200 * dims.fontSizeFactor,
            width: double.infinity,
            child: ColoredBox(
              color: context.colors.surfaceVariant,
              child: StashImage(
                imageUrl: studio.imagePath!,
                fit: BoxFit.contain,
                memCacheWidth: 600,
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.all(dims.spacingMedium),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  studio.name,
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton.filledTonal(
                icon: Icon(
                  studio.favorite ? Icons.favorite : Icons.favorite_border,
                ),
                tooltip: studio.favorite
                    ? context.l10n.common_remove_favorite
                    : context.l10n.common_add_favorite,
                onPressed: onToggleFavorite,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StudioDetailsTab extends StatelessWidget {
  const _StudioDetailsTab({required this.studio});

  final Studio studio;

  @override
  Widget build(BuildContext context) {
    final urls = studio.urls.isNotEmpty
        ? studio.urls
        : [if (studio.url?.trim().isNotEmpty == true) studio.url!];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (studio.details?.trim().isNotEmpty == true)
          _StudioCard(child: Text(studio.details!)),
        _StudioCard(
          child: Column(
            children: [
              if (urls.isNotEmpty)
                _StudioDetailRow(
                  icon: Icons.link_rounded,
                  label: context.l10n.common_url,
                  value: urls.join('\n'),
                ),
              if (studio.aliases.isNotEmpty)
                _StudioDetailRow(
                  icon: Icons.alternate_email_rounded,
                  label: context.l10n.common_aliases,
                  value: studio.aliases.join(', '),
                ),
              _StudioDetailRow(
                icon: Icons.inventory_2_outlined,
                label: context.l10n.organized_title,
                value: studio.organized
                    ? context.l10n.common_yes
                    : context.l10n.common_no,
              ),
              _StudioDetailRow(
                icon: Icons.auto_awesome_outlined,
                label: context.l10n.filter_ignore_auto_tag,
                value: studio.ignoreAutoTag
                    ? context.l10n.common_yes
                    : context.l10n.common_no,
              ),
              if (studio.createdAt?.isNotEmpty == true)
                _StudioDetailRow(
                  icon: Icons.add_circle_outline_rounded,
                  label: context.l10n.created_at_title,
                  value: studio.createdAt!,
                ),
              if (studio.updatedAt?.isNotEmpty == true)
                _StudioDetailRow(
                  icon: Icons.update_rounded,
                  label: context.l10n.updated_at_title,
                  value: studio.updatedAt!,
                ),
            ],
          ),
        ),
        if (studio.tags.isNotEmpty)
          _StudioCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.details_tags,
                  style: context.textTheme.titleSmall,
                ),
                SizedBox(height: context.dimensions.spacingSmall),
                Wrap(
                  spacing: context.dimensions.spacingSmall,
                  runSpacing: context.dimensions.spacingSmall,
                  children: studio.tags
                      .map(
                        (tag) => ActionChip(
                          label: Text(tag.name),
                          onPressed: () => context.push('/tags/tag/${tag.id}'),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        _StudioCountCard(studio: studio),
      ],
    );
  }
}

class _StudioCountCard extends StatelessWidget {
  const _StudioCountCard({required this.studio});

  final Studio studio;

  @override
  Widget build(BuildContext context) {
    final dims = context.dimensions;
    final counts = [
      (context.l10n.scenes_title, studio.sceneCount, studio.sceneCountAll),
      (context.l10n.images_title, studio.imageCount, studio.imageCountAll),
      (
        context.l10n.details_galleries,
        studio.galleryCount,
        studio.galleryCountAll,
      ),
      (
        context.l10n.performers_title,
        studio.performerCount,
        studio.performerCountAll,
      ),
      (context.l10n.groups_title, studio.groupCount, studio.groupCountAll),
    ];
    return _StudioCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.studio_content_counts_title,
            style: context.textTheme.titleSmall,
          ),
          SizedBox(height: dims.spacingSmall),
          Wrap(
            spacing: dims.spacingSmall,
            runSpacing: dims.spacingSmall,
            children: counts
                .map(
                  (item) => Chip(
                    label: Text(
                      item.$3 == null || item.$3 == item.$2
                          ? '${item.$1}: ${item.$2}'
                          : '${item.$1}: ${item.$2} / ${item.$3}',
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _StudioHierarchyTab extends StatelessWidget {
  const _StudioHierarchyTab({required this.studio});

  final Studio studio;

  @override
  Widget build(BuildContext context) {
    final parent = studio.parentStudio;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StudioCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.studio_parent_title,
                style: context.textTheme.titleSmall,
              ),
              if (parent == null)
                Padding(
                  padding: EdgeInsets.only(
                    top: context.dimensions.spacingSmall,
                  ),
                  child: Text(context.l10n.studio_no_parent),
                )
              else
                _StudioRelationshipTile(studio: parent),
            ],
          ),
        ),
        _StudioCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.studio_children_title,
                style: context.textTheme.titleSmall,
              ),
              if (studio.childStudios.isEmpty)
                Padding(
                  padding: EdgeInsets.only(
                    top: context.dimensions.spacingSmall,
                  ),
                  child: Text(context.l10n.studio_no_children),
                )
              else
                ...studio.childStudios.map(
                  (child) => _StudioRelationshipTile(studio: child),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StudioRelationshipTile extends StatelessWidget {
  const _StudioRelationshipTile({required this.studio});

  final StudioRelationship studio;

  @override
  Widget build(BuildContext context) {
    final hasImage =
        studio.imagePath?.isNotEmpty == true &&
        !studio.imagePath!.contains('default=true');
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        child: hasImage
            ? ClipOval(
                child: StashImage(
                  imageUrl: studio.imagePath!,
                  width: 40 * context.dimensions.fontSizeFactor,
                  height: 40 * context.dimensions.fontSizeFactor,
                  fit: BoxFit.cover,
                  memCacheWidth: 120,
                ),
              )
            : const Icon(Icons.business_outlined),
      ),
      title: Text(studio.name),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () => context.push('/studios/studio/${studio.id}'),
    );
  }
}

class _StudioCard extends StatelessWidget {
  const _StudioCard({required this.child});

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

class _StudioDetailRow extends StatelessWidget {
  const _StudioDetailRow({
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

class _StudioEmpty extends StatelessWidget {
  const _StudioEmpty({required this.icon});

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

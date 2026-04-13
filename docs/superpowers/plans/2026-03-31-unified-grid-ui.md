# Unified Grid UI Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Unify the grid-like UI across Scenes, Galleries, and Performer pages to match the standard defined in `ScenesPage`.

**Architecture:** Create shared `GridUtils`, `GalleryCard`, and a generic `GridCard`. Refactor existing pages to use `ListPageScaffold` with these unified grid settings (2 columns on mobile, 3 on tablet, 1.15 aspect ratio).

**Tech Stack:** Flutter, Riverpod, Material 3.

---

### Task 1: Create GridUtils

**Files:**
- Create: `lib/core/presentation/widgets/grid_utils.dart`

- [ ] **Step 1: Create `grid_utils.dart` with standard grid delegate and padding**

```dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Utilities for maintaining a consistent grid layout across the application.
class GridUtils {
  /// The standard padding for grid containers.
  static const EdgeInsets defaultPadding = EdgeInsets.all(AppTheme.spacingSmall);

  /// The standard aspect ratio for grid items that include title and subtitle.
  static const double defaultChildAspectRatio = 1.15;

  /// Creates a standard [SliverGridDelegateWithFixedCrossAxisCount] for use in [ListPageScaffold].
  static SliverGridDelegateWithFixedCrossAxisCount createDelegate({
    int crossAxisCount = 2,
    double childAspectRatio = defaultChildAspectRatio,
  }) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: AppTheme.spacingSmall,
      mainAxisSpacing: AppTheme.spacingMedium,
      childAspectRatio: childAspectRatio,
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/core/presentation/widgets/grid_utils.dart
git commit -m "feat: add GridUtils for unified grid layouts"
```

### Task 2: Create GridCard (Generic)

**Files:**
- Create: `lib/core/presentation/widgets/grid_card.dart`

- [ ] **Step 1: Create `grid_card.dart` for simple grid items**

```dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'stash_image.dart';

/// A generic card widget for grid layouts.
class GridCard extends StatelessWidget {
  const GridCard({
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.onTap,
    this.badge,
    super.key,
  });

  final String title;
  final String? subtitle;
  final String? imageUrl;
  final VoidCallback? onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  StashImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    memCacheWidth: 400,
                  ),
                  if (badge != null)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: context.colors.primary.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          badge!,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colors.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: context.colors.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: context.colors.onSurface.withValues(alpha: 0.75),
                      fontSize: 10,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/core/presentation/widgets/grid_card.dart
git commit -m "feat: add generic GridCard for performer media grids"
```

### Task 3: Create GalleryCard

**Files:**
- Create: `lib/features/galleries/presentation/widgets/gallery_card.dart`

- [ ] **Step 1: Create `gallery_card.dart` using `GridCard` internally**

```dart
import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/grid_card.dart';
import '../../domain/entities/gallery.dart';

/// A card widget that displays a summary of a [Gallery].
class GalleryCard extends StatelessWidget {
  const GalleryCard({
    required this.gallery,
    this.onTap,
    this.thumbnailUrl,
    super.key,
  });

  final Gallery gallery;
  final VoidCallback? onTap;
  final String? thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    return GridCard(
      title: gallery.displayName,
      subtitle: '${gallery.imageCount ?? 0} images',
      imageUrl: thumbnailUrl,
      onTap: onTap,
      badge: (gallery.imageCount != null && gallery.imageCount! > 0)
          ? '${gallery.imageCount}'
          : null,
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/features/galleries/presentation/widgets/gallery_card.dart
git commit -m "feat: add GalleryCard using GridCard"
```

### Task 4: Refactor ScenesPage

**Files:**
- Modify: `lib/features/scenes/presentation/pages/scenes_page.dart`

- [ ] **Step 1: Update `ScenesPage` to use `GridUtils`**

```dart
// lib/features/scenes/presentation/pages/scenes_page.dart

// 1. Add import:
import '../../../../core/presentation/widgets/grid_utils.dart';

// 2. Update gridDelegate and padding in build():
      gridDelegate: isGridView
          ? GridUtils.createDelegate(
              crossAxisCount: _getGridColumnCount(context),
            )
          : null,
      padding: isGridView ? GridUtils.defaultPadding : EdgeInsets.zero,
```

- [ ] **Step 2: Commit**

```bash
git add lib/features/scenes/presentation/pages/scenes_page.dart
git commit -m "refactor: use GridUtils in ScenesPage"
```

### Task 5: Refactor GalleriesPage

**Files:**
- Modify: `lib/features/galleries/presentation/pages/galleries_page.dart`

- [ ] **Step 1: Replace inline card and hardcoded grid in `GalleriesPage`**

```dart
// lib/features/galleries/presentation/pages/galleries_page.dart

// 1. Add imports:
import '../widgets/gallery_card.dart';
import '../../../../core/presentation/widgets/grid_utils.dart';

// 2. Update build():
    return ListPageScaffold<Gallery>(
      // ...
      gridDelegate: GridUtils.createDelegate(),
      padding: GridUtils.defaultPadding,
      itemBuilder: (context, gallery) => GalleryCard(
        gallery: gallery,
        thumbnailUrl: _getThumbnailUrl(gallery),
        onTap: () {
          ref.read(imageFilterStateProvider.notifier).setGalleryId(gallery.id);
          context.go('/galleries/images');
        },
      ),
    );
```

- [ ] **Step 2: Commit**

```bash
git add lib/features/galleries/presentation/pages/galleries_page.dart
git commit -m "refactor: use GalleryCard and GridUtils in GalleriesPage"
```

### Task 6: Refactor PerformerMediaGridPage

**Files:**
- Modify: `lib/features/performers/presentation/pages/performer_media_grid_page.dart`

- [ ] **Step 1: Refactor `PerformerMediaGridPage` to use `ListPageScaffold` and `GridCard`**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/widgets/list_page_scaffold.dart';
import '../../../../core/presentation/widgets/grid_utils.dart';
import '../../../../core/presentation/widgets/grid_card.dart';
import '../providers/performer_media_provider.dart';

class PerformerMediaGridPage extends ConsumerWidget {
  final String performerId;

  const PerformerMediaGridPage({required this.performerId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaAsync = ref.watch(performerMediaGridProvider(performerId));

    return ListPageScaffold<PerformerMediaItem>(
      title: 'All Performer Media',
      searchHint: 'Search media...',
      onSearchChanged: (_) {}, // Provider doesn't support search yet
      provider: mediaAsync,
      onRefresh: () => ref.refresh(performerMediaGridProvider(performerId).future),
      onFetchNextPage: () => ref.read(performerMediaGridProvider(performerId).notifier).fetchNextPage(),
      gridDelegate: GridUtils.createDelegate(),
      padding: GridUtils.defaultPadding,
      itemBuilder: (context, item) => GridCard(
        title: item.title,
        imageUrl: item.thumbnailUrl,
        onTap: () => context.push('/scenes/scene/${item.sceneId}'),
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/features/performers/presentation/pages/performer_media_grid_page.dart
git commit -m "refactor: PerformerMediaGridPage to use ListPageScaffold and GridCard"
```

### Task 7: Refactor PerformerGalleriesGridPage

**Files:**
- Modify: `lib/features/performers/presentation/pages/performer_galleries_grid_page.dart`

- [ ] **Step 1: Refactor `PerformerGalleriesGridPage` to use `ListPageScaffold` and `GridCard`**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/widgets/list_page_scaffold.dart';
import '../../../../core/presentation/widgets/grid_utils.dart';
import '../../../../core/presentation/widgets/grid_card.dart';
import '../providers/performer_galleries_provider.dart';
import '../../../images/presentation/providers/image_list_provider.dart';

class PerformerGalleriesGridPage extends ConsumerWidget {
  final String performerId;

  const PerformerGalleriesGridPage({required this.performerId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final galleriesAsync = ref.watch(performerGalleriesGridProvider(performerId));

    return ListPageScaffold<PerformerGalleryItem>(
      title: 'All Performer Galleries',
      searchHint: 'Search galleries...',
      onSearchChanged: (_) {}, // Provider doesn't support search yet
      provider: galleriesAsync,
      onRefresh: () => ref.refresh(performerGalleriesGridProvider(performerId).future),
      onFetchNextPage: () => ref.read(performerGalleriesGridProvider(performerId).notifier).fetchNextPage(),
      gridDelegate: GridUtils.createDelegate(),
      padding: GridUtils.defaultPadding,
      itemBuilder: (context, item) => GridCard(
        title: item.title,
        imageUrl: item.thumbnailUrl,
        onTap: () {
          ref.read(imageFilterStateProvider.notifier).setGalleryId(item.galleryId);
          context.push('/galleries/images');
        },
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/features/performers/presentation/pages/performer_galleries_grid_page.dart
git commit -m "refactor: PerformerGalleriesGridPage to use ListPageScaffold and GridCard"
```

### Task 8: Final Verification

- [ ] **Step 1: Run static analysis**
Run: `dart analyze`

- [ ] **Step 2: Run tests**
Run: `flutter test`

---

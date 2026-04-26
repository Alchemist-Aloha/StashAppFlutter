# Unrestrict Masonry Thumbnails Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [x]`) syntax for tracking.

**Goal:** Allow thumbnails in the masonry grid to use their native aspect ratio instead of being forced to 16:9.

**Architecture:** Pass the `useMasonry` flag to `SceneCard`. In masonry mode, the card will use the media's actual aspect ratio for the thumbnail container.

**Tech Stack:** Flutter

---

### Task 1: Update SceneCard to support dynamic aspect ratios

**Files:**
- Modify: `lib/features/scenes/presentation/widgets/scene_card.dart`

- [x] **Step 1: Add useMasonry parameter to SceneCard**

Modify constructor and final fields:

```dart
  const SceneCard({
    required this.scene,
    this.isGrid = false,
    this.useMasonry = false, // Add this
    this.onTap,
    // ...
  });

  final bool useMasonry;
```

- [x] **Step 2: Update _buildGridCard to use dynamic aspect ratio**

Modify `_buildGridCard` to use the passed-in `aspectRatio` instead of hardcoded `16 / 9` when `useMasonry` is true.

```dart
  Widget _buildGridCard(
    BuildContext context,
    WidgetRef ref,
    double? duration,
    double aspectRatio,
  ) {
    // ...
    return InkWell(
      // ...
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: widget.useMasonry ? aspectRatio.clamp(0.5, 2.5) : 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              child: _buildThumbnail(
                context, 
                duration, 
                widget.useMasonry ? aspectRatio.clamp(0.5, 2.5) : 16 / 9,
              ),
            ),
          ),
          // ... rest of card ...
        ],
      ),
    );
  }
```

- [x] **Step 3: Commit**

```bash
git add lib/features/scenes/presentation/widgets/scene_card.dart
git commit -m "feat(scenes): support dynamic thumbnail aspect ratio in masonry mode"
```

### Task 2: Update ScenesPage to pass useMasonry flag

**Files:**
- Modify: `lib/features/scenes/presentation/pages/scenes_page.dart`

- [x] **Step 1: Pass useMasonry to SceneCard**

```dart
        return SceneCard(
          scene: scene,
          isGrid: isGridView,
          useMasonry: isGridView, // Add this
          memCacheWidth: memCacheWidth,
          // ...
        );
```

- [x] **Step 2: Commit**

```bash
git add lib/features/scenes/presentation/pages/scenes_page.dart
git commit -m "feat(scenes): enable unconstrained thumbnail ratios in masonry grid"
```

### Task 3: Verification

- [x] **Step 1: Verify on Desktop**
Check that portrait videos now appear tall in the grid without cropping, while landscape videos remain 16:9.

- [x] **Step 2: Run tests**

Run: `flutter test test/integration_navigation_test.dart`

- [x] **Step 3: Commit final updates**

```bash
git add .
git commit -m "test: verify dynamic aspect ratio in masonry grid"
```

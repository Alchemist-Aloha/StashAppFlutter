# Dynamic Masonry Grid Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the fixed-ratio grid in the Scenes page with a dynamic height Masonry grid to eliminate empty space on desktop.

**Architecture:** Update `ListPageScaffold` to support an optional Masonry layout using the `flutter_staggered_grid_view` package. This allows individual grid items to occupy only the vertical space required by their content.

**Tech Stack:** Flutter, flutter_staggered_grid_view

---

### Task 1: Update ListPageScaffold to support Masonry Grid

**Files:**
- Modify: `lib/core/presentation/widgets/list_page_scaffold.dart`

- [ ] **Step 1: Add useMasonry parameter to ListPageScaffold**

Modify constructor and final fields:

```dart
  const ListPageScaffold({
    // ...
    this.useMasonry = false,
    // ...
  });

  /// Whether to use a dynamic height Masonry grid layout instead of fixed ratio.
  final bool useMasonry;
```

- [ ] **Step 2: Import flutter_staggered_grid_view**

```dart
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
```

- [ ] **Step 3: Update body building logic to use MasonryGridView**

Modify the `body` assignment (around line 670):

```dart
Widget body = widget.customBody ??
    (widget.gridDelegate != null
        ? (widget.useMasonry
            ? MasonryGridView.builder(
                controller: widget.scrollController,
                padding: widget.padding,
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (widget.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount).crossAxisCount,
                ),
                mainAxisSpacing: (widget.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount).mainAxisSpacing,
                crossAxisSpacing: (widget.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount).crossAxisSpacing,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  // ... existing builder logic (itemBuilder, prefetch, etc.) ...
                },
              )
            : GridView.builder(
                // ... existing GridView logic ...
              ))
        : ListView.builder(
            // ... existing ListView logic ...
          ));
```

*Note: Ensure the responsive column count logic in `_getResponsiveGridDelegate` is respected.*

- [ ] **Step 4: Verify compilation**

Run: `flutter build apk --split-per-abi` (or just check for analyzer errors).

- [ ] **Step 5: Commit**

```bash
git add lib/core/presentation/widgets/list_page_scaffold.dart
git commit -m "feat(ui): add masonry grid support to ListPageScaffold"
```

### Task 2: Enable Masonry Grid on ScenesPage

**Files:**
- Modify: `lib/features/scenes/presentation/pages/scenes_page.dart`

- [ ] **Step 1: Update ListPageScaffold usage in ScenesPage**

Modify the `build` method:

```dart
return ListPageScaffold<Scene>(
  // ...
  useMasonry: isGridView,
  // ...
);
```

- [ ] **Step 2: Commit**

```bash
git add lib/features/scenes/presentation/pages/scenes_page.dart
git commit -m "feat(scenes): enable dynamic masonry grid for scene browsing"
```

### Task 3: Optimization & Verification

- [ ] **Step 1: Verify visual appearance on Desktop**
Check that the grid items no longer have excessive white space below titles.

- [ ] **Step 2: Verify Responsive Columns**
Ensure that swiping/resizing still triggers column count updates (2 for mobile, 3+ for tablet/desktop).

- [ ] **Step 3: Run existing UI tests**

Run: `flutter test test/integration_navigation_test.dart`

- [ ] **Step 4: Commit any final tweaks**

```bash
git add .
git commit -m "perf: optimize masonry grid layout and verify responsiveness"
```

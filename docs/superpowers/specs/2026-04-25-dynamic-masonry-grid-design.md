# Spec: Dynamic Height Masonry Grid

## Problem
In the current grid view, cards use a fixed `childAspectRatio` (default 1.15). On desktop screens where cards are wider, this ratio forces a very tall text section. If the scene title is short and there are no performer avatars, this results in significant empty space, making the UI look sparse and unpolished.

## Goal
Implement a dynamic height grid (Masonry) that allows items to take only as much vertical space as their content requires.

## Proposed Changes

### 1. lib/core/presentation/widgets/list_page_scaffold.dart
- Add `bool useMasonry` to the `ListPageScaffold` constructor (defaults to `false`).
- Update the `build` method:
    - If `useMasonry` is true:
        - Use `MasonryGridView.builder` from `flutter_staggered_grid_view`.
        - Use `SliverSimpleGridDelegateWithFixedCrossAxisCount` for column management, leveraging existing responsive logic.
    - Maintain existing `ListView` and `GridView` (fixed ratio) logic for backward compatibility.

### 2. lib/features/scenes/presentation/pages/scenes_page.dart
- Set `useMasonry: isGridView` when calling `ListPageScaffold`.

### 3. lib/features/scenes/presentation/widgets/scene_card.dart
- No structural changes needed, as `_buildGridCard` already uses a `Column` that is compatible with dynamic height layouts.

## Success Criteria
- Grid items in the Scenes page adapt their height to their content.
- No excessive empty space in the text section on desktop.
- Responsive column counts (2 on mobile, 3+ on desktop) are preserved.
- Infinite scrolling and search functionality remain fully operational.


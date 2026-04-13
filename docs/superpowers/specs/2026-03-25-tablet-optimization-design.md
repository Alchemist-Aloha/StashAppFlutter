# Tablet Optimization Design Spec

## Goal
Optimize StashFlow for tablet devices (>= 600px width) by introducing an adaptive navigation sidebar and a 3-column grid layout, while preserving the existing mobile UI for smaller screens.

## Architecture & Utilities

### Breakpoints
We will define a centralized `Responsive` utility class in `lib/core/utils/responsive.dart`:
- **Mobile**: < 600px
- **Tablet**: >= 600px and < 1200px
- **Desktop**: >= 1200px (future-proofing)

### Design Tokens
New spacing and layout constants will be added to `AppTheme` if necessary to handle tablet-specific padding.

## Components

### Adaptive Navigation (`ShellPage`)
The `ShellPage` will be updated to use a conditional layout:
- **Mobile**: Standard `Scaffold` with `bottomNavigationBar`.
- **Tablet/Desktop**: `Scaffold` where the `body` is a `Row` containing a `NavigationRail` on the left and the `StatefulNavigationShell` on the right.
- **State Management**: Both layouts will share the same `navigationShell.currentIndex` and `onDestinationSelected` logic.

### Dynamic Grid (`ListPageScaffold`)
The `ListPageScaffold` will be enhanced to support responsive grid delegates:
- **Grid Column Count**:
  - < 600px: 2 columns
  - >= 600px: 3 columns
- **Implementation**: The `ListPageScaffold` will automatically calculate `crossAxisCount` if a `useResponsiveGrid` flag is set, or we will update the `gridDelegate` passed from pages like `ScenesPage`.

### Page-Specific Updates
- **ScenesPage**: Update `_onScroll` prefetching logic and `gridDelegate` to use the responsive column count.
- **PerformerMediaGridPage, StudioMediaGridPage, TagMediaGridPage**: Similar updates to ensure 3-column grids on tablets.

## Data Flow
- Navigation state remains managed by `go_router`'s `StatefulNavigationShell`.
- UI responsiveness is driven by `MediaQuery` and the new `Responsive` utility.

## Testing Strategy
- **Widget Tests**: Verify that `NavigationRail` is present at 800px width and `NavigationBar` is present at 400px width.
- **Integration Tests**: Ensure navigation still works correctly when switching between branches on both layouts.
- **Visual Verification**: Manual check of grid layouts on tablet emulators/simulators.

# Rename 'Media' to 'Galleries' and Handle Scroll-to-Top

> **Topic:** User Interface / Navigation Enhancement
> **Date:** 2026-03-31

## Context
The user wants to rename the 'Media' label in the bottom panel (and navigation rail) to 'Galleries'. Additionally, clicking this 'Galleries' button when the user is already on the page should navigate to the top of the gallery page.

## Proposed Changes

### 1. Navigation Label Change (ShellPage)
Modify `lib/features/navigation/presentation/shell_page.dart` to rename 'Media' to 'Galleries' in both `NavigationBar` and `NavigationRail`.

-   **File**: `lib/features/navigation/presentation/shell_page.dart`
-   **Change**: Update `navigationDestinations` and `navigationRailDestinations`.

### 2. Connect Scroll Controller (GalleriesPage)
Modify `lib/features/galleries/presentation/pages/galleries_page.dart` to use `galleryScrollControllerProvider` in its `ListPageScaffold`. This allows the scroll-to-top logic in `ShellPage` to work.

-   **File**: `lib/features/galleries/presentation/pages/galleries_page.dart`
-   **Change**: Pass `ref.watch(galleryScrollControllerProvider)` to the `scrollController` property of `ListPageScaffold`.

## Logic Flow
1.  **Renaming**: Simple UI string update in `ShellPage`.
2.  **Scrolling**:
    -   `ShellPage.onDestinationSelected` already has a `case 4` that calls `ref.read(galleryScrollControllerProvider.notifier).scrollToTop()`.
    -   `GalleryScrollController` (in `lib/features/galleries/presentation/providers/gallery_list_provider.dart`) manages a `ScrollController`.
    -   By passing this `ScrollController` to `ListPageScaffold` in `GalleriesPage`, the animation triggered by `scrollToTop()` will scroll the actual list/grid on the page.

## Verification Plan
1.  **Visual Confirmation**: Ensure the bottom navigation bar and navigation rail now show 'Galleries' instead of 'Media'.
2.  **Functional Testing**:
    -   Navigate to the Galleries page.
    -   Scroll down.
    -   Click the 'Galleries' icon in the bottom navigation bar.
    -   Verify the page scrolls smoothly to the top.

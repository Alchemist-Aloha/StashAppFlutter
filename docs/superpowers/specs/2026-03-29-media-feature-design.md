# Design Spec: Media Feature (Image Waterfall & Gallery Folder View)

Date: 2026-03-29
Status: Draft
Author: Gemini CLI

## 1. Overview
The goal is to implement a unified "Media" experience in StashFlow, replacing the "Settings" tab in the bottom navigation. This feature provides two distinct views for media: a true staggered "Waterfall" grid for individual Images and a "Folder-like" grid for Galleries.

## 2. Requirements & User Experience

### 2.1 Navigation & Routing
- **Bottom Navigation:** Replace "Settings" with "Media" (Index 4).
- **Sub-routing (Route-Driven):** 
  - `/media/images`: Waterfall view of all images.
  - `/media/galleries`: Folder-like view of all galleries.
- **Toggle:** A UI toggle in the `AppBar` or `sortBar` to switch between `/media/images` and `/media/galleries`.
  - **Persistence:** The toggle state (last active view) will be persisted via `SharedPreferences`.
- **Drill-down:** Clicking a Gallery card in the folder view navigates to `/media/images?gallery_id={id}`.
- **Settings:** Move the "Settings" button to the top-right of the `AppBar` (integrated via `ListPageScaffold`).

### 2.2 Image Waterfall View
- **Layout:** True staggered grid (Pinterest-style) using `MasonryGridView`.
  - **Responsiveness:** Use 2 columns on mobile (adaptive to 1 if extremely narrow) and 3-5 columns on larger screens/tablets.
- **Interactions:**
  - Tapping an image opens the Fullscreen Viewer.
  - Independent filtering and sorting from Galleries.
- **Performance:**
  - `CachedNetworkImage` for all thumbnails.
  - Pre-calculated aspect ratio placeholders to prevent layout shifts.

### 2.3 Gallery Folder View
- **Layout:** Uniform grid of folder cards.
- **Details:** Cards display the gallery title and a badge with the `image_count`.
- **Interactions:** Independent filtering and sorting from Images.

### 2.4 Fullscreen Image Viewer
- **Navigation:** Vertical `PageView` (swipe up/down) mirroring the waterfall's sort/filter order.
- **Pinch-to-Zoom:** Using `InteractiveViewer` for each image.
- **UI Overlay (Hybrid):**
  - Persistent back button and index indicator (e.g., `5 / 100`).
  - Full metadata available via a "More Info" button or tap-to-reveal.
- **Pre-fetching:** Background loading of the next/previous images in the sequence.

## 3. Architecture & Data Flow

### 3.1 Domain Layer
- **Image Entity:** `id`, `title`, `rating100`, `date`, `urls` (a list of source strings from GraphQL), `thumbnailPath`, `previewPath`, `imagePath`.
- **Repository Interface:** `ImageRepository` with `findImages(filter, sort, page)`.

### 3.2 Data Layer
- **GraphQL Implementation:** `GraphQLImageRepository` using the `findImages` query from the Stash GraphQL schema.
- **Independent State:** Separate `Notifier` classes for `ImageListFilter` and `GalleryListFilter`.

### 3.3 Presentation Layer
- **Providers:**
  - `ImageListProvider`: Fetches images based on current `ImageFilterState`.
  - `GalleryListProvider`: Fetches galleries based on current `GalleryFilterState`.
- **Widgets:**
  - `MediaPage`: A shell or wrapper that handles the route logic.
  - `ImageWaterfallView`: The staggered grid implementation.
  - `GalleryFolderView`: The uniform grid implementation.
  - `FullscreenViewerPage`: The vertical `PageView` implementation.

## 4. Implementation Details

### 4.1 Staggered Grid
- Package: `flutter_staggered_grid_view`.
- Use `SliverMasonryGrid` for smooth integration with `ListPageScaffold`'s scrolling.

### 4.2 Vertical Navigation
- Use `PageView` with `scrollDirection: Axis.vertical`.
- Ensure the controller index is synced with the tapped image from the grid.

### 4.3 Filter Sync/Isolation
- Filters are isolated. Navigating from a gallery applies a temporary `gallery_id` override to the `ImageListProvider`.

## 5. Verification Plan
- [ ] Verify tab switching between Scenes, Performers, Studios, Tags, and Media.
- [ ] Verify toggle button between Image and Gallery views.
- [ ] Verify staggered grid layout with varying aspect ratios.
- [ ] Verify vertical swipe navigation in fullscreen mode.
- [ ] Verify pinch-to-zoom functionality.
- [ ] Verify Settings button is accessible in the top-right.
- [ ] Verify independent sorting/filtering for Images and Galleries.

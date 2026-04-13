# Media Feature Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement a "Media" tab that replaces "Settings" in the bottom navigation, providing a toggle between an Image Waterfall (staggered grid) and a Gallery Folder view, with vertical swipe fullscreen navigation.

**Architecture:** Route-driven architecture using GoRouter for `/media/images` and `/media/galleries`. Independent filter states for both views, with a repository-based data layer fetching from GraphQL.

**Tech Stack:** Flutter, Riverpod (State Management), GoRouter (Navigation), GraphQL, `flutter_staggered_grid_view` (Staggered Grid), `cached_network_image` (Image Caching), `photo_view` or `InteractiveViewer` (Zoom).

---

### Task 0: Dependencies

- [ ] **Step 1: Add staggered grid dependency**
  Run: `flutter pub add flutter_staggered_grid_view`
- [ ] **Step 2: Commit**
  `git add pubspec.yaml && git commit -m "chore: add flutter_staggered_grid_view dependency"`

### Task 1: Image Domain & Data Layer

**Files:**
- Create: `lib/features/images/domain/entities/image.dart`
- Create: `lib/features/images/domain/repositories/image_repository.dart`
- Create: `lib/features/images/data/repositories/graphql_image_repository.dart`
- Test: `test/features/images/data/repositories/graphql_image_repository_test.dart`

- [ ] **Step 1: Create Image Entity**
  Define the `Image` class with `id`, `title`, `rating100`, `date`, `urls`, and path resolvers.
- [ ] **Step 2: Create Image Repository Interface**
  Define `findImages` and `getImageById`.
- [ ] **Step 3: Implement GraphQL Image Repository**
  Implement `findImages` using the `findImages` GraphQL query with filter/sort support.
- [ ] **Step 4: Write unit test for Image Repository**
  Mock GraphQL client and verify `findImages` parses results correctly.
- [ ] **Step 5: Commit**
  `git add lib/features/images/ && git commit -m "feat(images): add domain and data layer"`

### Task 2: Image Presentation Providers & Persistence

**Files:**
- Create: `lib/features/images/presentation/providers/image_list_provider.dart`
- Test: `test/features/images/presentation/providers/image_list_provider_test.dart`

- [ ] **Step 1: Implement ImageSort and ImageFilter Providers**
  Define providers for independent image sorting and filtering (title, rating, gallery_id).
- [ ] **Step 2: Implement MediaViewToggle Provider with Persistence**
  Create a provider to track `images` vs `galleries` view, persisting choice to `SharedPreferences`.
- [ ] **Step 3: Implement ImageList Provider**
  Create a pagination-aware provider that fetches images using the repository.
- [ ] **Step 4: Write unit tests for ImageListProvider**
  Verify pagination logic and filtering updates.
- [ ] **Step 5: Commit**
  `git add lib/features/images/presentation/providers/ && git commit -m "feat(images): add list and filter providers with persistence"`

### Task 3: Navigation Reorganization

**Files:**
- Modify: `lib/core/presentation/widgets/list_page_scaffold.dart`
- Modify: `lib/features/navigation/presentation/shell_page.dart`
- Modify: `lib/features/navigation/presentation/router.dart`

- [ ] **Step 1: Update ListPageScaffold for Settings Icon**
  Add a persistent Settings icon to the `AppBar` actions in `ListPageScaffold` (visible when not searching).
- [ ] **Step 2: Update ShellPage Bottom Navigation**
  Replace "Settings" tab with "Media" (Index 4).
- [ ] **Step 3: Configure GoRouter for Media Branch**
  Add a single `/media` branch with sub-routes `/images` and `/galleries`.
- [ ] **Step 4: Commit**
  `git add lib/core/ lib/features/navigation/ && git commit -m "refactor(nav): move settings to top-right and add media tab branch"`

### Task 4: Gallery Page Refinement

**Files:**
- Modify: `lib/features/galleries/presentation/pages/galleries_page.dart`

- [ ] **Step 1: Add Media Toggle to AppBar**
  Implement the toggle button in `GalleriesPage` using the `MediaViewToggle` provider.
- [ ] **Step 2: Implement Folder Grid Layout**
  Update `GalleriesPage` to use a uniform grid of "Folder Cards" with `image_count` badges.
- [ ] **Step 3: Implement Navigation to Images**
  Ensure tapping a gallery navigates to `/media/images?gallery_id={id}`.
- [ ] **Step 4: Commit**
  `git add lib/features/galleries/ && git commit -m "feat(galleries): update to folder view with media toggle"`

### Task 5: Image Waterfall Page

**Files:**
- Create: `lib/features/images/presentation/pages/images_page.dart`
- Create: `lib/features/images/presentation/widgets/image_card.dart`

- [ ] **Step 1: Implement ImageCard with Aspect Ratio Placeholders**
  Create a widget using `AspectRatio` and `CachedNetworkImage` to prevent layout shifts.
- [ ] **Step 2: Implement ImagesPage with Responsive MasonryGridView**
  Use `SliverMasonryGrid` within a `CustomScrollView` (passed to `ListPageScaffold.customBody`). 2 columns on mobile, 3-5 on tablet/desktop.
- [ ] **Step 3: Add Media Toggle and Image Filters**
  Include the toggle and image-specific filter/sort UI.
- [ ] **Step 4: Commit**
  `git add lib/features/images/presentation/ && git commit -m "feat(images): implement staggered waterfall view with responsive grid"`

### Task 6: Fullscreen Image Viewer

**Files:**
- Create: `lib/features/images/presentation/pages/image_fullscreen_page.dart`
- Test: `test/features/images/presentation/pages/image_fullscreen_page_test.dart`

- [ ] **Step 1: Implement Vertical PageView with Index Sync**
  Create `PageView.builder` (vertical) with `initialPage` set to the tapped image index.
- [ ] **Step 2: Implement Zoom & Pre-fetching**
  Use `InteractiveViewer`. Implement pre-caching using `precacheImage` for adjacent images.
- [ ] **Step 3: Add Minimal Overlay & Metadata BottomSheet**
  Add back button, index indicator, and "Info" button that shows image details in a `ModalBottomSheet`.
- [ ] **Step 4: Write widget test for Fullscreen Viewer**
  Verify index tracking and metadata display.
- [ ] **Step 5: Commit**
  `git add lib/features/images/presentation/pages/ && git commit -m "feat(images): add fullscreen vertical viewer with index sync and metadata"`

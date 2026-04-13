# Rename 'Media' to 'Galleries' and Handle Scroll-to-Top Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rename 'Media' to 'Galleries' in the navigation bar and rail, and ensure clicking it scrolls the Galleries page to the top.

**Architecture:** Update UI labels in the shell and connect the existing `GalleryScrollController` to the `ListPageScaffold` in `GalleriesPage`.

**Tech Stack:** Flutter, Riverpod

---

### Task 1: Rename 'Media' to 'Galleries' in ShellPage

**Files:**
- Modify: `lib/features/navigation/presentation/shell_page.dart`

- [ ] **Step 1: Update navigation labels**

Change 'Media' to 'Galleries' in `navigationDestinations` and `navigationRailDestinations`.

```dart
    final navigationDestinations = const [
      NavigationDestination(icon: Icon(Icons.video_library), label: 'Scenes'),
      NavigationDestination(icon: Icon(Icons.people), label: 'Performers'),
      NavigationDestination(icon: Icon(Icons.business), label: 'Studios'),
      NavigationDestination(icon: Icon(Icons.local_offer), label: 'Tags'),
      NavigationDestination(icon: Icon(Icons.perm_media), label: 'Galleries'),
    ];

    final navigationRailDestinations = const [
      // ... (other destinations)
      NavigationRailDestination(
        icon: Icon(Icons.perm_media),
        label: Text('Galleries'),
      ),
    ];
```

- [ ] **Step 2: Verify static analysis**

Run: `dart analyze lib/features/navigation/presentation/shell_page.dart`
Expected: PASS

- [ ] **Step 3: Commit UI rename**

```bash
git add lib/features/navigation/presentation/shell_page.dart
git commit -m "ui: rename 'Media' to 'Galleries' in navigation"
```

### Task 2: Connect Scroll Controller in GalleriesPage

**Files:**
- Modify: `lib/features/galleries/presentation/pages/galleries_page.dart`

- [ ] **Step 1: Pass scroll controller to ListPageScaffold**

```dart
  @override
  Widget build(BuildContext context) {
    final galleriesAsync = ref.watch(galleryListProvider);
    // ...
    return ListPageScaffold<Gallery>(
      title: 'Galleries',
      scrollController: ref.watch(galleryScrollControllerProvider),
      // ...
```

- [ ] **Step 2: Verify static analysis**

Run: `dart analyze lib/features/galleries/presentation/pages/galleries_page.dart`
Expected: PASS

- [ ] **Step 3: Commit scroll controller connection**

```bash
git add lib/features/galleries/presentation/pages/galleries_page.dart
git commit -m "feat: connect galleryScrollController to GalleriesPage for scroll-to-top"
```

### Task 3: Final Verification

- [ ] **Step 1: Run project-wide analysis**

Run: `dart analyze`
Expected: PASS

- [ ] **Step 2: Manual Verification (Instructions for User)**
- Open the app.
- Confirm "Galleries" label in the bottom bar.
- Navigate to Galleries.
- Scroll down.
- Tap "Galleries" in the bottom bar again.
- Confirm it scrolls to top.

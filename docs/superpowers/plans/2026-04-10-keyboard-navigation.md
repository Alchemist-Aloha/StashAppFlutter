# Keyboard Navigation for Image and Video Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add keyboard navigation shortcuts for the image viewer (left/right to navigate) and video player (space to play/pause, left/right to seek 10s).

**Architecture:** Use `Focus` and `CallbackShortcuts` (or `Actions`/`Shortcuts`) widgets to capture keyboard events in the specific player views. This ensures shortcuts only trigger when the view is active.

**Tech Stack:** Flutter, `CallbackShortcuts`, `Actions`, `Shortcuts`, `VideoPlayerController`.

---

### Task 1: Research Viewer Implementations

**Files:**
- Research: `lib/features/images/presentation/pages/image_fullscreen_page.dart`
- Research: `lib/features/scenes/presentation/widgets/native_video_controls.dart`
- Research: `lib/features/scenes/presentation/widgets/scene_video_player.dart`

- [x] **Step 1: Identify Image Viewer widget**
  File identified: `lib/features/images/presentation/pages/image_fullscreen_page.dart`

- [x] **Step 2: Identify Video Player control widget**
  File identified: `lib/features/scenes/presentation/widgets/native_video_controls.dart`

---

### Task 2: Implement Keyboard Shortcuts for Video Player

**Files:**
- Modify: `lib/features/scenes/presentation/widgets/native_video_controls.dart`

- [ ] **Step 1: Wrap controls in `CallbackShortcuts`**

Add Space (Play/Pause) and Left/Right Arrow (Seek -10s / +10s) shortcuts.

- [ ] **Step 2: Verify video shortcuts**

Run: `flutter test test/features/scenes/presentation/widgets/native_video_controls_test.dart`

- [ ] **Step 3: Commit**

```bash
git add lib/features/scenes/presentation/widgets/native_video_controls.dart
git commit -m "feat: add keyboard shortcuts for video player"
```

---

### Task 3: Implement Keyboard Shortcuts for Image Viewer

**Files:**
- Modify: `lib/features/images/presentation/pages/image_fullscreen_page.dart`

- [ ] **Step 1: Wrap image viewer in `CallbackShortcuts`**

Add Left/Right Arrow shortcuts to trigger "Previous" and "Next" image actions.

- [ ] **Step 2: Verify image shortcuts**

Run: `flutter test test/features/images/presentation/pages/image_fullscreen_page_test.dart` (if it exists)

- [ ] **Step 3: Commit**

```bash
git add lib/features/images/presentation/pages/image_fullscreen_page.dart
git commit -m "feat: add keyboard shortcuts for image viewer"
```

---

### Task 4: Final Verification

- [ ] **Step 1: Run all tests**

Run: `flutter test`

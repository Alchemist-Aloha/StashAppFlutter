# Play Next Overhaul Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Simplify sequential playback by strictly following the scene list order and removing the manual queue system.

**Architecture:** Use `PlaybackQueue` as a single source of truth for all playback sequences, synchronized with the `SceneList` provider.

**Tech Stack:** Flutter, Riverpod (State Management).

---

### Task 1: Refactor PlaybackQueue Provider

**Files:**
- Modify: `lib/features/scenes/presentation/providers/playback_queue_provider.dart`

- [ ] **Step 1: Simplify PlaybackQueueState**
Replace `manualQueue` and `currentSequence` with `sequence` and `currentIndex`.

- [ ] **Step 2: Update PlaybackQueue methods**
Remove `add`, `remove`, `clear`, and `fillFromList`.
Implement `setSequence(List<Scene> scenes, int initialIndex)`, `updateSequence(List<Scene> scenes)` (for pagination), and `setIndex(int index)`.

- [ ] **Step 3: Update getNextScene**
Simplify to return the scene at `currentIndex + 1`.

- [ ] **Step 4: Commit**
```bash
git add lib/features/scenes/presentation/providers/playback_queue_provider.dart
git commit -m "refactor: simplify PlaybackQueue to single sequence and index"
```

### Task 2: Update VideoPlayer Provider

**Files:**
- Modify: `lib/features/scenes/presentation/providers/video_player_provider.dart`

- [ ] **Step 1: Update playNext logic**
Remove reliance on `getNextScene` method if possible, or update it to use the new `PlaybackQueue` state.
Ensure `currentIndex` is updated when a new scene starts.

- [ ] **Step 2: Commit**
```bash
git add lib/features/scenes/presentation/providers/video_player_provider.dart
git commit -m "feat: update PlayerState to use simplified PlaybackQueue"
```

### Task 3: Overhaul NativeVideoControls UI

**Files:**
- Modify: `lib/features/scenes/presentation/widgets/native_video_controls.dart`

- [ ] **Step 1: Add Next button to bottom bar**
Add `IconButton(icon: Icon(Icons.skip_next))` next to the Play/Pause button in the bottom control bar.
Disable it if `currentIndex` is at the end of the `sequence`.

- [ ] **Step 2: Remove floating Next button**
Delete the code that renders the floating "Next Scene Button".

- [ ] **Step 3: Commit**
```bash
git add lib/features/scenes/presentation/widgets/native_video_controls.dart
git commit -m "ui: move Next button to bottom bar and remove floating UI"
```

### Task 4: Synchronize ScenesPage and SceneList

**Files:**
- Modify: `lib/features/scenes/presentation/providers/scene_list_provider.dart`
- Modify: `lib/features/scenes/presentation/pages/scenes_page.dart`

- [ ] **Step 1: Update SceneList pagination**
In `SceneList.fetchNextPage`, call `PlaybackQueue.updateSequence` with the newly loaded scenes.

- [ ] **Step 2: Update ScenesPage sequence initialization**
When `SceneList` finishes loading (data state), initialize the `PlaybackQueue.sequence` if it hasn't been set for this specific list/filter.

- [ ] **Step 3: Update SceneCard onTap**
In `ScenesPage`, update `onTap` to call `PlaybackQueue.setIndex(index)` instead of setting the whole sequence.

- [ ] **Step 4: Commit**
```bash
git add lib/features/scenes/presentation/providers/scene_list_provider.dart lib/features/scenes/presentation/pages/scenes_page.dart
git commit -m "feat: sync PlaybackQueue sequence with SceneList and pagination"
```

### Task 5: Remove "Add to Queue" UI

**Files:**
- Modify: `lib/features/scenes/presentation/widgets/scene_card.dart`
- Modify: `lib/features/scenes/presentation/pages/scene_details_page.dart`

- [ ] **Step 1: Remove from SceneCard context menu**
Delete the "Add to queue" `PopupMenuItem`.

- [ ] **Step 2: Remove from SceneDetailsPage AppBar**
Delete the "Add to queue" `IconButton` from the `AppBar`.

- [ ] **Step 3: Commit**
```bash
git add lib/features/scenes/presentation/widgets/scene_card.dart lib/features/scenes/presentation/pages/scene_details_page.dart
git commit -m "ui: remove all Add to Queue buttons"
```

### Task 6: Unify TikTok View

**Files:**
- Modify: `lib/features/scenes/presentation/widgets/tiktok_scenes_view.dart`

- [ ] **Step 1: Bind TikTok view to PlaybackQueue**
Update `TiktokScenesView` to use `PlaybackQueue.sequence` as its data source instead of `sceneListProvider` directly (or ensure they are perfectly in sync).
Update `onPageChanged` to call `PlaybackQueue.setIndex(index)`.

- [ ] **Step 2: Commit**
```bash
git add lib/features/scenes/presentation/widgets/tiktok_scenes_view.dart
git commit -m "feat: unify TikTok view with global PlaybackQueue sequence"
```

### Task 7: Verification

- [ ] **Step 1: Verify Unit Tests**
Run existing tests and add new ones for `PlaybackQueue`.
`flutter test test/features/scenes/playback_queue_test.dart` (create this file if needed).

- [ ] **Step 2: Manual Verification**
1. Load a list of scenes.
2. Play a scene.
3. Click "Next" in the bottom bar.
4. Verify it plays the next scene in the list.
5. Scroll to the bottom of the list to trigger pagination.
6. Verify "Next" continues into the newly loaded scenes.
7. Open TikTok view and swipe.
8. Go back to details view and verify "Next" picks up from where TikTok left off.

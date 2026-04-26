# Disable Scrubbing if VTT is Missing Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Explicitly disable the pan gesture on the `SceneCard` if the VTT URL is empty.

**Architecture:** Conditionally set `GestureDetector` callbacks to `null` based on the presence of the VTT URL.

**Tech Stack:** Flutter

---

### Task 1: Update GestureDetector in SceneCard

**Files:**
- Modify: `lib/features/scenes/presentation/widgets/scene_card.dart`

- [ ] **Step 1: Conditionally disable pan callbacks**

Update the `GestureDetector` in the `build` method (around line 160):

```dart
      child: GestureDetector(
        onPanStart: vttUrl.isNotEmpty ? (_) {
          setState(() {
            _isScrubbing = true;
          });
        } : null,
        onPanUpdate: vttUrl.isNotEmpty ? (details) {
          if (_isScrubbing) {
            final box = context.findRenderObject() as RenderBox;
            final localPos = box.globalToLocal(details.globalPosition);
            final relativePos = (localPos.dx / box.size.width).clamp(0.0, 1.0);
            setState(() {
              _scrubTime = relativePos * totalDuration;
            });
          }
        } : null,
        onPanEnd: vttUrl.isNotEmpty ? (_) {
          if (!isDesktop) {
            setState(() {
              _isScrubbing = false;
            });
          }
        } : null,
```

- [ ] **Step 2: Verify compilation**

Run: `flutter analyze`

- [ ] **Step 3: Commit**

```bash
git add lib/features/scenes/presentation/widgets/scene_card.dart
git commit -m "fix(scenes): disable pan gesture on scene card if VTT is missing"
```

### Task 2: Verification

- [ ] **Step 1: Run unit tests**

Run: `flutter test test/features/scenes/presentation/widgets/scene_card_test.dart`

- [ ] **Step 2: Add test case for disabled scrubbing (Optional but recommended)**

Add a test case in `test/features/scenes/presentation/widgets/scene_card_test.dart` to verify that `GestureDetector` callbacks are null or not triggered when VTT is missing.

- [ ] **Step 3: Commit final updates**

```bash
git add .
git commit -m "test: verify pan gesture is disabled when VTT is missing"
```

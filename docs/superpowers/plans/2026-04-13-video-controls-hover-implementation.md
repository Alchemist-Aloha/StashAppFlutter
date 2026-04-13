# Video Controls Hover Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Show video controls on mouse movement over the video player for desktop and web, and hide them after inactivity.

**Architecture:** Wrap the main video gesture area with a `MouseRegion` to detect `onHover` events. These events will trigger the existing `_showControlsTemporarily()` method, which handles showing the UI and resetting the auto-hide timer.

**Tech Stack:** Flutter (MouseRegion, GestureDetector, Timer)

---

### Task 1: Add MouseRegion to NativeVideoControls

**Files:**
- Modify: `lib/features/scenes/presentation/widgets/native_video_controls.dart`

- [ ] **Step 1: Wrap GestureDetector with MouseRegion**

In `lib/features/scenes/presentation/widgets/native_video_controls.dart`, find the `GestureDetector` within the `Stack` and wrap it with a `MouseRegion`.

```dart
<<<<
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: _toggleControls,
====
                      child: MouseRegion(
                        onHover: (_) => _showControlsTemporarily(),
                        onEnter: (_) => _showControlsTemporarily(),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: _toggleControls,
>>>>
```

- [ ] **Step 2: Ensure _showControlsTemporarily handles all states correctly**

The `_showControlsTemporarily()` method already exists. Verify its implementation and ensure it properly resets the timer.

```dart
  void _showControlsTemporarily() {
    if (!mounted) return;
    if (!_controlsVisible) {
      setState(() => _controlsVisible = true);
    }
    _scheduleAutoHide();
  }
```

- [ ] **Step 3: Verify the change**

Since I cannot interactively test a GUI, I will verify the code structure and ensure `_showControlsTemporarily` is called on hover.

- [ ] **Step 4: Commit**

```bash
git add lib/features/scenes/presentation/widgets/native_video_controls.dart
git commit -m "feat(video): show controls on mouse hover for desktop/web"
```

### Task 2: Regression Check for Mobile

- [ ] **Step 1: Code Review for Mobile Compatibility**

Verify that `MouseRegion` does not interfere with `GestureDetector` on touch devices. (Flutter's `MouseRegion` is designed to be ignored on touch).

- [ ] **Step 2: Final Verification of NativeVideoControls**

Check the final structure of `NativeVideoControls` to ensure everything is correct.

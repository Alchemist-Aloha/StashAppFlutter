# Fix Web Platform Errors and Image Decoding Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fix `Unsupported operation: Platform._environment` errors on web and improve image decoding by using the HTML renderer.

**Architecture:**
- Guards all `Platform` usage with `!kIsWeb`.
- Updates CI/CD to use the `--web-renderer html` flag for better image/CORS handling on web.

**Tech Stack:** Flutter, GitHub Actions.

---

### Task 1: Fix Platform Usage in Dart Code

**Files:**
- Modify: `lib/core/utils/pip_mode.dart`
- Modify: `lib/features/scenes/presentation/widgets/native_video_controls.dart`
- Modify: `lib/features/scenes/presentation/widgets/scene_video_player.dart`

- [ ] **Step 1: Fix PipMode**

```dart
// lib/core/utils/pip_mode.dart

// Update enterIfAvailable:
  static Future<bool> enterIfAvailable({double? aspectRatio}) async {
    if (kIsWeb || !Platform.isAndroid) return false;
```

- [ ] **Step 2: Fix NativeVideoControls**

```dart
// lib/features/scenes/presentation/widgets/native_video_controls.dart

// Update didChangeAppLifecycleState:
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!widget.enableNativePip || kIsWeb || !Platform.isAndroid) return;

// Update build (PiP button):
      if (widget.enableNativePip && !kIsWeb && Platform.isAndroid)
```

- [ ] **Step 3: Fix SceneVideoPlayer**

```dart
// lib/features/scenes/presentation/widgets/scene_video_player.dart

// Remove unused import:
// import 'dart:io';
```

- [ ] **Step 4: Commit**

```bash
git commit -am "fix(web): guard Platform usage and remove unused dart:io import"
```

---

### Task 2: Update CI/CD for Web Renderer

**Files:**
- Modify: `.github/workflows/release.yml`
- Modify: `.github/workflows/nightly-release.yml`

- [ ] **Step 1: Update release.yml**

```yaml
# .github/workflows/release.yml

          elif [ "${{ matrix.target }}" = "web" ]; then
            flutter build web --release --web-renderer html --base-href /StashFlow/
```

- [ ] **Step 2: Update nightly-release.yml**

```yaml
# .github/workflows/nightly-release.yml

          elif [ "${{ matrix.target }}" = "web" ]; then
            flutter build web --release --web-renderer html --base-href /StashFlow/
```

- [ ] **Step 3: Verify YAML syntax**

Run: `python3 -c "import yaml; yaml.safe_load(open('.github/workflows/release.yml')); yaml.safe_load(open('.github/workflows/nightly-release.yml'))"`
Expected: No output (success)

- [ ] **Step 4: Commit**

```bash
git add .github/workflows/release.yml .github/workflows/nightly-release.yml
git commit -m "fix(ci): use html renderer for web builds to improve image decoding"
```

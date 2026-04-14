# Fix Web Platform Errors and Image CORS Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fix `Unsupported operation: Platform._environment` errors on web and resolve thumbnail loading by appending the API key to the URL as a query parameter (bypassing CORS header issues).

**Architecture:**
- Use `appendApiKey` for web image URLs to bypass CORS header restrictions.
- Guard all `Platform` usage with `!kIsWeb`.
- Updates CI/CD to use the `--web-renderer html` flag.

**Tech Stack:** Flutter, GitHub Actions.

---

### Task 1: Fix StashImage Web URL Generation

**Files:**
- Modify: `lib/core/presentation/widgets/stash_image.dart`

- [ ] **Step 1: Import needed providers and utils**

```dart
// lib/core/presentation/widgets/stash_image.dart

import '../../data/graphql/url_resolver.dart';
import '../../data/graphql/graphql_client.dart';
```

- [ ] **Step 2: Update StashImage.build() to use query param for auth on web**

```dart
// lib/core/presentation/widgets/stash_image.dart

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildError(context);
    }

    final headers = ref.watch(mediaHeadersProvider);
    final apiKey = ref.watch(serverApiKeyProvider);

    if (kIsWeb) {
      // Append apikey to URL to bypass CORS header issues on web
      final webUrl = appendApiKey(imageUrl!, apiKey);
      return Image.network(
        webUrl,
        // No headers needed when apikey is in query params
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _buildError(context),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildPlaceholder(context);
        },
      );
    }
```

- [ ] **Step 3: Commit**

```bash
git commit -am "fix(web): use query parameter for image auth on web to bypass CORS"
```

---

### Task 2: Guard Platform Usage in Dart Code

**Files:**
- Modify: `lib/core/utils/pip_mode.dart`
- Modify: `lib/features/scenes/presentation/widgets/native_video_controls.dart`
- Modify: `lib/features/scenes/presentation/widgets/scene_video_player.dart`

- [ ] **Step 1: Fix PipMode**

```dart
// lib/core/utils/pip_mode.dart
  static Future<bool> enterIfAvailable({double? aspectRatio}) async {
    if (kIsWeb || !Platform.isAndroid) return false;
```

- [ ] **Step 2: Fix NativeVideoControls**

```dart
// lib/features/scenes/presentation/widgets/native_video_controls.dart
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!widget.enableNativePip || kIsWeb || !Platform.isAndroid) return;

// ... and the PiP button in build():
      if (widget.enableNativePip && !kIsWeb && Platform.isAndroid)
```

- [ ] **Step 3: Fix SceneVideoPlayer**

Remove `import 'dart:io';`.

- [ ] **Step 4: Commit**

```bash
git commit -am "fix(web): guard Platform usage and remove unused dart:io import"
```

---

### Task 3: Update CI/CD for Web Renderer

**Files:**
- Modify: `.github/workflows/release.yml`
- Modify: `.github/workflows/nightly-release.yml`

- [ ] **Step 1: Update release.yml**

```yaml
          elif [ "${{ matrix.target }}" = "web" ]; then
            flutter build web --release --web-renderer html --base-href /StashFlow/
```

- [ ] **Step 2: Update nightly-release.yml**

```yaml
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

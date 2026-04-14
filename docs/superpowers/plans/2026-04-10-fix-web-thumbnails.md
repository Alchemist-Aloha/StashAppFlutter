# Fix Web Thumbnails Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fix missing thumbnails in the web version of StashFlow by replacing `dart:io` usage and providing a web-friendly fallback for `CachedNetworkImage` that handles authentication headers and CORS better.

**Architecture:**
- Update `StashImage` to use `kIsWeb` detection.
- Replace `dart:io` with `package:flutter/foundation.dart`.
- Use `Image.network` on web with `headers` for basic auth support.
- Refactor `MediaCard` to use `StashImage` instead of raw `CachedNetworkImage`.

**Tech Stack:** Flutter Web, `cached_network_image`, `flutter_riverpod`.

---

### Task 1: Refactor StashImage for Web Compatibility

**Files:**
- Modify: `lib/core/presentation/widgets/stash_image.dart`

- [ ] **Step 1: Replace dart:io and handle web rendering**

Replace `import 'dart:io';` with `import 'package:flutter/foundation.dart';` and update `_ShimmerState` and `StashImage`.

```dart
// lib/core/presentation/widgets/stash_image.dart

// Replace:
// import 'dart:io';
// With:
import 'package:flutter/foundation.dart';

// ... in _ShimmerState.initState():
    // Replace Platform check with kIsWeb and kDebugMode/kReleaseMode
    // if (!Platform.environment.containsKey('FLUTTER_TEST')) {
    if (!kIsWeb) {
       _controller.repeat();
    }

// ... in StashImage.build():
    final headers = ref.watch(mediaHeadersProvider);

    if (kIsWeb) {
      return Image.network(
        imageUrl!,
        headers: headers,
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

- [ ] **Step 2: Add _buildPlaceholder helper**

```dart
  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: const Center(
        child: SizedBox(
          width: 48,
          height: 48,
          child: _Shimmer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
```

- [ ] **Step 3: Run verification tests**

Run: `flutter test test/widget_test.dart`
Expected: PASS

- [ ] **Step 4: Commit**

```bash
git add lib/core/presentation/widgets/stash_image.dart
git commit -m "fix(web): use Image.network and remove dart:io in StashImage"
```

---

### Task 2: Refactor MediaCard to use StashImage

**Files:**
- Modify: `lib/core/presentation/widgets/media_widgets.dart`

- [ ] **Step 1: Replace CachedNetworkImage with StashImage**

```dart
// lib/core/presentation/widgets/media_widgets.dart
import 'stash_image.dart'; // Add this

// In MediaCard.build():
// Replace CachedNetworkImage block with:
            AspectRatio(
              aspectRatio: aspectRatio,
              child: StashImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
```

- [ ] **Step 2: Commit**

```bash
git add lib/core/presentation/widgets/media_widgets.dart
git commit -m "refactor: use StashImage in MediaCard for better web support"
```

---

### Task 3: Fix other CachedNetworkImage occurrences

**Files:**
- Modify: `lib/features/scenes/presentation/pages/scene_edit_page.dart`
- Modify: `lib/features/scenes/presentation/pages/scene_details_page.dart`
- Modify: `lib/features/scenes/presentation/pages/scene_info_page.dart`

- [ ] **Step 1: Replace in scene pages**

Update these files to use `StashImage` where appropriate, or ensure they handle `kIsWeb`.

- [ ] **Step 2: Commit**

```bash
git commit -am "fix(web): replace direct CachedNetworkImage usage with StashImage or web fallbacks"
```

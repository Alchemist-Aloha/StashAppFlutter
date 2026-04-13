# Performance Improvement Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Improve data efficiency and perceived speed by implementing persistent disk caching for images and GraphQL metadata.

**Architecture:** 
1. Use `cached_network_image` via a global `StashImage` wrapper to persist binary image data.
2. Use `hive` + `graphql_flutter`'s `HiveStore` to persist GraphQL metadata across app restarts.
3. Optimize `FetchPolicy` to `cacheAndNetwork` for lists and `cacheFirst` for details.

**Tech Stack:** Flutter, Riverpod, GraphQL, Hive, CachedNetworkImage.

---

### Task 0: Benchmark Infrastructure

**Files:**
- Create: `test/benchmarks/baseline_performance_test.dart`

- [ ] **Step 1: Write the baseline benchmark test**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:stash_app_flutter/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Baseline Performance Benchmark', (tester) async {
    final stopwatch = Stopwatch()..start();
    await app.main(); // Ensure initialization completes
    await tester.pumpAndSettle();
    
    // Measure L1: Cold Launch Time
    stopwatch.stop();
    debugPrint('BENCHMARK: L1 Cold Launch = ${stopwatch.elapsedMilliseconds}ms');
    
    // N1: Counting network requests
    // (Verification will be manual or through log counting in Task 7)
    
    // M1: Memory Usage
    // Capture using tester's binding if supported, or manual check in Task 7.
  });
}
```

- [ ] **Step 2: Run benchmark to record baseline**
Run: `flutter test test/benchmarks/baseline_performance_test.dart`
Expected: Record the output L1 value.

- [ ] **Step 3: Commit**
```bash
git add test/benchmarks/baseline_performance_test.dart
git commit -m "test: add baseline performance benchmark"
```

---

### Task 1: Add Dependencies

**Files:**
- Modify: `pubspec.yaml`

- [ ] **Step 1: Add new packages**
```yaml
dependencies:
  # ... existing
  cached_network_image: ^3.4.1
  flutter_cache_manager: ^3.4.1
  hive_flutter: ^1.1.0
```

- [ ] **Step 2: Run pub get**
Run: `flutter pub get`
Expected: Success.

- [ ] **Step 3: Commit**
```bash
git add pubspec.yaml
git commit -m "chore: add caching and persistence dependencies"
```

---

### Task 2: Implement StashImage Wrapper

**Files:**
- Create: `lib/core/presentation/widgets/stash_image.dart`

- [ ] **Step 1: Write the StashImage widget**
```dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/graphql/media_headers_provider.dart';

class StashImage extends ConsumerWidget {
  const StashImage({
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.memCacheWidth,
    this.memCacheHeight,
    super.key,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int? memCacheWidth;
  final int? memCacheHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildError(context);
    }

    final headers = ref.watch(mediaHeadersProvider);

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      httpHeaders: headers,
      width: width,
      height: height,
      fit: fit,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      placeholder: (context, url) => Container(
        color: Colors.grey[900],
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      errorWidget: (context, url, error) => _buildError(context),
    );
  }

  Widget _buildError(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[800],
      child: const Center(child: Icon(Icons.broken_image, color: Colors.white54)),
    );
  }
}
```

- [ ] **Step 2: Commit**
```bash
git add lib/core/presentation/widgets/stash_image.dart
git commit -m "feat: implement StashImage global wrapper with disk caching"
```

---

### Task 3: Refactor Cards and Detail Pages to use StashImage

**Files:**
- Modify: `lib/features/scenes/presentation/widgets/scene_card.dart`
- Modify: `lib/features/performers/presentation/widgets/performer_card.dart`
- Modify: `lib/features/scenes/presentation/pages/scene_details_page.dart`
- Modify: `lib/features/performers/presentation/pages/performer_details_page.dart`
- Modify: `lib/features/studios/presentation/pages/studio_details_page.dart`
- Modify: `lib/features/tags/presentation/pages/tag_details_page.dart`
- Modify: `lib/core/presentation/widgets/media_strip.dart`

- [ ] **Step 1: Replace Image.network and NetworkImage with StashImage or CachedNetworkImageProvider in all listed files**
- Replace `Image.network` calls with `StashImage`.
- Replace `CircleAvatar(backgroundImage: NetworkImage(...))` with `CircleAvatar(backgroundImage: CachedNetworkImageProvider(...))`.
- Remove manual `headers: mediaHeaders` or similar.

- [ ] **Step 2: Verify with flutter analyze**
Run: `flutter analyze`
Expected: No errors in touched files.

- [ ] **Step 3: Commit**
```bash
git add lib/features/**/*.dart lib/core/presentation/widgets/media_strip.dart
git commit -m "refactor: use StashImage in all cards and detail pages"
```

---

### Task 4: Initialize Hive Persistence

**Files:**
- Modify: `lib/main.dart`

- [ ] **Step 1: Add Hive initialization via initHiveForFlutter**
```dart
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  // ... rest of main
}
```

- [ ] **Step 2: Commit**
```bash
git add lib/main.dart
git commit -m "feat: initialize Hive persistence on startup"
```

---

### Task 5: Configure Persistent GraphQL Cache

**Files:**
- Modify: `lib/core/data/graphql/graphql_client.dart`

- [ ] **Step 1: Replace InMemoryStore with HiveStore**
```dart
@riverpod
GraphQLClient graphqlClient(Ref ref) {
  // ... existing setup
  return GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: HiveStore()),
  );
}
```

- [ ] **Step 2: Commit**
```bash
git add lib/core/data/graphql/graphql_client.dart
git commit -m "feat: enable persistent HiveStore for GraphQL cache"
```

---

### Task 6: Optimize Fetch Policies in All Feature Repositories

**Files:**
- Modify: `lib/features/scenes/data/repositories/graphql_scene_repository.dart`
- Modify: `lib/features/performers/data/repositories/graphql_performer_repository.dart`
- Modify: `lib/features/studios/data/repositories/graphql_studio_repository.dart`
- Modify: `lib/features/tags/data/repositories/graphql_tag_repository.dart`
- Modify: `lib/features/galleries/data/repositories/graphql_gallery_repository.dart`
- Modify: `lib/features/groups/data/repositories/graphql_group_repository.dart`

- [ ] **Step 1: Set FetchPolicy to cacheAndNetwork for all findX (list) methods**
```dart
final QueryOptions options = QueryOptions(
  document: FIND_XYZ,
  variables: variables,
  fetchPolicy: FetchPolicy.cacheAndNetwork,
);
```

- [ ] **Step 2: Set FetchPolicy to cacheFirst for all findX (detail) methods**
```dart
final QueryOptions options = QueryOptions(
  document: FIND_XYZ,
  variables: {'id': id},
  fetchPolicy: FetchPolicy.cacheFirst,
);
```

- [ ] **Step 3: Commit**
```bash
git add lib/features/*/data/repositories/graphql_*_repository.dart
git commit -m "perf: optimize GraphQL fetch policies across all repositories"
```

---

### Task 7: Final Verification and Benchmarking

- [ ] **Step 1: Run warm launch benchmark**
Run: `flutter test test/benchmarks/baseline_performance_test.dart`
Expected: L2 value (Warm Launch) should be significantly lower than L1.

- [ ] **Step 2: Verify M1 (Peak Memory) while scrolling**
Manually scroll a long list of scenes and verify memory usage via DevTools.

- [ ] **Step 3: Verify N1 (Redundant Blocking Requests)**
Restart the app and verify the UI renders immediately from cache before any network spinner appears.

- [ ] **Step 4: Verify all tests pass**
Run: `flutter test`
Expected: Success.

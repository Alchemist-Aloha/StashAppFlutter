# Video Player Prewarm & Logging Fix Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Improve video playback cold start by caching stream URLs and optimizing prewarm logic, while fixing port number logging.

**Architecture:** 
1.  **Cache:** Implement a simple in-memory cache in `StreamResolver`.
2.  **Log Fix:** Update `_shortUrl` in `StreamResolver` to preserve port numbers.
3.  **UI Optimization:** Refactor `SceneVideoPlayer` to use lightweight `HEAD` requests for prewarm and avoid blocking player initialization.
4.  **Proactive Prewarm:** Update `PlayerState` to proactively resolve the next scene's URL in the background.

**Tech Stack:** Dart, Flutter, Riverpod, VideoPlayer.

---

### Task 1: Fix Logging in StreamResolver

**Files:**
- Modify: `lib/features/scenes/data/repositories/stream_resolver.dart`
- Test: `test/url_resolver_test.dart` (or create a new test for `StreamResolver` if needed)

- [ ] **Step 1: Write a test for `_shortUrl` (if possible) or verify via manual logs.**

- [ ] **Step 2: Update `_shortUrl` implementation.**

```dart
  String _shortUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return url;
    final portPart = uri.hasPort ? ':${uri.port}' : '';
    return '${uri.scheme}://${uri.host}$portPart${uri.path}';
  }
```

- [ ] **Step 3: Commit.**

```bash
git add lib/features/scenes/data/repositories/stream_resolver.dart
git commit -m "fix(stream_resolver): include port number in shortUrl logs"
```

---

### Task 2: Implement URL Caching in StreamResolver

**Files:**
- Modify: `lib/features/scenes/data/repositories/stream_resolver.dart`

- [ ] **Step 1: Add a cache map to `StreamResolver`.**

```dart
  final Map<String, StreamChoice> _urlCache = {};
```

- [ ] **Step 2: Update `resolvePreferredStream` to use and update the cache.**

```dart
    // At the start of resolvePreferredStream:
    if (_urlCache.containsKey(scene.id)) {
      AppLogStore.instance.add(
        'resolver hit cache scene=${scene.id} url=${_shortUrl(_urlCache[scene.id]!.url)}',
        source: 'stream_resolver',
      );
      return _urlCache[scene.id];
    }

    // Before returning the result:
    _urlCache[scene.id] = best;
    return best;
```

- [ ] **Step 3: Commit.**

```bash
git add lib/features/scenes/data/repositories/stream_resolver.dart
git commit -m "feat(stream_resolver): add in-memory URL caching"
```

---

### Task 3: Optimize Manual Prewarm in SceneVideoPlayer

**Files:**
- Modify: `lib/features/scenes/presentation/widgets/scene_video_player.dart`

- [ ] **Step 1: Refactor `_prewarmStream` to use `HEAD` and avoid draining.**

```dart
  Future<_PrewarmResult> _prewarmStream(Scene scene) async {
    final stopwatch = Stopwatch()..start();
    final client = HttpClient();
    client.connectionTimeout = const Duration(seconds: 5);

    try {
      if (!mounted) {
        return const _PrewarmResult(attempted: false, succeeded: false);
      }
      final resolver = ref.read(streamResolverProvider.notifier);
      final choice = await resolver.resolvePreferredStream(scene);
      if (choice == null) {
        return const _PrewarmResult(attempted: false, succeeded: false);
      }

      final uri = Uri.parse(choice.url);
      // Use HEAD request instead of GET for lightweight connection prewarm.
      final request = await client.headUrl(uri);

      if (!mounted) {
        return const _PrewarmResult(attempted: false, succeeded: false);
      }
      final headers = ref.read(mediaHeadersProvider);
      headers.forEach((key, value) {
        request.headers.add(key, value);
      });

      final response = await request.close();
      // No longer need to drain as HEAD response body is empty.
      stopwatch.stop();
      return _PrewarmResult(
        attempted: true,
        succeeded: response.statusCode < 400,
        latencyMs: stopwatch.elapsedMilliseconds,
      );
    } catch (_) {
      stopwatch.stop();
      return _PrewarmResult(
        attempted: true,
        succeeded: false,
        latencyMs: stopwatch.elapsedMilliseconds,
      );
    } finally {
      client.close(force: true);
    }
  }
```

- [ ] **Step 2: Update `_startPlaybackIfNeeded` to be non-blocking.**

Start `_prewarmStream` but don't await it before starting the actual resolution and player setup.

- [ ] **Step 3: Commit.**

```bash
git add lib/features/scenes/presentation/widgets/scene_video_player.dart
git commit -m "perf(scene_video_player): optimize manual prewarm with HEAD and non-blocking init"
```

---

### Task 4: Proactive Background Prewarm in PlayerState

**Files:**
- Modify: `lib/features/scenes/presentation/providers/video_player_provider.dart`

- [ ] **Step 1: Add a `_prewarmNext()` helper method to `PlayerState`.**

```dart
  void _prewarmNext() {
    final queue = ref.read(playbackQueueProvider);
    final nextIndex = queue.currentIndex + 1;
    if (nextIndex < queue.sequence.length) {
      final nextScene = queue.sequence[nextIndex];
      // Resolve URL in background to populate StreamResolver cache.
      unawaited(ref.read(streamResolverProvider.notifier).resolvePreferredStream(nextScene));
    }
  }
```

- [ ] **Step 2: Call `_prewarmNext()` in `playScene` and `attachController` after initialization.**

- [ ] **Step 3: Commit.**

```bash
git add lib/features/scenes/presentation/providers/video_player_provider.dart
git commit -m "feat(player_state): proactively prewarm next video in background"
```

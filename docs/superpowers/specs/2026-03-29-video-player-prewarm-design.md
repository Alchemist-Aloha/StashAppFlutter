# Design Spec: Video Player Prewarm & Logging Fix

**Date:** 2026-03-29
**Status:** Draft
**Topic:** Improving video playback cold start and fixing network logging.

## 1. Problem Statement

1.  **Manual Start Latency:** Manual playback initialization in `SceneVideoPlayer` suffers from a "cold start" wait. This is caused by a redundant `_prewarmStream` method that performs a full `GET` request and drains the response before the actual `VideoPlayerController` is initialized.
2.  **Redundant URL Resolution:** The stream URL is resolved twice (once for prewarm, once for playback), hitting the GraphQL API twice.
3.  **Missing Port in Logs:** The `StreamResolver` strips port numbers from URLs in logs, making it difficult to debug network issues when using non-standard ports (e.g., Stash running on 9999).

## 2. Proposed Changes

### 2.1. Fix Logging in `StreamResolver`
Modify `StreamResolver._shortUrl` to include the port number if it is present and not the default for the scheme.

### 2.2. Implement Stream URL Caching
Add an in-memory cache to the `StreamResolver` notifier.
- **Cache Key:** `scene.id`
- **Cache Value:** `StreamChoice`
- **Behavior:** `resolvePreferredStream` will check the cache before making a GraphQL query.

### 2.3. Optimize Manual Prewarm
Refactor `_SceneVideoPlayerState._prewarmStream` in `lib/features/scenes/presentation/widgets/scene_video_player.dart`:
- Replace the full `GET` request and `response.drain()` with a lightweight `HEAD` request.
- Ensure the prewarm doesn't block the actual player initialization.

### 2.4. Proactive Background Prewarm
Implement proactive prewarming for the playback queue in `PlayerState`:
- When a video starts playing, identify the "Next" scene in the `PlaybackQueue`.
- Trigger a background URL resolution for the next scene via `StreamResolver.prewarm(scene)`.
- This ensures that when the user clicks "Next", the URL is already cached and the transition is instant.

## 3. Architecture & Data Flow

1.  **User clicks Play:**
    - `SceneVideoPlayer` triggers `StreamResolver.resolvePreferredStream`.
    - If not in cache, GraphQL query runs and result is cached.
    - `VideoPlayerController` initializes immediately using the cached URL.
2.  **Playback Starts:**
    - `PlayerState` sees a new active scene.
    - It asks `PlaybackQueue` for the `nextScene`.
    - It calls `StreamResolver.resolvePreferredStream(nextScene)` in the background to warm the cache.
3.  **User clicks Next:**
    - `PlayerState.playNext()` is called.
    - It calls `StreamResolver.resolvePreferredStream(nextScene)`.
    - Result is returned instantly from cache.
    - New `VideoPlayerController` initializes without any API wait.

## 4. Testing Plan

- **Unit Tests:**
    - Verify `StreamResolver._shortUrl` includes the port.
    - Verify `StreamResolver` caches results and returns them on subsequent calls.
- **Integration/Manual Tests:**
    - Verify manual start in `SceneDetailsPage` is faster.
    - Check logs to confirm only one GraphQL query is made for manual starts.
    - Check logs to confirm "Next" video resolution happens in the background while the current video is playing.

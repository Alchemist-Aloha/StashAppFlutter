# Known Issues

## Closed Recently

### Stream resolver failed when query returned data with cache re-read exception

- Status: Closed (2026-03-19)
- Resolution: Resolver now ignores cache re-read noise when stream data is present, continues with returned stream candidates, and logs sanitized exception summaries.

### Scene title fallback crash on malformed percent-encoded file/stream path

- Status: Closed (2026-03-19)
- Resolution: Title fallback path decoding now uses safe decode with graceful fallback, preventing Illegal percent encoding crashes.

### Scene switch could throw No active player with ID N

- Status: Closed (2026-03-19)
- Resolution: Scene switch flow detaches active player widget state before disposing old native player bindings.

### Mini-player "Now Playing" tap restarted current playback

- Status: Closed (2026-03-19)
- Resolution: Kept player provider alive across route transitions so navigation to scene details no longer reinitializes the active media session.

### PiP showed scene details page instead of video-only content

- Status: Closed (2026-03-19)
- Resolution: PiP entry now prefers fullscreen player context and auto-enter on app pause only triggers from fullscreen playback state.

### Scene rating and play-count sorting mismatch

- Status: Closed (2026-03-19)
- Resolution: Switched to official sort keys with fallback handling.

### Performer/studio/tag scene-count sort mismatch

- Status: Closed (2026-03-19)
- Resolution: Aligned to `scenes_count` with compatibility fallback and local fallback sort.


## First video playback startup is slow

- Status: Mitigated in app, likely upstream/proxy cold-path (2026-03-19), still re-validating
- Area: Scene playback / streaming startup
- Severity: Medium

### Symptom

- The first scene playback in an app session may take around 8 seconds to start.
- Typical debug overlay values observed:
  - `mime: video/mp4`
  - `src: paths.stream+header`
  - `start: ~8350ms`

### What already works

- MIME detection now resolves correctly, including HTTP header probing fallback.
- Playback source selection works with setting-based control:
  - Try `sceneStreams` first, or
  - Directly use `paths.stream`.
- Auth headers are passed for stream requests.
- One-time prewarm call (ranged GET with headers) to `paths.stream` is implemented.

### Current understanding

- App-side root cause was identified: playback startup path awaited prewarm before calling player start, which could block for up to the prewarm timeout budget and matched the ~8 second delay pattern.
- Mitigation was applied: prewarm now runs in background and no longer blocks `playScene`.
- New timing instrumentation confirms most first-play delay is inside native `VideoPlayerController.initialize()` for the first stream request, while resolver/probe/prewarm/Chewie phases are fast.
- Chewie creation is effectively zero-cost in current traces (`chewieBuild=0ms`), so Chewie is not the startup bottleneck.
- Remaining variability is now strongly associated with upstream/reverse-proxy/backend first-request warm-up behavior (for example Caddy upstream cold path), not app UI/control logic.
- Additional instability can still come from provider lifecycle timing under rapid route/app-state transitions (disposed-ref errors observed in logs), which can mask startup timing diagnostics.
- Contextual playback queue and Autoplay Next may still help perceived latency, though full next-scene prefetch is not implemented.

### Next investigation ideas

- Re-measure first-play startup with Caddy bypassed versus through proxy for identical stream URL.
- Capture first-byte and response-start timing at proxy and upstream to isolate cold-path cost.
- For Caddy, verify stream-route reverse proxy behavior (streaming flush/compression/transport) and compare first request versus warmed request.
- Compare startup latency between stream variants for the same scene under identical conditions.
- Measure server-side first-request warm-up time to separate backend latency from client latency.
- Implement optional next-scene prefetch in PlaybackQueue.

## Optional Consistency Follow-ups

### Sort default direction consistency per field

- Status: Open
- Area: List-page UX consistency
- Severity: Low

### Lightweight list-page widget tests for sort/filter panel flows

- Status: Open
- Area: UI regression safety
- Severity: Low

<!-- UI_GUIDELINE_REF -->

## UI Guideline Reference
See [UIGUIDELINE.md](UIGUIDELINE.md) for current UI standards.

# Known Issues

## First video playback startup is slow

- Status: Open
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

- The remaining delay appears to be backend-side warm-up/cold-start behavior for initial stream access.
- Client-side source choice is no longer the primary blocker for startup.

### Next investigation ideas

- Measure startup time on the server side for first request versus warmed request.
- Compare startup latency between stream variants for the same scene under identical conditions.
- Consider optional background prewarm earlier in app lifecycle (for users who opt in).

# Debugging Playbook

## Networking and server config

Symptoms:
- Host lookup or invalid URI errors

Checks:
1. Verify saved URL and key in Settings page.
2. Ensure URL has scheme (`https://...`).
3. Confirm INTERNET permission exists in Android main manifest for release behavior.

## GraphQL works but media fails

Symptoms:
- Lists load but thumbnails/video fail

Checks:
1. Confirm media URL resolution for relative paths.
2. Confirm `ApiKey` header is sent for media HTTP requests.
3. Compare failing URL against resolved absolute URL.

## Stream playback starts slowly

Symptoms:
- First playback in app session has high startup latency

Checks:
1. Read debug overlay (`mime`, `src`, `start`).
2. Verify stream strategy setting (`prefer_scene_streams`).
3. Confirm one-time prewarm request executed.
4. Compare first request vs second request latency for same scene.

Interpretation:
- If MIME is valid and only first start is slow, likely backend warm-up/cold-start.

## Schema mismatch issues

Symptoms:
- GraphQL fields missing at runtime

Checks:
1. Remove unsupported fields from operation documents.
2. Regenerate code.
3. Re-run analyze/tests.

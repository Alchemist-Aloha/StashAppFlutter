# Architecture Map

## App Stack

- Flutter app
- State management: Riverpod + generated providers
- Navigation: GoRouter
- Data: GraphQL (`graphql_flutter` + generated models)
- Persistence: SharedPreferences
- Video: `video_player` + `chewie`

## Key Folders

- `lib/core`
  - Shared infrastructure (GraphQL client, prefs provider, URL/header helpers)
- `lib/features`
  - Domain modules: scenes, performers, studios, tags, galleries, groups, setup, navigation
- `lib/features/setup`
  - Runtime server settings UI
- `lib/features/scenes`
  - Scene list/details, stream resolution, player startup diagnostics
- `graphql`
  - Schemas and source operation files
- `test` and `integration_test`
  - Unit/widget/integration coverage

## Stream Playback Path (high level)

1. Scene details opens player widget.
2. Settings decide source strategy:
   - prefer scene streams, or
   - direct `paths.stream`.
3. URL is resolved; headers are attached.
4. Optional one-time prewarm request runs.
5. Video controller initializes and starts playback.
6. Debug label shows MIME, source, and startup timing.

## Runtime settings that affect behavior

- `server_base_url`
- `server_api_key`
- `prefer_scene_streams`

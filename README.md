# 📱 StashAppFlutter
### Your Stash library, everywhere.

A mobile-first Flutter client for your **Stash** server. Designed for seamless browsing, effortless discovery, and high-quality playback on the go.

![StashAppFlutter Showcase](docs/assets/showcase.png)
*(Screenshot coming soon)*

## Current Highlights

- Scene, performer, studio, and tag browsing with pagination and search.
- Menu-based sorting/filtering across list pages.
- Floating random-discovery actions on list pages (Scenes, Performers, Studios, Tags).
- Scene playback with stream strategy toggles and startup diagnostics.
- Settings-driven runtime server config (URL + API key) and UI preferences.

## Tech Stack

- Flutter
- Riverpod (providers + generated notifiers)
- GoRouter
- GraphQL (`graphql_flutter` + `graphql_codegen` generated classes)
- SharedPreferences

## Quick Start

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Build

```bash
flutter build apk
```

## Regenerate Generated Code

Run this after editing GraphQL documents/schema mappings or generated-provider inputs:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Runtime Settings

Configured inside the app Settings page:

- `server_base_url`
- `server_api_key`
- `prefer_scene_streams`
- `scene_grid_layout`

## Project Structure

- `lib/core` shared infrastructure
- `lib/features/*` feature modules (domain/data/presentation)
- `graphql/` schema and GraphQL documents
- `docs/` internal runbooks and architecture notes

## Documentation

- `docs/README.md` docs index
- `docs/AGENT_START_HERE.md` quick onboarding checklist
- `docs/ARCHITECTURE_MAP.md` architecture and data-flow overview
- `docs/DEBUGGING_PLAYBOOK.md` troubleshooting patterns
- `docs/KNOWNISSUES.md` actively tracked issues

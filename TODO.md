# StashAppFlutter MVP TODO

## 1. Infrastructure & Core Setup (100% DONE)
- [x] Flutter project scaffolded
- [x] Dependencies added (Riverpod, GoRouter, GraphQL, Video Player)
- [x] Directory structure created
- [x] Initial GoRouter configuration (ShellRoute)
- [x] GraphQL Client provider (Needs production refinement)
- [x] **FIXED**: Corrected `build.yaml` for `graphql_codegen` (schema path and output directory)
- [x] Implement `shared_preferences` persistence for Server URL and API Key in `SettingsPage`.

## 2. Performer Feature (100% DONE)
- [x] Define `Performer` domain entity
- [x] Define `PerformerRepository` interface
- [x] Implement `GraphQLPerformerRepository` using generated GraphQL classes.
- [x] Create `PerformerListProvider` (AsyncNotifier)
- [x] Implement infinite scroll / pagination.
- [x] Implement Performer detail page.

## 3. Scene Feature (100% DONE)
- [x] Expand `Scene` domain entity with technical and rich metadata.
- [x] Create `SceneCard` widget.
- [x] Create `ScenesPage` and `SceneDetailsPage`.
- [x] Create `SceneListProvider` (AsyncNotifier).
- [x] Update `lib/features/scenes/data/graphql/scenes.graphql` with fragments (`SlimSceneData`, `SceneData`).
- [x] Update `GraphQLSceneRepository` to use generated GraphQL classes.
- [x] Implement pagination/infinite scroll in `SceneListProvider`.
- [x] Implement Search in AppBar.

## 4. Playback & State Sync (100% DONE)
- [x] Create `video_player_provider.dart` for global player state.
- [x] Create `MiniPlayer` widget connected to global state.
- [x] Implement `SceneVideoPlayer` using **Chewie**.
- [x] Ensure persistence across navigation (MiniPlayer <-> Details).

## 5. Other Features (Studios, Tags, Galleries, Groups) (100% DONE)
- [x] Define domain entities and repository interfaces for Studios and Tags.
- [x] Implement GraphQL repositories for Studios and Tags.
- [x] Create basic list/grid UIs for Studios and Tags.
- [x] Implement Galleries and Groups.

## 6. Testing & Validation (95% DONE)
- [x] Unit tests for entity parsing (Freezed/JSON).
- [x] Mock repositories for UI testing.
- [x] Integration tests for core flow (Browse -> Search -> Play).

### Verification Status
- [x] `flutter analyze`
- [x] `flutter test`
- [ ] `flutter test integration_test/core_flow_test.dart` in this environment (blocked: no supported connected device)

---

### Note on GraphQL Files
The copied files in `graphql/schema/**` and `graphql/stash-box/**` are **HIGHLY USEFUL**:
- **Reference**: The decomposed schema types make it easy to discover available fields and types when writing fragments.
- **StashBox**: The queries in `stash-box/` are ready-to-use for future metadata fetching/searching against external sources.

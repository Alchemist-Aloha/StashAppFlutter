# findScenes — GraphQL endpoint

## Purpose
High-level purpose of `findScenes` and when to use it from the client.

## GraphQL operation (source)
- Source file: `stash/ui/v2.5/graphql/queries/scene.graphql`

```graphql

```

## Variables
| Name | Type | Default |
|---|---|---|

## Schema type definitions for inputs

## Referenced fragments / response shape
- No fragments referenced in this operation

## Server-side files to inspect
- `stash/graphql/schema/schema.graphql`
- `graphql/schema/schema.graphql`
- `stash/graphql/schema/types/scene.graphql`
- `stash/graphql/schema/types/filters.graphql`
- `pkg/sqlite/scene_filter.go`
- `pkg/sqlite/filter.go`
- `pkg/sqlite/criterion_handlers.go`

## TypeScript UI usage (approx locations)
- `stash/ui/v2.5/src/components/SceneDuplicateChecker/SceneDuplicateChecker.tsx` (line ~348) — snippet: `const missingPhashes = missingPhash?.findScenes.count ?? 0;`
- `stash/ui/v2.5/src/components/Scenes/SceneList.tsx` (line ~64) — snippet: `const duration = result?.data?.findScenes?.duration;`
- `stash/ui/v2.5/src/components/Scenes/SceneList.tsx` (line ~65) — snippet: `const size = result?.data?.findScenes?.filesize;`
- `stash/ui/v2.5/src/components/Scenes/SceneList.tsx` (line ~157) — snippet: `const scene = queryResults.data.findScenes.scenes[index];`
- `stash/ui/v2.5/src/components/Scenes/SceneList.tsx` (line ~393) — snippet: `getCount: (r) => r.data?.findScenes.count ?? 0,`
- `stash/ui/v2.5/src/components/Scenes/SceneList.tsx` (line ~394) — snippet: `getItems: (r) => r.data?.findScenes.scenes ?? [],`
- `stash/ui/v2.5/src/components/Scenes/SceneMergeDialog.tsx` (line ~743) — snippet: `const { scenes: loadedScenes } = query.data.findScenes;`
- `stash/ui/v2.5/src/components/Scenes/SceneDetails/Scene.tsx` (line ~839) — snippet: `const { scenes, count } = query.data.findScenes;`
- `stash/ui/v2.5/src/components/Scenes/SceneDetails/Scene.tsx` (line ~847) — snippet: `const { scenes, count } = query.data.findScenes;`
- `stash/ui/v2.5/src/components/Scenes/SceneDetails/Scene.tsx` (line ~870) — snippet: `const { scenes } = query.data.findScenes;`
- `stash/ui/v2.5/src/components/Scenes/SceneDetails/Scene.tsx` (line ~893) — snippet: `const { scenes } = query.data.findScenes;`
- `stash/ui/v2.5/src/components/Scenes/SceneDetails/Scene.tsx` (line ~961) — snippet: `if (queryResults.data.findScenes.scenes.length > index) {`
- `stash/ui/v2.5/src/components/Scenes/SceneDetails/Scene.tsx` (line ~962) — snippet: `const { id: sceneID } = queryResults.data.findScenes.scenes[index];`
- `stash/ui/v2.5/src/components/Scenes/SceneSelect.tsx` (line ~56) — snippet: `>["data"]["findScenes"]["scenes"];`
- `stash/ui/v2.5/src/components/Scenes/SceneSelect.tsx` (line ~100) — snippet: `const matches = query.data.findScenes.scenes.filter(filterExcluded);`
- `stash/ui/v2.5/src/components/Scenes/SceneSelect.tsx` (line ~114) — snippet: `const ret = query.data.findScenes.scenes.filter(filterExcluded);`
- `stash/ui/v2.5/src/components/Scenes/SceneSelect.tsx` (line ~261) — snippet: `const { scenes: loadedScenes } = query.data.findScenes;`
- `stash/ui/v2.5/src/components/Scenes/SceneRecommendationRow.tsx` (line ~19) — snippet: `const count = result.data?.findScenes.count ?? 0;`
- `stash/ui/v2.5/src/components/Scenes/SceneRecommendationRow.tsx` (line ~39) — snippet: `: result.data?.findScenes.scenes.map((scene, index) => (`

## Example variables (JSON)
```json
{
  "filter": {
    "q": "",
    "page": 1,
    "per_page": 20,
    "sort": "created_at",
    "direction": "DESC"
  }
}
```

## SQL translation & criterion handlers
- The server converts CriterionInput types to SQL fragments in `pkg/sqlite/criterion_handlers.go` and composes WHERE via `pkg/sqlite/filter.go`. Per-entity filter files are under `pkg/sqlite/*_filter.go`.

## Performance notes
- Column-based filters/sorts are fast; JOIN/aggregate/PHASH filters require caution.

## Verification / tests
- Run the operation in GraphiQL or the web UI and assert the returned fields and counts. Add unit tests for criterion handlers.

## Open questions
- Confirm exact allowed sort key strings and behavior for unknown sort keys in server code.
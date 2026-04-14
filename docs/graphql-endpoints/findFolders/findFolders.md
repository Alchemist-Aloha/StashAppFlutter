# findFolders — GraphQL endpoint

## Purpose
High-level purpose of `findFolders` and when to use it from the client.

## GraphQL operation (source)
- Source file: `stash/ui/v2.5/graphql/queries/folder.graphql`

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
- `stash/graphql/schema/types/file.graphql`
- `stash/graphql/schema/types/filters.graphql`
- `pkg/sqlite/file.go`
- `pkg/sqlite/filter.go`

## TypeScript UI usage (approx locations)
- `stash/ui/v2.5/src/components/List/Filters/FolderFilter.tsx` (line ~217) — snippet: `const ret = rootFoldersResult?.findFolders.folders ?? [];`
- `stash/ui/v2.5/src/components/List/Filters/FolderFilter.tsx` (line ~223) — snippet: `(initialSelectedResult?.findFolders.folders ?? []).forEach((folder) => {`
- `stash/ui/v2.5/src/components/List/Filters/FolderFilter.tsx` (line ~307) — snippet: `(queryFoldersResult?.findFolders.folders ?? []).forEach((folder) => {`
- `stash/ui/v2.5/src/components/List/Filters/FolderFilter.tsx` (line ~394) — snippet: `children: subFolderResult.data.findFolders.folders.map((f) => ({`

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
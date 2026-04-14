# file_filter — GraphQL operation (basic)

Purpose
---
High-level purpose of `file_filter` (from schema).

Schema signature
---
```graphql
    file_filter: FileFilterType
```

Defined in schema
---
- `graphql/schema/schema.graphql`

UI operation file(s) (where operation is defined)
---
- (no UI operation file found in ui graphql directories)

UI usage (approx locations)
---
- `stash/ui/v2.5/src/components/List/Filters/FolderFilter.tsx` (line ~197)

Server-side references (heuristic)
---
- `graphql/schema/schema.graphql`
- `graphql/schema/types/file.graphql`
- `graphql/schema/types/filters.graphql`
- `pkg/sqlite/file.go`

Verification
---
- Run this operation in GraphiQL or via the UI and verify returned fields and counts.

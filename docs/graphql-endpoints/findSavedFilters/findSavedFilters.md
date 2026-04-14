# findSavedFilters — GraphQL operation (basic)

Purpose
---
High-level purpose of `findSavedFilters` (from schema).

Schema signature
---
```graphql
  findSavedFilters(mode: FilterMode): [SavedFilter!]!
```

Defined in schema
---
- `graphql/schema/schema.graphql`

UI operation file(s) (where operation is defined)
---
- (no UI operation file found in ui graphql directories)

UI usage (approx locations)
---
- `stash/ui/v2.5/src/components/FrontPage/FrontPageConfig.tsx` (line ~94)
- `stash/ui/v2.5/src/components/FrontPage/FrontPageConfig.tsx` (line ~291)
- `stash/ui/v2.5/src/components/FrontPage/FrontPageConfig.tsx` (line ~302)
- `stash/ui/v2.5/src/components/FrontPage/FrontPageConfig.tsx` (line ~387)
- `stash/ui/v2.5/src/components/List/SavedFilterList.tsx` (line ~79)
- `stash/ui/v2.5/src/components/List/SavedFilterList.tsx` (line ~83)
- `stash/ui/v2.5/src/components/List/SavedFilterList.tsx` (line ~107)
- `stash/ui/v2.5/src/components/List/SavedFilterList.tsx` (line ~171)
- `stash/ui/v2.5/src/components/List/SavedFilterList.tsx` (line ~273)
- `stash/ui/v2.5/src/components/List/SavedFilterList.tsx` (line ~635)
- `stash/ui/v2.5/src/components/List/SavedFilterList.tsx` (line ~642)

Server-side references (heuristic)
---
- `graphql/schema/schema.graphql`

Verification
---
- Run this operation in GraphiQL or via the UI and verify returned fields and counts.

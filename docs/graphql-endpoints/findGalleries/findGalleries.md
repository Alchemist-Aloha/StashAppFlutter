# findGalleries — GraphQL endpoint

## Purpose
High-level purpose of `findGalleries` and when to use it from the client.

## GraphQL operation (source)
- Source file: `stash/ui/v2.5/graphql/queries/gallery.graphql`

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
- `stash/graphql/schema/types/gallery.graphql`
- `stash/graphql/schema/types/filters.graphql`
- `pkg/sqlite/gallery.go`

## TypeScript UI usage (approx locations)
- `stash/ui/v2.5/src/components/Galleries/GallerySelect.tsx` (line ~55) — snippet: `>["data"]["findGalleries"]["galleries"];`
- `stash/ui/v2.5/src/components/Galleries/GallerySelect.tsx` (line ~98) — snippet: `let ret = query.data.findGalleries.galleries.filter((gallery) => {`
- `stash/ui/v2.5/src/components/Galleries/GallerySelect.tsx` (line ~301) — snippet: `const { galleries: loadedGalleries } = query.data.findGalleries;`
- `stash/ui/v2.5/src/components/Galleries/GalleryList.tsx` (line ~224) — snippet: `if (singleResult.data.findGalleries.galleries.length === 1) {`
- `stash/ui/v2.5/src/components/Galleries/GalleryList.tsx` (line ~225) — snippet: `const { id } = singleResult.data.findGalleries.galleries[0];`
- `stash/ui/v2.5/src/components/Galleries/GalleryList.tsx` (line ~275) — snippet: `getCount: (r) => r.data?.findGalleries.count ?? 0,`
- `stash/ui/v2.5/src/components/Galleries/GalleryList.tsx` (line ~276) — snippet: `getItems: (r) => r.data?.findGalleries.galleries ?? [],`
- `stash/ui/v2.5/src/components/Galleries/GalleryRecommendationRow.tsx` (line ~18) — snippet: `const count = result.data?.findGalleries.count ?? 0;`
- `stash/ui/v2.5/src/components/Galleries/GalleryRecommendationRow.tsx` (line ~37) — snippet: `: result.data?.findGalleries.galleries.map((g) => (`

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
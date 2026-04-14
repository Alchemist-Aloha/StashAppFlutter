# findGallery — GraphQL endpoint

## Purpose
High-level purpose of `findGallery` and when to use it from the client.

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
- `stash/ui/v2.5/src/core/createClient.ts` (line ~52) — snippet: `findGallery: {`
- `stash/ui/v2.5/src/components/Galleries/Galleries.tsx` (line ~36) — snippet: `if (!data?.findGallery)`
- `stash/ui/v2.5/src/components/Galleries/Galleries.tsx` (line ~39) — snippet: `return <Redirect to={`/images/${data.findGallery.image.id}`} />;`
- `stash/ui/v2.5/src/components/Galleries/GalleryDetails/Gallery.tsx` (line ~477) — snippet: `if (!data?.findGallery)`
- `stash/ui/v2.5/src/components/Galleries/GalleryDetails/Gallery.tsx` (line ~481) — snippet: `return <GalleryPage add gallery={data.findGallery} />;`
- `stash/ui/v2.5/src/components/Galleries/GalleryDetails/Gallery.tsx` (line ~495) — snippet: `return <GalleryPage gallery={data.findGallery} />;`

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
# findImage — GraphQL endpoint

## Purpose
High-level purpose of `findImage` and when to use it from the client.

## GraphQL operation (source)
- Source file: `stash/ui/v2.5/graphql/queries/image.graphql`

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
- `stash/graphql/schema/types/image.graphql`
- `stash/graphql/schema/types/filters.graphql`
- `pkg/sqlite/image.go`
- `pkg/image/service.go`
- `pkg/image/thumbnail.go`
- `pkg/sqlite/filter.go`

## TypeScript UI usage (approx locations)
- `stash/ui/v2.5/src/hooks/Lightbox/hooks.ts` (line ~78) — snippet: `const totalCount = data?.findImages.count ?? 0;`
- `stash/ui/v2.5/src/hooks/Lightbox/hooks.ts` (line ~80) — snippet: `}, [data?.findImages.count]);`
- `stash/ui/v2.5/src/hooks/Lightbox/hooks.ts` (line ~113) — snippet: `images: data.findImages?.images ?? [],`
- `stash/ui/v2.5/src/hooks/Lightbox/hooks.ts` (line ~132) — snippet: `images: data.findImages?.images ?? [],`
- `stash/ui/v2.5/src/core/createClient.ts` (line ~40) — snippet: `findImage: {`
- `stash/ui/v2.5/src/components/Galleries/GalleryViewer.tsx` (line ~38) — snippet: `const images = useMemo(() => data?.findImages?.images ?? [], [data]);`
- `stash/ui/v2.5/src/components/Shared/Select.tsx` (line ~276) — snippet: `const images = data?.findImages.images ?? [];`
- `stash/ui/v2.5/src/components/Images/ImageRecommendationRow.tsx` (line ~18) — snippet: `const count = result.data?.findImages.count ?? 0;`
- `stash/ui/v2.5/src/components/Images/ImageRecommendationRow.tsx` (line ~34) — snippet: `: result.data?.findImages.images.map((i) => (`
- `stash/ui/v2.5/src/components/Images/ImageList.tsx` (line ~341) — snippet: `const megapixels = metadataInfo?.data?.findImages?.megapixels;`
- `stash/ui/v2.5/src/components/Images/ImageList.tsx` (line ~342) — snippet: `const size = metadataInfo?.data?.findImages?.filesize;`
- `stash/ui/v2.5/src/components/Images/ImageList.tsx` (line ~480) — snippet: `if (singleResult.data.findImages.images.length === 1) {`
- `stash/ui/v2.5/src/components/Images/ImageList.tsx` (line ~481) — snippet: `const { id } = singleResult.data.findImages.images[0];`
- `stash/ui/v2.5/src/components/Images/ImageList.tsx` (line ~556) — snippet: `getCount: (r) => r.data?.findImages.count ?? 0,`
- `stash/ui/v2.5/src/components/Images/ImageList.tsx` (line ~557) — snippet: `getItems: (r) => r.data?.findImages.images ?? [],`
- `stash/ui/v2.5/src/components/Images/ImageDetails/Image.tsx` (line ~411) — snippet: `if (!data?.findImage)`
- `stash/ui/v2.5/src/components/Images/ImageDetails/Image.tsx` (line ~414) — snippet: `return <ImagePage image={data.findImage} />;`

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
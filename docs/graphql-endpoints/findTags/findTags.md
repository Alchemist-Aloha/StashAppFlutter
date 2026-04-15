# findTags — GraphQL endpoint

## Purpose
High-level purpose of `findTags` and when to use it from the client.

## GraphQL operation (source)
- Source file: `stash/ui/v2.5/graphql/queries/tag.graphql`

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
- `stash/graphql/schema/types/tag.graphql`
- `stash/graphql/schema/types/filters.graphql`
- `pkg/sqlite/tag.go`

## TypeScript UI usage (approx locations)
- `stash/ui/v2.5/src/components/Tags/TagList.tsx` (line ~167) — snippet: `if (singleResult.data.findTags.tags.length === 1) {`
- `stash/ui/v2.5/src/components/Tags/TagList.tsx` (line ~168) — snippet: `const { id } = singleResult.data.findTags.tags[0];`
- `stash/ui/v2.5/src/components/Tags/TagList.tsx` (line ~227) — snippet: `getCount: (r) => r.data?.findTags.count ?? 0,`
- `stash/ui/v2.5/src/components/Tags/TagList.tsx` (line ~228) — snippet: `getItems: (r) => r.data?.findTags.tags ?? [],`
- `stash/ui/v2.5/src/components/Tags/TagMergeDialog.tsx` (line ~451) — snippet: `const { tags: loadedTags } = query.data.findTags;`
- `stash/ui/v2.5/src/components/Tags/TagRecommendationRow.tsx` (line ~18) — snippet: `const count = result.data?.findTags.count ?? 0;`
- `stash/ui/v2.5/src/components/Tags/TagRecommendationRow.tsx` (line ~34) — snippet: `: result.data?.findTags.tags.map((p) => (`
- `stash/ui/v2.5/src/components/Tagger/queries.ts` (line ~128) — snippet: `findTags: {`
- `stash/ui/v2.5/src/components/Tags/TagSelect.tsx` (line ~50) — snippet: `>["data"]["findTags"]["tags"];`
- `stash/ui/v2.5/src/components/Tags/TagSelect.tsx` (line ~98) — snippet: `const matches = query.data.findTags.tags.filter(filterExcluded);`
- `stash/ui/v2.5/src/components/Tags/TagSelect.tsx` (line ~112) — snippet: `const ret = query.data.findTags.tags.filter(filterExcluded);`
- `stash/ui/v2.5/src/components/Tags/TagSelect.tsx` (line ~295) — snippet: `const { tags: loadedTags } = query.data.findTags;`
- `stash/ui/v2.5/src/components/List/Filters/TagsFilter.tsx` (line ~83) — snippet: `() => sortResults(query, data?.findTags.tags ?? []),`
- `stash/ui/v2.5/src/components/Tagger/tags/TagTagger.tsx` (line ~431) — snippet: `allCount={allTags?.findTags.count}`
- `stash/ui/v2.5/src/components/Tagger/tags/TagTagger.tsx` (line ~509) — snippet: `ac.cache.evict({ fieldName: "findTags" });`
- `stash/ui/v2.5/src/components/Tagger/tags/TagModal.tsx` (line ~73) — snippet: `const existingParentId = parentNameQuery.data?.findTags.tags[0]?.id;`

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
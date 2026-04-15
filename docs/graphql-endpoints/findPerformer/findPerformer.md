# findPerformer — GraphQL endpoint

## Purpose
High-level purpose of `findPerformer` and when to use it from the client.

## GraphQL operation (source)
- Source file: `stash/ui/v2.5/graphql/queries/performer.graphql`

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
- `stash/graphql/schema/types/performer.graphql`
- `stash/graphql/schema/types/filters.graphql`
- `pkg/sqlite/performer.go`
- `pkg/sqlite/filter.go`

## TypeScript UI usage (approx locations)
- `stash/ui/v2.5/src/core/createClient.ts` (line ~43) — snippet: `findPerformer: {`
- `stash/ui/v2.5/src/components/List/Filters/PerformersFilter.tsx` (line ~87) — snippet: `() => sortResults(query, data?.findPerformers.performers),`
- `stash/ui/v2.5/src/components/Performers/PerformerList.tsx` (line ~340) — snippet: `if (singleResult.data.findPerformers.performers.length === 1) {`
- `stash/ui/v2.5/src/components/Performers/PerformerList.tsx` (line ~341) — snippet: `const { id } = singleResult.data.findPerformers.performers[0];`
- `stash/ui/v2.5/src/components/Performers/PerformerList.tsx` (line ~398) — snippet: `getCount: (r) => r.data?.findPerformers.count ?? 0,`
- `stash/ui/v2.5/src/components/Performers/PerformerList.tsx` (line ~399) — snippet: `getItems: (r) => r.data?.findPerformers.performers ?? [],`
- `stash/ui/v2.5/src/components/Performers/PerformerDetails/Performer.tsx` (line ~551) — snippet: `if (!data?.findPerformer)`
- `stash/ui/v2.5/src/components/Performers/PerformerDetails/Performer.tsx` (line ~567) — snippet: `performer={data.findPerformer}`
- `stash/ui/v2.5/src/components/Tagger/scenes/PerformerResult.tsx` (line ~70) — snippet: `const matchedPerformer = performerData?.findPerformer;`
- `stash/ui/v2.5/src/components/Tagger/scenes/PerformerResult.tsx` (line ~91) — snippet: `performerData?.findPerformer &&`
- `stash/ui/v2.5/src/components/Tagger/scenes/PerformerResult.tsx` (line ~92) — snippet: `selectedID === performerData?.findPerformer?.id`
- `stash/ui/v2.5/src/components/Tagger/scenes/PerformerResult.tsx` (line ~94) — snippet: `setSelectedPerformer(performerData.findPerformer);`
- `stash/ui/v2.5/src/components/Tagger/scenes/PerformerResult.tsx` (line ~96) — snippet: `}, [performerData?.findPerformer, selectedID]);`
- `stash/ui/v2.5/src/components/Performers/PerformerPopover.tsx` (line ~26) — snippet: `if (!data?.findPerformer)`
- `stash/ui/v2.5/src/components/Performers/PerformerPopover.tsx` (line ~29) — snippet: `const performer = data.findPerformer;`
- `stash/ui/v2.5/src/components/Performers/PerformerRecommendationRow.tsx` (line ~18) — snippet: `const count = result.data?.findPerformers.count ?? 0;`
- `stash/ui/v2.5/src/components/Performers/PerformerRecommendationRow.tsx` (line ~37) — snippet: `: result.data?.findPerformers.performers.map((p) => (`
- `stash/ui/v2.5/src/components/Tagger/context.tsx` (line ~646) — snippet: `if (queryResult.data.findPerformer) {`
- `stash/ui/v2.5/src/components/Tagger/context.tsx` (line ~647) — snippet: `const target = queryResult.data.findPerformer;`
- `stash/ui/v2.5/src/components/Performers/PerformerMergeDialog.tsx` (line ~781) — snippet: `const { performers: loadedPerformers } = query.data.findPerformers;`
- `stash/ui/v2.5/src/components/Tagger/queries.ts` (line ~38) — snippet: `findPerformers: {`
- `stash/ui/v2.5/src/components/Tagger/performers/PerformerTagger.tsx` (line ~82) — snippet: `? allPerformers?.findPerformers.count`
- `stash/ui/v2.5/src/components/Performers/PerformerSelect.tsx` (line ~59) — snippet: `>["data"]["findPerformers"]["performers"];`
- `stash/ui/v2.5/src/components/Performers/PerformerSelect.tsx` (line ~117) — snippet: `query.data.findPerformers.performers.filter(filterExcluded);`
- `stash/ui/v2.5/src/components/Performers/PerformerSelect.tsx` (line ~131) — snippet: `query.data.findPerformers.performers.filter(filterExcluded)`
- `stash/ui/v2.5/src/components/Performers/PerformerSelect.tsx` (line ~372) — snippet: `const { performers: loadedPerformers } = query.data.findPerformers;`

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
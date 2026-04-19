## Stage
- team-verify

## Goal / Non-goals
### Goals
- **Fallback Search String**: In `SceneEditPage`, if the title is empty, use the filestem from the scene path as the initial query for `ScrapeQueryDialog`. [DONE]
- **Improve Scraper Loading**: Update GraphQL queries and domain models to correctly load all types of scrapers (local/community), not just Stashbox endpoints. [DONE]
- **Scraper UI Refinement**: Distinguish between "Queryable" (search-based) and "Fragment" (ID/URL based) scrapers in the UI, matching official Stash behavior. [DONE]
- **Automated Filename Parsing**: Implement a utility to extract a clean filestem from a path. [DONE]

### Non-goals
- Full parity with every niche feature of the official Stash webapp's scraper dialog.
- Implementing automatic background scraping.

## Task Graph
| Task ID | Priority | Task | Owner | Dependency | Path Type | Worktree | Baseline | Lane Notes | Validation |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| S1 | p0 | Implement `SceneTitleUtils.getFilestem` utility | omg-executor | - | critical | - | HEAD | - | VERIFIED |
| S2 | p0 | Update `SceneEditPage` to use filestem fallback for scrape query | omg-executor | S1 | critical | - | HEAD | - | VERIFIED |
| S3 | p1 | Update `scenes.graphql` to include full scraper sub-fields | omg-executor | - | critical | - | HEAD | - | VERIFIED |
| S4 | p1 | Update `Scraper` domain model to support new fields | omg-executor | S3 | critical | - | HEAD | - | VERIFIED |
| S5 | p2 | Update `ScrapeQueryDialog` to filter scrapers by `supported_scrapes` | omg-executor | S4 | sidecar | - | HEAD | - | VERIFIED |

## Critical Files
- `lib/features/scenes/presentation/pages/scene_edit_page.dart`
- `lib/features/scenes/data/graphql/scenes.graphql`
- `lib/features/scenes/domain/models/scraper.dart`
- `lib/features/scenes/presentation/widgets/scrape_query_dialog.dart`

## Ready For team-prd
- Yes.

## Stage
- team-prd

## Problem Statement
The current scraper implementation in StashFlow is limited:
1.  When a scene lacks a title, the scraper search string is empty, forcing manual input even when a valid filename exists.
2.  The scraper selection dialog only shows Stashbox endpoints, failing to load or display local/community scrapers installed on the Stash server.
3.  The UI does not distinguish between scrapers that support searching by name vs. those that only support fragments (direct URLs/IDs), leading to a confusing user experience.

## Scope / Non-goals
### Scope
- **Utility Enhancement**: Add a clean filestem extraction utility to `SceneTitleUtils`.
- **Search Fallback**: Use the extracted filestem as the initial query in `SceneEditPage`'s scrape dialog when the title is missing.
- **GraphQL & Model Update**: Revise `listScrapers` query and `Scraper` model to fetch comprehensive metadata including `supported_scrapes`.
- **UI Logic Update**: Refactor `ScrapeQueryDialog` to display all available scrapers and filter them appropriately based on the entity type (Scene, Performer, Studio).

### Non-goals
- Implementing automatic background scraping for all "Untitled" scenes.
- Adding support for bulk-scraping multiple entities at once.

## Acceptance Criteria
| Criterion | Task ID(s) | Priority | Evidence Needed | Owner |
| --- | --- | --- | --- | --- |
| **Filestem Fallback** | S1, S2 | p0 | Scrape dialog defaults to filename (without extension) if title is empty. | omg-product |
| **Full Scraper List** | S3, S4 | p1 | Local scrapers appear in the selection list alongside Stashbox endpoints. | omg-product |
| **Type-Aware Filtering** | S5 | p2 | Only scrapers supporting 'Name' (Query) appear in the queryable list. | omg-product |
| **Codegen Integrity** | S3 | p1 | `flutter pub run build_runner build` succeeds with new GraphQL fields. | omg-product |

## Constraints
- **Stash API Version**: Must remain compatible with Stash v0.24+.
- **Performance**: Listing scrapers must not block the UI (use existing `FutureProvider`).

## Baseline Expectations
- **Branch**: `dev`
- **HEAD**: `HEAD` (Clean analysis baseline).

## Handoff Contract
- **Lane**: `omg-executor`
- **Baseline**: `HEAD`
- **Evidence**: Successful `flutter build apk` and manual verification of the "Untitled" scene scraping flow.

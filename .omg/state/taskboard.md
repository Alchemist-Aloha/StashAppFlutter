# StashFlow Taskboard - Filter Reorganization Refinement

## Current Status
- Stage: team-exec
- Active Lane: Implementation

## Task Graph
| Task ID | Priority | Task | Owner | Dependency | Path Type | Worktree | Baseline | Lane Notes | Validation |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| T1 | p1 | Refine PerformerFilterPanel | omg-executor | None | critical | isolated | HEAD | Limit General to Favorite, Rating, Gender. Create Metadata & Library sections. | Verified: General minimized |
| T2 | p1 | Refine StudioFilterPanel | omg-executor | None | sequential | isolated | HEAD | Limit General to Favorite, Rating. Create Metadata & Library sections. | Verified: General minimized |
| T3 | p1 | Refine ImageFilterPanel | omg-executor | None | sidecar | isolated | HEAD | Limit General to Rating. Create Metadata & Library sections. | Verified: General minimized |
| T4 | p1 | Refine GalleryFilterPanel | omg-executor | None | sidecar | isolated | HEAD | Limit General to Rating. Create Metadata & Library sections. | Verified: General minimized |
| V1 | p0 | Verify minimal General sections | omg-verifier | T1, T2, T3, T4 | sequential | shared | HEAD | Ensure General sections match strict constraints | Manual smoke test of all filters |

## Phase 1: Implementation (T1-T4)
- [x] Refactor `lib/features/performers/presentation/widgets/performer_filter_panel.dart` (Verified)
- [x] Refactor `lib/features/studios/presentation/widgets/studio_filter_panel.dart` (Verified)
- [x] Refactor `lib/features/images/presentation/widgets/image_filter_panel.dart` (Verified)
- [x] Refactor `lib/features/galleries/presentation/widgets/gallery_filter_panel.dart` (Verified)

## Phase 2: Verification (V1)
- [x] Cross-check all panels for minimal General sections (Verified)
- [x] Fix and verify star rating logic and boolean tri-state filters (Verified)

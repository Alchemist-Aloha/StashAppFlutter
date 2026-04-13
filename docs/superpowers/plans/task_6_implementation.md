# Implementation Plan for Task 6: Optimize Fetch Policies

## Objective
Update fetch policies in all feature repository methods to use `cacheAndNetwork` for lists and `cacheFirst` for details. Preserve existing `noCache` for specific edge cases (like 'random' sorting).

## Target Files
- `lib/features/scenes/data/repositories/graphql_scene_repository.dart`
- `lib/features/performers/data/repositories/graphql_performer_repository.dart`
- `lib/features/studios/data/repositories/graphql_studio_repository.dart`
- `lib/features/tags/data/repositories/graphql_tag_repository.dart`
- `lib/features/galleries/data/repositories/graphql_gallery_repository.dart`
- `lib/features/groups/data/repositories/graphql_group_repository.dart`

## Implementation Logic
1. Iterate through each file.
2. Locate `Options$Query$FindX` methods (finders).
3. Ensure `fetchPolicy` is `FetchPolicy.cacheAndNetwork`.
   - NOTE: If `fetchPolicy` is currently `FetchPolicy.noCache` for logic reasons (e.g. random sort), keep it as is.
4. Locate `Options$Query$FindXById` methods (getters).
5. Ensure `fetchPolicy` is `FetchPolicy.cacheFirst`.

## Verification
1. Run linting: `flutter analyze`
2. Run existing tests to ensure no regressions: `flutter test`
3. Verify via code inspection that all target files were updated.

## Commit
`git add lib/features/*/data/repositories/graphql_*_repository.dart`
`git commit -m "perf: optimize GraphQL fetch policies across all repositories"`

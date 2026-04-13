# Design Spec: Core-Driven Codebase Restructuring

**Date:** 2026-03-31
**Status:** Approved
**Goal:** Reduce Technical Debt & Increase Test Coverage

## 1. Overview
The StashFlow codebase currently suffers from large files, repetitive boilerplate, and mixed concerns (e.g., cross-feature logic in repositories). This design proposes a **Core-Driven Standardization** approach, focusing on building a robust foundational layer in `lib/core` to simplify and unify feature implementations. Include detailed docstring along with the code generated/ modified.

## 2. Repository & Data Source Abstraction
We will introduce a `BaseRepository` class in `lib/core/data/graphql` to centralize GraphQL result handling and error mapping.

### Key Components:
- **`BaseRepository`**:
  - Handles `QueryResult` validation (checking `hasException`).
  - Maps GraphQL errors to domain-specific exceptions.
  - Standardizes the use of `graphql_codegen` generated models and documents.
- **`DataSource` Pattern (Optional)**: If repositories remain too large, extract raw GraphQL calls into feature-specific `DataSource` classes.

## 3. Standardized UI Components
Extract common UI patterns into reusable widgets in `lib/core/presentation/widgets`.

### Key Components:
- **`MediaCard`**: A configurable grid/list item widget for scenes, performers, studios, etc.
- **`MediaHeader`**: A consistent header for details pages (title, studio, metadata chips).
- **`AttributeChipList`**: A generic scrollable or wrapped list of chips (tags, performers, genres).
- **`ListPageScaffold` Enhancement**: Simplify the search, sort, and filter interaction logic to reduce boilerplate in page files.

## 4. Common Mapping Utilities
Move repetitive data mapping logic into shared utilities or extension methods.

### Key Components:
- **`DataMapper` Extensions**: Create extensions on `graphql_codegen` models (e.g., `extension SceneMapper on Fragment$Scene`) to handle domain entity conversion.
- **Shared Utils**: Standardize `displayTitle`, `formatDuration`, and `resolveMediaPath` in `lib/core/utils`.

## 5. Error & Loading UX
Unify the user experience for asynchronous operations.

### Key Components:
- **`LoadingStateView`**: A consistent centered progress indicator.
- **`ErrorStateView`**: A robust error view with message, icon, and retry hook.
- **Integration**: `BaseRepository` will provide standardized hooks for UI layers to handle errors consistently.

## 6. Testing Foundation
Build a reusable testing infrastructure in `test/helpers`.

### Key Components:
- **Mock Providers**: Pre-configured mock providers for `graphqlClient`, `sharedPreferences`, etc.
- **Base Test Classes**: Provide a consistent structure for testing repositories and providers.
- **Helper Methods**: Utilities for pumping widgets with `ProviderScope` and common overrides.

## 7. Success Criteria
- [ ] Large files (e.g., `scenes_page.dart`, `graphql_scene_repository.dart`) are reduced in size and complexity.
- [ ] No raw GraphQL strings remain in feature repositories (all use `codegen`).
- [ ] Test coverage increases for extracted core components and feature logic.
- [ ] New features can be implemented with significantly less boilerplate.

## 8. Implementation Phases
1. **Phase 1: Core Foundation** (`BaseRepository`, `MappingUtils`, `TestingHelpers`).
2. **Phase 2: UI Standardization** (`MediaCard`, `MediaHeader`, `ListPageScaffold` refactor).
3. **Phase 3: Feature Migration (Scenes)**: Refactor the `scenes` feature as a reference implementation.
4. **Phase 4: Global Migration**: Update other features (`performers`, `studios`, etc.) to use the new core patterns.

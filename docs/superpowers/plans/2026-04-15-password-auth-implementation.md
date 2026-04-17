# Password-Based Auth and Cookie-Based Content Fetching Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement password-based authentication and cookie-based content fetching in StashFlow.

**Architecture:** Use `Dio` with `PersistCookieJar` for session management. Update `GraphQLClient` and `StashImage` to support both API key and session cookie authentication.

**Tech Stack:** Flutter, Riverpod, Dio, dio_cookie_manager, cookie_jar, path_provider.

---

### Task 1: Foundation - Auth Models and Service

**Files:**
- Create: `lib/core/data/auth/auth_mode.dart`
- Create: `lib/core/data/auth/auth_service.dart`
- Create: `lib/core/data/auth/auth_provider.dart`

- [ ] **Step 1: Create AuthMode enum**
```dart
enum AuthMode {
  apiKey,
  password,
}
```

- [ ] **Step 2: Implement AuthService**
Create `AuthService` class that uses `Dio` and `PersistCookieJar`. It should handle `login`, `logout`, and provide access to the `CookieJar`.

- [ ] **Step 3: Create AuthProvider**
Implement a Riverpod `Notifier` that manages `AuthMode`, `username`, `password`, and `loginStatus`. Use `FlutterSecureStorage` for credentials.

- [ ] **Step 4: Commit**
```bash
git add lib/core/data/auth/
git commit -m "feat: add auth models and service foundation"
```

### Task 2: Network Integration - GraphQL and Images

**Files:**
- Modify: `lib/core/data/graphql/graphql_client.dart`
- Create: `lib/core/data/auth/dio_file_service.dart`
- Modify: `lib/core/presentation/widgets/stash_image.dart`
- Modify: `lib/core/data/graphql/media_headers_provider.dart`

- [ ] **Step 1: Update GraphqlClient**
Modify `GraphqlClient` provider to watch `authProvider`. If in `password` mode, inject session cookies into headers.

- [ ] **Step 2: Implement DioFileService**
Create a custom `FileService` for `CachedNetworkImage` that uses `Dio` with the shared `CookieJar`.

- [ ] **Step 3: Update StashImage**
Update `StashImage` to use `DioFileService` instead of `HttpFileService`. Ensure it watches `authProvider` to handle both auth modes.

- [ ] **Step 4: Update mediaHeadersProvider**
Update it to return empty headers if in `password` mode (since cookies are handled by `Dio`), or `ApiKey` if in `apiKey` mode.

- [ ] **Step 5: Commit**
```bash
git add lib/core/data/graphql/ lib/core/data/auth/ lib/core/presentation/widgets/
git commit -m "feat: integrate auth with graphql and image loading"
```

### Task 3: UI Implementation - Server Settings

**Files:**
- Modify: `lib/features/setup/presentation/pages/settings/server_settings_page.dart`

- [ ] **Step 1: Add AuthMode selector**
Add a segmented button or dropdown to choose between API Key and Password authentication.

- [ ] **Step 2: Add Username and Password fields**
Show these fields only when `password` mode is selected.

- [ ] **Step 3: Implement Login/Logout logic**
Add a "Login" button that calls `AuthService.login`. Update the connection test logic to handle both modes.

- [ ] **Step 4: Commit**
```bash
git add lib/features/setup/presentation/pages/settings/server_settings_page.dart
git commit -m "feat: update server settings UI for password auth"
```

### Task 4: Testing and Verification

**Files:**
- Create: `test/core/data/auth/auth_service_test.dart`
- Create: `test/core/data/auth/auth_provider_test.dart`

- [ ] **Step 1: Write unit tests for AuthService**
Mock `Dio` and verify that `login` sends correct data and `logout` clears cookies.

- [ ] **Step 2: Write unit tests for AuthProvider**
Verify state transitions and persistence.

- [ ] **Step 3: Manual Verification**
1. Switch to Password mode.
2. Enter valid username/password.
3. Verify connection succeeds.
4. Verify images load correctly.
5. Switch back to API Key mode and verify it still works.

- [ ] **Step 4: Commit**
```bash
git add test/core/data/auth/
git commit -m "test: add auth service and provider tests"
```

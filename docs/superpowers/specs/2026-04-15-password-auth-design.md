# Design Spec: Password-Based Auth and Cookie-Based Content Fetching

## Goal
Implement a password-based authentication method in the `StashFlow` Flutter app that supports session cookies for both GraphQL requests and media (images/videos) fetching, while maintaining compatibility with the existing API key-based authentication.

## Background
The official Stash server supports two main authentication methods:
1. **API Key**: Passed via `ApiKey` header or `apikey` query parameter.
2. **Session Cookie**: Set by a POST request to `/login` with `username` and `password`.

Currently, `StashFlow` only supports the API Key method.

## Architecture

### 1. New Components

#### `AuthMode` Enum
```dart
enum AuthMode {
  apiKey,
  password,
}
```

#### `AuthService`
A service that uses `Dio` with `dio_cookie_manager` and `PersistCookieJar` to handle:
- `login(String username, String password)`: POST to `/login`.
- `logout()`: GET to `/logout`.
- Access to the shared `CookieJar`.

#### `AuthProvider`
A Riverpod provider that manages:
- Current `AuthMode`.
- Credentials (stored securely using `FlutterSecureStorage`).
- Login status.

### 2. Integration with Existing Systems

#### GraphQL Client (`lib/core/data/graphql/graphql_client.dart`)
- If `AuthMode.apiKey`, continue using `ApiKey` header.
- If `AuthMode.password`, use session cookies. 
- Since `HttpLink` (from `graphql_flutter`) uses the `http` package, we will need to manually sync cookies from `CookieJar` into the `defaultHeaders` or use a custom `Link`.

#### Media Fetching (`lib/core/presentation/widgets/stash_image.dart`)
- `CachedNetworkImage` currently uses `HttpFileService`.
- We will implement `DioFileService` which uses the same `Dio` instance as `AuthService` (sharing the `CookieJar`).
- This ensures that images are fetched with the session cookie.

#### Video Playback
- Video players (like `video_player` or `fvp`) will need to include the session cookie in their HTTP headers when in `password` mode.

### 3. UI Changes
- **Server Settings Page**: 
  - Add an "Authentication Method" selector.
  - Show "API Key" field when in API Key mode.
  - Show "Username" and "Password" fields when in Password mode.
  - Add a "Login" button to test/initiate the session.

### 4. Persistence
- Store `AuthMode` in `SharedPreferences`.
- Store `username`, `password`, and `apiKey` in `FlutterSecureStorage`.
- `PersistCookieJar` will handle cookie persistence across app restarts.

## Implementation Plan

### Step 1: Foundation
- Create `AuthMode` enum.
- Implement `AuthService` with `Dio` and `PersistCookieJar`.
- Create `authProvider` to manage state.

### Step 2: Network Integration
- Implement `DioFileService` for `CachedNetworkImage`.
- Update `graphqlClientProvider` to support session cookies.
- Update `mediaHeadersProvider`.

### Step 3: UI Implementation
- Update `ServerSettingsPage` to support new auth fields.
- Implement login/logout flow in UI.

### Step 4: Testing & Verification
- Unit tests for `AuthService` and `AuthProvider`.
- Integration tests for cookie persistence.
- Verify both API Key and Password modes work independently.

## Security Considerations
- Credentials MUST be stored in `FlutterSecureStorage`.
- Cookies are stored in `PersistCookieJar` which should be stored in a private app directory.
- Sensitive information should never be logged.

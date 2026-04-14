# Authentication & Sessions (Web App)

Purpose
- Describe how the official web app handles login, session/token usage, and what the Flutter client must do to authenticate and persist sessions.

GraphQL / Endpoints
- Login/session GraphQL mutations are defined in: graphql/schema/schema.graphql (look for mutations related to login/session). The client commonly uses the GraphQL endpoint `/graphql` for auth flows.

Server references
- GraphQL schema: graphql/schema/schema.graphql
- Token/session models: pkg/models/* (search for session or auth in backend codebase)

TypeScript sources (web UI)
- Client creation and HTTP headers: ui/v2.5/src/core/createClient.ts
- Service wrapper that attaches auth: ui/v2.5/src/core/StashService.ts
- Local persistence for settings/tokens: ui/v2.5/src/hooks/LocalForage.ts and ui/v2.5/src/core/config.ts

Flutter quick snippet (send token in Authorization header)

```dart
// Using graphql_flutter, attach auth header per request
final httpLink = HttpLink('https://your-server/graphql', defaultHeaders: {
  'Authorization': 'Bearer <token>',
});

// After login, save token securely (flutter_secure_storage) and re-create client with header
```

Notes / Implementation tips
- Web UI stores tokens in local storage; for mobile use secure storage (flutter_secure_storage).
- Check whether the server uses cookie-based sessions or JWTs; web UI code (createClient / StashService) shows header handling and auth flows.
- CORS: mobile apps may need special handling only if backend implements cookie auth.

References
- ui/v2.5/src/core/createClient.ts
- ui/v2.5/src/core/StashService.ts
- graphql/schema/schema.graphql


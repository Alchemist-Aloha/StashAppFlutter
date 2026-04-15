# Sort: scene_createDate

- Endpoint / GraphQL call: findScenes(filter: SceneFilterType, find_filter: FindFilterType)
- Sort key name (server): `created_at` (used in FindFilterType.sort or entity-specific sort handling)
- Schema reference: graphql/schema/types/scene.graphql (Scene.created_at)
- Server implementation reference: pkg/sqlite/scene.go — setSceneSortAndPagination / ORDER BY clauses
- Frontend (TypeScript) reference: ui/v2.5/src/models/list-filter/criteria/* (see ui list-filter implementation for UI behavior)

Quick Flutter snippet (graphql_flutter)

```dart
final query = r'''
query FindScenes($filter: SceneFilterType, $findFilter: FindFilterType) {
  findScenes(filter: $filter, find_filter: $findFilter) {
    count
    scenes {
      id
      title
      date
      created_at
    }
  }
}
''';

final variables = {
  'findFilter': {
    'sort': 'created_at',
    'direction': 'DESC',
    'page': 1,
    'per_page': 25,
  },
  'filter': null,
};

final result = await client.query(QueryOptions(
  document: gql(query),
  variables: variables,
));

// Use result.data['findScenes']['scenes'] to render list in Flutter
```

Notes
- `created_at` is a native time column on Scene; using it for sort is simple and efficient.
- Verify server accepts `sort: 'created_at'` in FindFilterType; image/scene sort options live in pkg/sqlite/<entity>.go.

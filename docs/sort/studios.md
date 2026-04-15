# Studio sorts

Endpoint / GraphQL call: findStudios(filter: StudioFilterType, find_filter: FindFilterType)

Supported studio sort keys (server-side names):
- created_at
- id
- name
- images_count
- movies_count
- random
- scenes_count
- tag_count
- updated_at

Server references:
- GraphQL schema: graphql/schema/types/studio.graphql
- Sorting implementation: pkg/sqlite/studio.go (studioSortOptions, setStudioSort)

TS UI reference:
- ui/v2.5/src/models/list-filter/studios.ts

Flutter snippet (example fetching studios sorted by name):

```dart
final query = r'''
query FindStudios($filter: StudioFilterType, $findFilter: FindFilterType) {
  findStudios(filter: $filter, find_filter: $findFilter) {
    count
    studios {
      id
      name
      images_count
    }
  }
}
''';

final variables = {
  'findFilter': {
    'sort': 'name',
    'direction': 'ASC',
    'page': 1,
    'per_page': 25,
  },
  'filter': null,
};

final result = await client.query(QueryOptions(document: gql(query), variables: variables));
```

Notes:
- Studio sorts are generally straightforward and map to columns or aggregated counts.

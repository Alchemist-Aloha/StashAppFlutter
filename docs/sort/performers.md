# Performer sorts

Endpoint / GraphQL call: findPerformers(filter: PerformerFilterType, find_filter: FindFilterType)

Supported performer sort keys (server-side names):
- birthdate
- career_start
- career_end
- created_at
- galleries_count
- height
- id
- images_count
- last_o_at
- last_played_at
- latest_scene
- measurements
- name
- o_counter
- penis_length
- play_count
- random
- rating
- scenes_count
- scenes_duration
- scenes_size
- tag_count
- updated_at
- weight

Server references:
- GraphQL schema: graphql/schema/types/performer.graphql
- Sorting implementation: pkg/sqlite/performer.go (performerSortOptions, getPerformerSort)
- SQL helpers: pkg/sqlite/sql.go (getCountSort)

TS UI reference:
- ui/v2.5/src/models/list-filter/performers.ts

Flutter snippet (example fetching performers sorted by scenes_count):

```dart
final query = r'''
query FindPerformers($filter: PerformerFilterType, $findFilter: FindFilterType) {
  findPerformers(filter: $filter, find_filter: $findFilter) {
    count
    performers {
      id
      name
      images_count
      scenes_count
    }
  }
}
''';

final variables = {
  'findFilter': {
    'sort': 'scenes_count',
    'direction': 'DESC',
    'page': 1,
    'per_page': 25,
  },
  'filter': null,
};

final result = await client.query(QueryOptions(document: gql(query), variables: variables));
```

Notes:
- Complex sorts like scenes_duration / scenes_size use subqueries that sum durations/sizes across scenes (see selectPerformerScenesDurationSQL/selectPerformerScenesSizeSQL in performer.go).
- `random` uses SQL helper getRandomSort; pagination with random should be used carefully.

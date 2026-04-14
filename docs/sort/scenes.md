# Scene sorts

Endpoint / GraphQL call: findScenes(filter: SceneFilterType, find_filter: FindFilterType)

All supported scene sort keys (server-side names):
- bitrate
- created_at
- code
- date
- file_count
- filesize
- duration
- file_mod_time
- framerate
- group_scene_number
- id
- interactive
- interactive_speed
- last_o_at
- last_played_at
- movie_scene_number
- o_counter
- organized
- performer_count
- play_count
- play_duration
- resume_time
- path
- perceptual_similarity
- random (optional seed)
- rating
- resolution
- studio
- tag_count
- title
- updated_at
- performer_age

Server references:
- GraphQL schema: graphql/schema/types/scene.graphql
- Find endpoint: graphql/schema/schema.graphql (findScenes)
- Sorting implementation and allowed sorts: pkg/sqlite/scene.go (var sceneSortOptions and setSceneSort)
- SQL helpers: pkg/sqlite/sql.go (getSort, getCountSort, getRandomSort)

TypeScript UI references:
- List-filter options & patterns: ui/v2.5/src/models/list-filter/filter-options.ts
- Criteria UI examples: ui/v2.5/src/models/list-filter/criteria/*

Quick Flutter snippet (generic, set sort key dynamically):

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
      play_count
      play_duration
    }
  }
}
''';

Future<void> fetchScenes({String sortKey = 'created_at', String direction = 'DESC'}) async {
  final variables = {
    'findFilter': {
      'sort': sortKey,
      'direction': direction,
      'page': 1,
      'per_page': 25,
    },
    'filter': null,
  };

  final result = await client.query(QueryOptions(
    document: gql(query),
    variables: variables,
  ));
  // handle result
}
```

Notes:
- Use `random` for shuffle; backend supports seed-based random ordering via SQL helper.
- Aggregation sorts (file_count, tag_count, performer_count, play_count, scenes_duration) use subqueries / COUNT and may be slower on large DBs.
- For path/file-based sorts, backend adds JOINs to files/folders; ensure the join is acceptable for your query.

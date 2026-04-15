# Tag sorts

Endpoint / GraphQL call: findTags(filter: TagFilterType, find_filter: FindFilterType)

Supported tag sort keys (server-side names):
- created_at
- galleries_count
- groups_count
- id
- images_count
- movies_count
- studios_count
- name
- performers_count
- random
- scene_markers_count
- scenes_count
- scenes_duration
- scenes_size
- updated_at

Server references:
- GraphQL schema: graphql/schema/types/tag.graphql
- Sorting implementation: pkg/sqlite/tag.go (tagSortOptions, getTagSort)
- SQL helpers: pkg/sqlite/sql.go (getCountSort)

TS UI reference:
- ui/v2.5/src/models/list-filter/tags.ts

Flutter snippet (example fetching tags sorted by scenes_count):

```dart
final query = r'''
query FindTags($filter: TagFilterType, $findFilter: FindFilterType) {
  findTags(filter: $filter, find_filter: $findFilter) {
    count
    tags {
      id
      name
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
- Scenes duration/size sorts use subqueries joining scenes, scenes_files and video_files/file tables to aggregate.
- `scene_markers_count` combines counts from scene_markers_tags and primary tag in scene_markers.

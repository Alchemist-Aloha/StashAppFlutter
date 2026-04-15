# Gallery sorts

Endpoint / GraphQL call: findGalleries(filter: GalleryFilterType, find_filter: FindFilterType)

Supported gallery sort keys (server-side names):
- created_at
- date
- file_count
- file_mod_time
- id
- images_count
- path
- performer_count
- random
- rating
- tag_count
- title
- updated_at

Server references:
- GraphQL schema: graphql/schema/types/gallery.graphql
- Sorting implementation: pkg/sqlite/gallery.go (gallerySortOptions, setGallerySort)

TS UI reference:
- ui/v2.5/src/models/list-filter/groups.ts (similar pattern for group/galleries)

Flutter snippet (example fetching galleries sorted by images_count):

```dart
final query = r'''
query FindGalleries($filter: GalleryFilterType, $findFilter: FindFilterType) {
  findGalleries(filter: $filter, find_filter: $findFilter) {
    count
    galleries {
      id
      title
      images_count
    }
  }
}
''';

final variables = {
  'findFilter': {
    'sort': 'images_count',
    'direction': 'DESC',
    'page': 1,
    'per_page': 25,
  },
  'filter': null,
};

final result = await client.query(QueryOptions(document: gql(query), variables: variables));
```

Notes:
- Some gallery sorts require joining to files/folders for path/filename based sorts.

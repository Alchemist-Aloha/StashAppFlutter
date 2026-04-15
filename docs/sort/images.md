# Sort: images

Endpoint / GraphQL call: findImages(filter: ImageFilterType, find_filter: FindFilterType)

Supported image sort keys (server-side names):
- created_at
- date
- file_count
- file_mod_time
- filesize
- id
- o_counter
- path
- performer_count
- random
- rating
- resolution
- tag_count
- title
- updated_at

Server references:
- GraphQL schema: graphql/schema/types/image.graphql
- Sorting implementation: pkg/sqlite/image.go (imageSortOptions, setImageSortAndPagination)
- SQL helpers: pkg/sqlite/sql.go (getSort, getCountSort, getRandomSort)

TS UI reference:
- ui/v2.5/src/models/list-filter/filter-options.ts
- criteria examples: ui/v2.5/src/models/list-filter/criteria/*

Flutter snippet (generic, set sort key dynamically):

```dart
final query = r'''
query FindImages($filter: ImageFilterType, $findFilter: FindFilterType) {
  findImages(filter: $filter, find_filter: $findFilter) {
    count
    images {
      id
      title
      paths { thumbnail }
      filesize
      rating100
    }
  }
}
''';

Future<void> fetchImages({String sortKey = 'title', String direction = 'ASC'}) async {
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
}
```

Notes:
- Aggregation sorts like performer_count/tag_count rely on COUNT subqueries and can be slower on large DBs.
- For path/file-based sorts, the backend adds JOINs to files/folders tables.

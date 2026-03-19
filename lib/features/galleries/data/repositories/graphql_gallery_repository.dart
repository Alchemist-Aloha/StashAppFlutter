import 'package:graphql/client.dart';
import '../../domain/entities/gallery.dart';
import '../../domain/repositories/gallery_repository.dart';

class GraphQLGalleryRepository implements GalleryRepository {
  final GraphQLClient client;

  GraphQLGalleryRepository(this.client);

  @override
  Future<List<Gallery>> findGalleries({
    int? page,
    int? perPage,
    String? filter,
  }) async {
    const query = r'''
      query FindGalleries($page: Int, $perPage: Int, $filter: String) {
        findGalleries(filter: {page: $page, per_page: $perPage}) {
          galleries {
            id
            title
          }
        }
      }
    ''';

    final result = await client.query(
      QueryOptions(
        document: gql(query),
        variables: {'page': page, 'perPage': perPage, 'filter': filter},
      ),
    );

    if (result.hasException) throw result.exception!;

    final galleriesJson =
        result.data?['findGalleries']?['galleries'] as List<dynamic>? ?? [];
    return galleriesJson
        .map((g) => Gallery.fromJson(g as Map<String, dynamic>))
        .toList();
  }
}

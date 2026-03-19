import 'package:graphql/client.dart';
import '../../domain/entities/group.dart';
import '../../domain/repositories/group_repository.dart';

class GraphQLGroupRepository implements GroupRepository {
  final GraphQLClient client;

  GraphQLGroupRepository(this.client);

  @override
  Future<List<Group>> findGroups({
    int? page,
    int? perPage,
    String? filter,
  }) async {
    const query = r'''
      query FindGroups($page: Int, $perPage: Int, $filter: String) {
        findGroups(filter: {page: $page, per_page: $perPage}) {
          groups {
            id
            name
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

    final groupsJson =
        result.data?['findGroups']?['groups'] as List<dynamic>? ?? [];
    return groupsJson
        .map((g) => Group.fromJson(g as Map<String, dynamic>))
        .toList();
  }
}

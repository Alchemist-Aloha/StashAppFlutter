import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/group.dart';
import '../../domain/repositories/group_repository.dart';
import '../../data/repositories/graphql_group_repository.dart';
import '../../../../core/data/graphql/graphql_client.dart';

part 'group_list_provider.g.dart';

final groupRepositoryProvider = Provider<GroupRepository>((ref) {
  final client = ref.watch(graphqlClientProvider);
  return GraphQLGroupRepository(client);
});

@riverpod
FutureOr<List<Group>> groupList(Ref ref) async {
  final repository = ref.watch(groupRepositoryProvider);
  return repository.findGroups(page: 1, perPage: 50);
}

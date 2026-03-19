import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/performer.dart';
import '../../domain/repositories/performer_repository.dart';
import '../../data/repositories/graphql_performer_repository.dart';
import '../../../../core/data/graphql/graphql_client.dart';

part 'performer_list_provider.g.dart';

// Provider for Repository interface
final performerRepositoryProvider = Provider<PerformerRepository>((ref) {
  final client = ref.watch(graphqlClientProvider);
  return GraphQLPerformerRepository(client);
});

@riverpod
class PerformerSearchQuery extends _$PerformerSearchQuery {
  @override
  String build() => '';

  void update(String query) => state = query;
}

@riverpod
class PerformerList extends _$PerformerList {
  int _currentPage = 1;
  static const int _perPage = 20;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  @override
  FutureOr<List<Performer>> build() async {
    _currentPage = 1;
    _hasMore = true;
    final query = ref.watch(performerSearchQueryProvider);
    final repository = ref.watch(performerRepositoryProvider);
    return repository.findPerformers(
      page: _currentPage,
      perPage: _perPage,
      filter: query.isEmpty ? null : query,
    );
  }

  Future<void> fetchNextPage() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    final repository = ref.read(performerRepositoryProvider);
    final query = ref.read(performerSearchQueryProvider);

    try {
      final nextPage = _currentPage + 1;
      final nextPerformers = await repository.findPerformers(
        page: nextPage,
        perPage: _perPage,
        filter: query.isEmpty ? null : query,
      );

      if (nextPerformers.isEmpty) {
        _hasMore = false;
      } else {
        _currentPage = nextPage;
        state = AsyncData([...state.value ?? [], ...nextPerformers]);
      }
    } catch (e) {
      // In a real app, you might want to show a snackbar for error during pagination
    } finally {
      _isLoadingMore = false;
    }
  }

  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;
}

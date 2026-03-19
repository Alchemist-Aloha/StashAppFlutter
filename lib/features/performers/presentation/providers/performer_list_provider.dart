import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/performer.dart';
import '../../domain/repositories/performer_repository.dart';
import '../../data/repositories/graphql_performer_repository.dart';
import '../../../../core/data/graphql/graphql_client.dart';
import '../../../../core/utils/pagination.dart';

part 'performer_list_provider.g.dart';

// Provider for Repository interface
final performerRepositoryProvider = Provider<PerformerRepository>((ref) {
  final client = ref.watch(graphqlClientProvider);
  return GraphQLPerformerRepository(client);
});

@riverpod
class PerformerSort extends _$PerformerSort {
  @override
  ({String? sort, bool descending}) build() {
    return (sort: 'name', descending: false);
  }

  void setSort({String? sort, bool descending = true}) {
    state = (sort: sort, descending: descending);
  }
}

@riverpod
class PerformerSearchQuery extends _$PerformerSearchQuery {
  @override
  String build() => '';

  void update(String query) => state = query;
}

final performerFavoritesOnlyProvider =
    NotifierProvider<PerformerFavoritesOnlyNotifier, bool>(
      PerformerFavoritesOnlyNotifier.new,
    );

class PerformerFavoritesOnlyNotifier extends Notifier<bool> {
  @override
  bool build() => false;
}

@riverpod
class PerformerList extends _$PerformerList {
  int _currentPage = 1;
  static const int _perPage = kDefaultPageSize;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  @override
  FutureOr<List<Performer>> build() async {
    _currentPage = 1;
    _hasMore = true;
    _isLoadingMore = false;
    final query = ref.watch(performerSearchQueryProvider);
    final sortConfig = ref.watch(performerSortProvider);
    final favoritesOnly = ref.watch(performerFavoritesOnlyProvider);
    final repository = ref.watch(performerRepositoryProvider);
    return repository.findPerformers(
      page: _currentPage,
      perPage: _perPage,
      filter: query.isEmpty ? null : query,
      sort: sortConfig.sort,
      descending: sortConfig.descending,
      favoritesOnly: favoritesOnly,
    );
  }

  void setSort({String? sort, bool descending = true}) {
    ref
        .read(performerSortProvider.notifier)
        .setSort(sort: sort, descending: descending);
    _currentPage = 1;
    _hasMore = true;
    _isLoadingMore = false;
    ref.invalidateSelf();
  }

  void setFavoritesOnly(bool enabled) {
    ref.read(performerFavoritesOnlyProvider.notifier).state = enabled;
    _currentPage = 1;
    _hasMore = true;
    _isLoadingMore = false;
    ref.invalidateSelf();
  }

  Future<void> fetchNextPage() async {
    if (_isLoadingMore || !_hasMore || state.isLoading) return;

    _isLoadingMore = true;
    final repository = ref.read(performerRepositoryProvider);
    final query = ref.read(performerSearchQueryProvider);
    final sortConfig = ref.read(performerSortProvider);
    final favoritesOnly = ref.read(performerFavoritesOnlyProvider);

    try {
      final nextPage = _currentPage + 1;
      final nextPerformers = await repository.findPerformers(
        page: nextPage,
        perPage: _perPage,
        filter: query.isEmpty ? null : query,
        sort: sortConfig.sort,
        descending: sortConfig.descending,
        favoritesOnly: favoritesOnly,
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

  Future<Performer?> getRandomPerformer({bool useCurrentFilter = false}) async {
    final repository = ref.read(performerRepositoryProvider);
    final query = useCurrentFilter
        ? ref.read(performerSearchQueryProvider)
        : '';
    final favoritesOnly = useCurrentFilter
        ? ref.read(performerFavoritesOnlyProvider)
        : false;

    final randomPage = await repository.findPerformers(
      page: 1,
      perPage: 1,
      filter: query.isEmpty ? null : query,
      sort: 'random',
      descending: true,
      favoritesOnly: favoritesOnly,
    );
    if (randomPage.isNotEmpty) {
      return randomPage.first;
    }

    final loaded = state.asData?.value;
    if (loaded != null && loaded.isNotEmpty) {
      return loaded.first;
    }

    return null;
  }
}

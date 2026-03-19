import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/scene.dart';
import '../../domain/repositories/scene_repository.dart';
import '../../data/repositories/graphql_scene_repository.dart';
import '../../../../core/data/graphql/graphql_client.dart';
import '../../../../core/utils/pagination.dart';

part 'scene_list_provider.g.dart';

// Provider for Repository interface
final sceneRepositoryProvider = Provider<SceneRepository>((ref) {
  final client = ref.watch(graphqlClientProvider);
  return GraphQLSceneRepository(client);
});

@riverpod
class SceneSearchQuery extends _$SceneSearchQuery {
  @override
  String build() => '';

  void update(String query) => state = query;
}

@riverpod
class SceneList extends _$SceneList {
  final Random _random = Random();
  int _currentPage = 1;
  static const int _perPage = kDefaultPageSize;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  @override
  FutureOr<List<Scene>> build() async {
    _currentPage = 1;
    _hasMore = true;
    _isLoadingMore = false;
    final query = ref.watch(sceneSearchQueryProvider);
    final repository = ref.watch(sceneRepositoryProvider);
    return repository.findScenes(
      page: _currentPage,
      perPage: _perPage,
      filter: query.isEmpty ? null : query,
    );
  }

  Future<void> fetchNextPage() async {
    if (_isLoadingMore || !_hasMore || state.isLoading) return;

    _isLoadingMore = true;
    final repository = ref.read(sceneRepositoryProvider);
    final query = ref.read(sceneSearchQueryProvider);

    try {
      final nextPage = _currentPage + 1;
      final nextScenes = await repository.findScenes(
        page: nextPage,
        perPage: _perPage,
        filter: query.isEmpty ? null : query,
      );

      if (nextScenes.isEmpty) {
        _hasMore = false;
      } else {
        _currentPage = nextPage;
        state = AsyncData([...state.value ?? [], ...nextScenes]);
      }
    } catch (e) {
      // In a real app, you might want to show a snackbar for error during pagination
    } finally {
      _isLoadingMore = false;
    }
  }

  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;

  Future<Scene?> getRandomScene() async {
    final loadedScenes = state.asData?.value;
    if (loadedScenes != null && loadedScenes.isNotEmpty) {
      return loadedScenes[_random.nextInt(loadedScenes.length)];
    }

    final repository = ref.read(sceneRepositoryProvider);
    final query = ref.read(sceneSearchQueryProvider);
    final firstPage = await repository.findScenes(
      page: 1,
      perPage: _perPage,
      filter: query.isEmpty ? null : query,
    );
    if (firstPage.isEmpty) return null;
    return firstPage[_random.nextInt(firstPage.length)];
  }
}

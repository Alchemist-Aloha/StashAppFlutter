import 'package:graphql/client.dart';
import '../../../../core/data/graphql/base_repository.dart';
import '../../../../core/data/graphql/schema.graphql.dart';
import '../../../../core/data/graphql/url_resolver.dart';
import '../graphql/scenes.graphql.dart';
import '../utils/scene_mapper.dart';
import '../../domain/entities/scene.dart';
import '../../domain/entities/scene_filter.dart';
import '../../domain/repositories/scene_repository.dart';
import '../../domain/models/scraper.dart';
import '../../domain/models/scraped_scene.dart';
import '../utils/scrape_normalizer.dart';

class GraphQLSceneRepository extends BaseRepository implements SceneRepository {
  final GraphQLClient client;
  GraphQLSceneRepository(this.client);

  Uri get _graphqlEndpoint => client.link is HttpLink
      ? (client.link as HttpLink).uri
      : Uri.parse('https://localhost/graphql');

  @override
  Future<List<Scene>> findScenes({
    int? page,
    int? perPage,
    String? filter,
    String? sort,
    bool descending = true,
    bool? organized,
    bool? performerFavorite,
    String? performerId,
    String? studioId,
    String? tagId,
    SceneFilter? sceneFilter,
  }) async {
    String? effectiveSort = sort == 'rating100' ? 'rating' : sort;
    var result = await _runFindScenes(
      page: page,
      perPage: perPage,
      filter: filter,
      sort: effectiveSort,
      descending: descending,
      organized: organized,
      performerFavorite: performerFavorite,
      performerId: performerId,
      studioId: studioId,
      tagId: tagId,
      sceneFilter: sceneFilter,
    );

    if (result.hasException &&
        effectiveSort == 'rating' &&
        _isInvalidSort(result.exception!, 'rating')) {
      effectiveSort = 'rating100';
      result = await _runFindScenes(
        page: page,
        perPage: perPage,
        filter: filter,
        sort: effectiveSort,
        descending: descending,
        organized: organized,
        performerFavorite: performerFavorite,
        performerId: performerId,
        studioId: studioId,
        tagId: tagId,
        sceneFilter: sceneFilter,
      );
    }

    BaseRepository.validateResult(result);

    return result.parsedData!.findScenes.scenes
        .map((s) => s.toDomain())
        .toList();
  }

  Future<QueryResult<Query$FindScenes>> _runFindScenes({
    int? page,
    int? perPage,
    String? filter,
    String? sort,
    required bool descending,
    bool? organized,
    bool? performerFavorite,
    String? performerId,
    String? studioId,
    String? tagId,
    SceneFilter? sceneFilter,
  }) {
    final sortDirection = descending
        ? Enum$SortDirectionEnum.DESC
        : Enum$SortDirectionEnum.ASC;

    final filterInput = Input$FindFilterType(
      q: filter,
      page: page,
      per_page: perPage,
      sort: sort,
      direction: sortDirection,
    );

    final sceneFilterInput = Input$SceneFilterType(
      is_organized: organized,
      performers: (performerId != null || performerFavorite != null)
          ? Input$HierarchicalMultiCriterionInput(
              value_list: performerId != null ? [performerId] : null,
              modifier: Enum$CriterionModifier.INCLUDES,
            )
          : null,
      studios: studioId != null
          ? Input$HierarchicalMultiCriterionInput(
              value_list: [studioId],
              modifier: Enum$CriterionModifier.INCLUDES,
            )
          : null,
      tags: tagId != null
          ? Input$HierarchicalMultiCriterionInput(
              value_list: [tagId],
              modifier: Enum$CriterionModifier.INCLUDES,
            )
          : null,
    );

    return client.query$FindScenes(
      Options$Query$FindScenes(
        fetchPolicy: sort == 'random'
            ? FetchPolicy.noCache
            : FetchPolicy.cacheAndNetwork,
        variables: Variables$Query$FindScenes(
          filter: filterInput,
          scene_filter: sceneFilterInput,
        ),
      ),
    );
  }

  bool _isInvalidSort(OperationException exception, String attemptedSort) {
    return exception.graphqlErrors.any(
      (e) =>
          e.message.contains('invalid sort') &&
          e.message.contains(attemptedSort),
    );
  }

  @override
  Future<Scene> getSceneById(String id, {bool refresh = false}) async {
    final result = await client.query$FindScene(
      Options$Query$FindScene(
        fetchPolicy: refresh ? FetchPolicy.networkOnly : FetchPolicy.cacheFirst,
        variables: Variables$Query$FindScene(id: id),
      ),
    );

    BaseRepository.validateResult(result);
    final scene = result.parsedData!.findScene;
    if (scene == null) throw StateError('Scene not found');

    return scene.toDomain();
  }

  @override
  Future<void> updateScene(SceneUpdateInput input) async {
    final result = await client.mutate$UpdateScene(
      Options$Mutation$UpdateScene(
        variables: Variables$Mutation$UpdateScene(
          id: input.id,
          input: Input$SceneUpdateInput(
            title: input.title,
            details: input.details,
            date: input.date,
            url: input.url,
            studio_id: input.studioId,
            performer_ids: input.performerIds,
            tag_ids: input.tagIds,
          ),
        ),
      ),
    );

    BaseRepository.validateResult(result);
  }

  @override
  Future<List<Scraper>> listScrapers(Enum$ScraperTarget target) async {
    final result = await client.query$ListScrapers(
      Options$Query$ListScrapers(
        variables: Variables$Query$ListScrapers(target: target),
      ),
    );

    BaseRepository.validateResult(result);
    return result.parsedData!.listScrapers
        .map((s) => Scraper(id: s.id, name: s.name, target: target.name))
        .toList();
  }

  @override
  Future<List<ScrapedScene>> scrapeScene(String scraperId, String sceneId) async {
    final result = await client.query$ScrapeScene(
      Options$Query$ScrapeScene(
        variables: Variables$Query$ScrapeScene(
          scraper_id: scraperId,
          scene_id: sceneId,
        ),
      ),
    );

    BaseRepository.validateResult(result);
    return result.parsedData!.scrapeScene
        .map((s) => ScrapedScene.fromGraphQL(s))
        .toList();
  }

  @override
  Future<void> saveScrapedScene(String sceneId, ScrapedScene scraped) async {
    // Reconcile entities
    final performerIds = await _reconcilePerformers(scraped.performers);
    final tagIds = await _reconcileTags(scraped.tags);

    final input = Input$SceneUpdateInput(
      title: scraped.title,
      details: scraped.details,
      date: scraped.date,
      url: scraped.url,
      studio_id: scraped.studio?.storedId,
      performer_ids: performerIds,
      tag_ids: tagIds,
    );

    final result = await client.mutate$UpdateScene(
      Options$Mutation$UpdateScene(
        variables: Variables$Mutation$UpdateScene(id: sceneId, input: input),
      ),
    );

    BaseRepository.validateResult(result);
  }

  // TODO: Move these to respective repositories when they have reconcile methods
  Future<List<String>> _reconcilePerformers(List<ScrapedPerformer> performers) async {
    final ids = <String>[];
    if (performers.isEmpty) return ids;

    final findDoc = gql(r'''
      query FindPerformers($filter: FindFilterType) {
        findPerformers(filter: $filter) { count performers { id name urls image_path } }
      }
    ''');

    final createDoc = gql(r'''
      mutation CreatePerformer($input: PerformerCreateInput!) { performerCreate(input: $input) { id } }
    ''');

    for (final p in performers) {
      if (p.storedId != null && p.storedId!.isNotEmpty) {
        ids.add(p.storedId!);
        continue;
      }

      final nameQuery = p.name ?? (p.urls.isNotEmpty ? p.urls.first : '');
      if (nameQuery.isEmpty) continue;

      final result = await client.query(
        QueryOptions(
          document: findDoc,
          variables: {'filter': {'q': nameQuery}},
        ),
      );
      BaseRepository.validateResult(result);

      final raw = result.data?['findPerformers'] as Map<String, dynamic>?;
      final found = (raw?['performers'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];

      String? chosenId;
      for (final f in found) {
        final name = f['name'] as String?;
        final urls = (f['urls'] as List<dynamic>?)?.cast<String>() ?? [];
        if (name != null && p.name != null && name.toLowerCase() == p.name!.toLowerCase()) {
          chosenId = f['id'] as String?;
          break;
        }
        for (final pUrl in p.urls) {
          if (urls.contains(pUrl)) {
            chosenId = f['id'] as String?;
            break;
          }
        }
        if (chosenId != null) break;
      }

      if (chosenId != null) {
        ids.add(chosenId);
        continue;
      }

      final input = <String, dynamic>{'name': p.name ?? nameQuery};
      if (p.urls.isNotEmpty) input['urls'] = p.urls;
      if (p.images.isNotEmpty) input['image'] = p.images.first;

      final createResult = await client.mutate(
        MutationOptions(document: createDoc, variables: {'input': input}),
      );
      BaseRepository.validateResult(createResult);
      final created = (createResult.data?['performerCreate'] as Map<String, dynamic>?);
      if (created != null && created['id'] != null) {
        ids.add(created['id'] as String);
      }
    }

    return ids;
  }

  Future<List<String>> _reconcileTags(List<ScrapedTag> tags) async {
    final ids = <String>[];
    if (tags.isEmpty) return ids;

    final findDoc = gql(r'''
      query FindTags($filter: FindFilterType, $tag_filter: TagFilterType) {
        findTags(filter: $filter, tag_filter: $tag_filter) { count tags { id name } }
      }
    ''');

    final createDoc = gql(r'''
      mutation CreateTag($input: TagCreateInput!) { tagCreate(input: $input) { id } }
    ''');

    for (final t in tags) {
      if (t.storedId != null && t.storedId!.isNotEmpty) {
        ids.add(t.storedId!);
        continue;
      }

      final q = t.name.trim();
      if (q.isEmpty) continue;

      final result = await client.query(
        QueryOptions(
          document: findDoc,
          variables: {'filter': {'q': q}},
        ),
      );
      BaseRepository.validateResult(result);

      final raw = result.data?['findTags'] as Map<String, dynamic>?;      final found = (raw?['tags'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];

      String? chosenId;
      for (final f in found) {
        final name = f['name'] as String?;
        if (name != null && name.toLowerCase() == q.toLowerCase()) {
          chosenId = f['id'] as String?;
          break;
        }
      }

      if (chosenId != null) {
        ids.add(chosenId);
        continue;
      }

      final createResult = await client.mutate(
        MutationOptions(
          document: createDoc,
          variables: {'input': {'name': q}},
        ),
      );
      BaseRepository.validateResult(createResult);
      final created = (createResult.data?['tagCreate'] as Map<String, dynamic>?);
      if (created != null && created['id'] != null) {
        ids.add(created['id'] as String);
      }
    }

    return ids;
  }
}

import '../../../../core/domain/entities/saved_filter_config.dart';
import 'scene_marker.dart';

class SceneMarkerSavedFilterConfig
    extends SavedFilterConfig<SceneMarkerFilter> {
  const SceneMarkerSavedFilterConfig({
    super.id,
    required super.name,
    required super.searchQuery,
    required super.sort,
    required super.descending,
    required super.filter,
    super.perPage,
  }) : super(filterMode: 'SCENE_MARKERS');

  factory SceneMarkerSavedFilterConfig.fromServerPayload({
    required String id,
    required String name,
    Object? findFilter,
    Object? objectFilter,
  }) {
    final payload = savedFilterReadPayload(
      findFilter: findFilter,
      objectFilter: objectFilter,
      emptyFilter: const SceneMarkerFilter(),
      fromJson: SceneMarkerFilter.fromJson,
      serverToLocalKeys: _serverToLocalKeys,
      criterionTypes: _criterionTypes,
    );

    return SceneMarkerSavedFilterConfig(
      id: id,
      name: name,
      searchQuery: payload.searchQuery,
      sort: payload.sort,
      descending: payload.descending,
      perPage: payload.perPage,
      filter: payload.filter,
    );
  }

  factory SceneMarkerSavedFilterConfig.fromRaw(Map<String, dynamic> raw) {
    return SceneMarkerSavedFilterConfig.fromServerPayload(
      id: raw['id'] as String,
      name: raw['name'] as String,
      findFilter: raw['find_filter'],
      objectFilter: raw['object_filter'],
    );
  }

  @override
  Map<String, dynamic> toSaveInput() {
    return savedFilterBuildInput(
      id: id,
      mode: filterMode,
      name: name,
      searchQuery: searchQuery,
      sort: sort,
      descending: descending,
      perPage: perPage,
      objectFilter: savedFilterToServerObjectFilter(
        localJson: filter.toJson(),
        localToServerKeys: _localToServerKeys,
        criterionTypes: _criterionTypes,
      ),
    );
  }

  static const _localToServerKeys = {
    'sceneTags': 'scene_tags',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
    'sceneDate': 'scene_date',
    'sceneCreatedAt': 'scene_created_at',
    'sceneUpdatedAt': 'scene_updated_at',
  };

  static final _serverToLocalKeys = {
    for (final entry in _localToServerKeys.entries) entry.value: entry.key,
  };

  static const _criterionTypes = {
    'tags': SavedFilterCriterionType.hierarchical,
    'sceneTags': SavedFilterCriterionType.hierarchical,
    'performers': SavedFilterCriterionType.labeledWithExclusions,
    'scenes': SavedFilterCriterionType.labeled,
  };
}

import '../../../../core/domain/entities/saved_filter_config.dart';
import 'studio_filter.dart';

class StudioSavedFilterConfig extends SavedFilterConfig<StudioFilter> {
  const StudioSavedFilterConfig({
    super.id,
    required super.name,
    required super.searchQuery,
    required super.sort,
    required super.descending,
    required super.filter,
    super.perPage,
  }) : super(filterMode: 'STUDIOS');

  factory StudioSavedFilterConfig.fromServerPayload({
    required String id,
    required String name,
    Object? findFilter,
    Object? objectFilter,
  }) {
    final payload = savedFilterReadPayload(
      findFilter: findFilter,
      objectFilter: objectFilter,
      emptyFilter: StudioFilter.empty(),
      fromJson: StudioFilter.fromJson,
      serverToLocalKeys: _serverToLocalKeys,
      criterionTypes: _criterionTypes,
    );

    return StudioSavedFilterConfig(
      id: id,
      name: name,
      searchQuery: payload.searchQuery,
      sort: payload.sort,
      descending: payload.descending,
      perPage: payload.perPage,
      filter: payload.filter,
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
    'parentStudios': 'parents',
    'isMissing': 'is_missing',
    'sceneCount': 'scene_count',
    'imageCount': 'image_count',
    'galleryCount': 'gallery_count',
    'groupCount': 'group_count',
    'tagCount': 'tag_count',
    'ignoreAutoTag': 'ignore_auto_tag',
    'childCount': 'child_count',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
    'stashIdEndpoint': 'stash_id_endpoint',
    'customFields': 'custom_fields',
  };

  static final _serverToLocalKeys = {
    for (final entry in _localToServerKeys.entries) entry.value: entry.key,
  };

  static const _criterionTypes = {
    'favorite': SavedFilterCriterionType.boolean,
    'ignoreAutoTag': SavedFilterCriterionType.boolean,
    'organized': SavedFilterCriterionType.boolean,
    'isMissing': SavedFilterCriterionType.stringValue,
    'parentStudios': SavedFilterCriterionType.labeled,
    'tags': SavedFilterCriterionType.hierarchical,
    'stashIdEndpoint': SavedFilterCriterionType.stashId,
    'customFields': SavedFilterCriterionType.customFields,
  };
}

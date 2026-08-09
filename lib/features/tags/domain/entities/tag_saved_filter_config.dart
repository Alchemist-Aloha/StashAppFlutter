import '../../../../core/domain/entities/saved_filter_config.dart';
import 'tag_filter.dart';

class TagSavedFilterConfig extends SavedFilterConfig<TagFilter> {
  const TagSavedFilterConfig({
    super.id,
    required super.name,
    required super.searchQuery,
    required super.sort,
    required super.descending,
    required super.filter,
    super.perPage,
  }) : super(filterMode: 'TAGS');

  factory TagSavedFilterConfig.fromServerPayload({
    required String id,
    required String name,
    Object? findFilter,
    Object? objectFilter,
  }) {
    final payload = savedFilterReadPayload(
      findFilter: findFilter,
      objectFilter: objectFilter,
      emptyFilter: TagFilter.empty(),
      fromJson: TagFilter.fromJson,
      serverToLocalKeys: _serverToLocalKeys,
      normalizeValue: (localKey, value) => localKey == 'favorite'
          ? savedFilterReadBooleanCriterionValue(value)
          : value,
    );

    return TagSavedFilterConfig(
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
      ),
    );
  }

  static const _localToServerKeys = {
    'sortName': 'sort_name',
    'isMissingField': 'is_missing',
    'ignoreAutoTag': 'ignore_auto_tag',
    'sceneCount': 'scene_count',
    'imageCount': 'image_count',
    'galleryCount': 'gallery_count',
    'performerCount': 'performer_count',
    'studioCount': 'studio_count',
    'groupCount': 'group_count',
    'markerCount': 'marker_count',
    'parentCount': 'parent_count',
    'childCount': 'child_count',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
  };

  static final _serverToLocalKeys = {
    for (final entry in _localToServerKeys.entries) entry.value: entry.key,
  };
}

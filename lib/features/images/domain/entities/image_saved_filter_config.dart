import '../../../../core/domain/entities/saved_filter_config.dart';
import 'image_filter.dart';

class ImageSavedFilterConfig extends SavedFilterConfig<ImageFilter> {
  const ImageSavedFilterConfig({
    super.id,
    required super.name,
    required super.searchQuery,
    required super.sort,
    required super.descending,
    required super.filter,
    super.perPage,
  }) : super(filterMode: 'IMAGES');

  factory ImageSavedFilterConfig.fromServerPayload({
    required String id,
    required String name,
    Object? findFilter,
    Object? objectFilter,
  }) {
    final payload = savedFilterReadPayload(
      findFilter: findFilter,
      objectFilter: objectFilter,
      emptyFilter: ImageFilter.empty(),
      fromJson: ImageFilter.fromJson,
      serverToLocalKeys: _serverToLocalKeys,
      criterionTypes: _criterionTypes,
    );

    return ImageSavedFilterConfig(
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
    'fileCount': 'file_count',
    'oCounter': 'o_counter',
    'isMissing': 'is_missing',
    'tagCount': 'tag_count',
    'performerTags': 'performer_tags',
    'performerCount': 'performer_count',
    'performerFavorite': 'performer_favorite',
    'performerAge': 'performer_age',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
    'phashDistance': 'phash_distance',
    'customFields': 'custom_fields',
  };

  static final _serverToLocalKeys = {
    for (final entry in _localToServerKeys.entries) entry.value: entry.key,
  };

  static const _criterionTypes = {
    'organized': SavedFilterCriterionType.boolean,
    'performerFavorite': SavedFilterCriterionType.boolean,
    'isMissing': SavedFilterCriterionType.stringValue,
    'folder': SavedFilterCriterionType.hierarchical,
    'studios': SavedFilterCriterionType.hierarchical,
    'tags': SavedFilterCriterionType.hierarchical,
    'performerTags': SavedFilterCriterionType.hierarchical,
    'performers': SavedFilterCriterionType.labeledWithExclusions,
    'galleries': SavedFilterCriterionType.labeled,
    'phashDistance': SavedFilterCriterionType.phash,
    'customFields': SavedFilterCriterionType.customFields,
  };
}

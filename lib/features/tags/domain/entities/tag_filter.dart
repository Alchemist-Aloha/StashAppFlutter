import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stash_app_flutter/core/domain/entities/criterion.dart';

part 'tag_filter.freezed.dart';
part 'tag_filter.g.dart';

@freezed
abstract class TagFilter with _$TagFilter {
  const factory TagFilter({
    bool? favorite,
    StringCriterion? name,
    StringCriterion? sortName,
    StringCriterion? aliases,
    StringCriterion? description,
    String? isMissingField,
    bool? ignoreAutoTag,
    IntCriterion? sceneCount,
    IntCriterion? imageCount,
    IntCriterion? galleryCount,
    IntCriterion? performerCount,
    IntCriterion? studioCount,
    IntCriterion? groupCount,
    IntCriterion? markerCount,
    HierarchicalMultiCriterion? parents,
    HierarchicalMultiCriterion? children,
    IntCriterion? parentCount,
    IntCriterion? childCount,
    DateCriterion? createdAt,
    DateCriterion? updatedAt,
    StashIdCriterion? stashIdEndpoint,
    @Default(<CustomFieldCriterion>[]) List<CustomFieldCriterion> customFields,
  }) = _TagFilter;

  factory TagFilter.empty() => const TagFilter();

  factory TagFilter.fromJson(Map<String, dynamic> json) =>
      _$TagFilterFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stash_app_flutter/core/domain/entities/criterion.dart';

part 'group_filter.freezed.dart';
part 'group_filter.g.dart';

@freezed
abstract class GroupFilter with _$GroupFilter {
  const factory GroupFilter({
    StringCriterion? name,
    StringCriterion? director,
    StringCriterion? synopsis,
    IntCriterion? duration,
    IntCriterion? rating100,
    HierarchicalMultiCriterion? studios,
    String? isMissingField,
    StringCriterion? url,
    MultiCriterion? performers,
    HierarchicalMultiCriterion? tags,
    IntCriterion? tagCount,
    DateCriterion? date,
    DateCriterion? createdAt,
    DateCriterion? updatedAt,
    IntCriterion? oCounter,
    HierarchicalMultiCriterion? containingGroups,
    HierarchicalMultiCriterion? subGroups,
    IntCriterion? containingGroupCount,
    IntCriterion? subGroupCount,
    IntCriterion? sceneCount,
    @Default(<CustomFieldCriterion>[]) List<CustomFieldCriterion> customFields,
  }) = _GroupFilter;

  factory GroupFilter.empty() => const GroupFilter();

  factory GroupFilter.fromJson(Map<String, dynamic> json) =>
      _$GroupFilterFromJson(json);
}

extension GroupFilterState on GroupFilter {
  bool get isEmpty => this == const GroupFilter();
}

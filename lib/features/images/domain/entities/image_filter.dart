import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stash_app_flutter/core/domain/entities/criterion.dart';
import 'package:stash_app_flutter/features/galleries/domain/entities/gallery_filter.dart';

part 'image_filter.freezed.dart';
part 'image_filter.g.dart';

@freezed
abstract class ImageFilter with _$ImageFilter {
  const factory ImageFilter({
    String? searchQuery,
    StringCriterion? title,
    StringCriterion? code,
    StringCriterion? details,
    StringCriterion? photographer,
    IntCriterion? id,
    StringCriterion? checksum,
    StringCriterion? path,
    HierarchicalMultiCriterion? folder,
    PhashCriterion? phashDistance,
    IntCriterion? fileCount,
    IntCriterion? rating100,
    DateCriterion? date,
    StringCriterion? url,
    bool? organized,
    IntCriterion? oCounter,
    MultiCriterion? resolution,
    MultiCriterion? orientation,
    String? isMissing,
    HierarchicalMultiCriterion? studios,
    HierarchicalMultiCriterion? tags,
    IntCriterion? tagCount,
    HierarchicalMultiCriterion? performerTags,
    MultiCriterion? performers,
    IntCriterion? performerCount,
    bool? performerFavorite,
    IntCriterion? performerAge,
    MultiCriterion? galleries,
    GalleryFilter? galleriesFilter,
    DateCriterion? createdAt,
    DateCriterion? updatedAt,
    @Default(<CustomFieldCriterion>[]) List<CustomFieldCriterion> customFields,
  }) = _ImageFilter;

  factory ImageFilter.empty() => const ImageFilter();

  factory ImageFilter.fromJson(Map<String, dynamic> json) =>
      _$ImageFilterFromJson(json);
}

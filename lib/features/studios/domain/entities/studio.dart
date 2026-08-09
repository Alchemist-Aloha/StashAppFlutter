import 'package:freezed_annotation/freezed_annotation.dart';

part 'studio.freezed.dart';
part 'studio.g.dart';

@freezed
abstract class Studio with _$Studio {
  const factory Studio({
    required String id,
    required String name,
    String? url,
    @Default([]) List<String> urls,
    @JsonKey(name: 'image_path') String? imagePath,
    String? details,
    int? rating100,
    @JsonKey(name: 'scene_count') required int sceneCount,
    @JsonKey(name: 'image_count') required int imageCount,
    @JsonKey(name: 'gallery_count') required int galleryCount,
    @JsonKey(name: 'performer_count') required int performerCount,
    @JsonKey(name: 'scene_count_all') int? sceneCountAll,
    @JsonKey(name: 'image_count_all') int? imageCountAll,
    @JsonKey(name: 'gallery_count_all') int? galleryCountAll,
    @JsonKey(name: 'performer_count_all') int? performerCountAll,
    @JsonKey(name: 'group_count') @Default(0) int groupCount,
    @JsonKey(name: 'group_count_all') int? groupCountAll,
    @JsonKey(name: 'o_counter') @Default(0) int oCounter,
    @JsonKey(name: 'parent_studio') StudioRelationship? parentStudio,
    @JsonKey(name: 'child_studios')
    @Default([])
    List<StudioRelationship> childStudios,
    @Default([]) List<String> aliases,
    @Default([]) List<StudioTag> tags,
    @JsonKey(name: 'ignore_auto_tag') @Default(false) bool ignoreAutoTag,
    @Default(false) bool organized,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    required bool favorite,
  }) = _Studio;

  factory Studio.fromJson(Map<String, dynamic> json) => _$StudioFromJson(json);
}

/// Minimal studio data used to render parent and child relationships.
@freezed
abstract class StudioRelationship with _$StudioRelationship {
  const factory StudioRelationship({
    required String id,
    required String name,
    @JsonKey(name: 'image_path') String? imagePath,
  }) = _StudioRelationship;

  factory StudioRelationship.fromJson(Map<String, dynamic> json) =>
      _$StudioRelationshipFromJson(json);
}

/// Minimal tag data shown on studio details.
@freezed
abstract class StudioTag with _$StudioTag {
  const factory StudioTag({required String id, required String name}) =
      _StudioTag;

  factory StudioTag.fromJson(Map<String, dynamic> json) =>
      _$StudioTagFromJson(json);
}

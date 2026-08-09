import 'package:freezed_annotation/freezed_annotation.dart';

part 'studio.freezed.dart';
part 'studio.g.dart';

@freezed
abstract class Studio with _$Studio {
  const factory Studio({
    required String id,
    required String name,
    String? url,
    @JsonKey(name: 'image_path') String? imagePath,
    String? details,
    int? rating100,
    @JsonKey(name: 'scene_count') required int sceneCount,
    @JsonKey(name: 'image_count') required int imageCount,
    @JsonKey(name: 'gallery_count') required int galleryCount,
    @JsonKey(name: 'performer_count') required int performerCount,
    @JsonKey(name: 'parent_studio') StudioRelationship? parentStudio,
    @JsonKey(name: 'child_studios')
    @Default([])
    List<StudioRelationship> childStudios,
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

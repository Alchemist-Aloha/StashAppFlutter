import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.freezed.dart';
part 'tag.g.dart';

@freezed
abstract class Tag with _$Tag {
  const factory Tag({
    required String id,
    required String name,
    String? description,
    @JsonKey(name: 'image_path') String? imagePath,
    @JsonKey(name: 'scene_count') required int sceneCount,
    @JsonKey(name: 'image_count') required int imageCount,
    @JsonKey(name: 'gallery_count') required int galleryCount,
    @JsonKey(name: 'performer_count') required int performerCount,
    required bool favorite,
  }) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}

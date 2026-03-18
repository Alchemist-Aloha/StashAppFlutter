import 'package:freezed_annotation/freezed_annotation.dart';

part 'scene.freezed.dart';
part 'scene.g.dart';

@freezed
abstract class Scene with _$Scene {
  const factory Scene({
    required String id,
    required String title,
    String? details,
    String? path,
    required DateTime date,
    required double rating,
    required List<String> tags,
    required List<String> performers,
    required String? studio,
    required String? streamUrl,
    required String? thumbUrl,
  }) = _Scene;

  factory Scene.fromJson(Map<String, dynamic> json) => _$SceneFromJson(json);
}

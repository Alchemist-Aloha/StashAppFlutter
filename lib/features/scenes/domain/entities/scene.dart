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
    required int? rating100,
    required int oCounter,
    required bool organized,
    required bool interactive,
    required double? resumeTime,
    required int playCount,
    required List<SceneFile> files,
    required ScenePaths paths,
    required String? studioId,
    required String? studioName,
    required List<String> performerIds,
    required List<String> performerNames,
    required List<String> tagIds,
    required List<String> tagNames,
  }) = _Scene;

  factory Scene.fromJson(Map<String, dynamic> json) => _$SceneFromJson(json);
}

@freezed
abstract class SceneFile with _$SceneFile {
  const factory SceneFile({
    required String? format,
    required int? width,
    required int? height,
    required String? videoCodec,
    required String? audioCodec,
    required int? bitRate,
  }) = _SceneFile;

  factory SceneFile.fromJson(Map<String, dynamic> json) => _$SceneFileFromJson(json);
}

@freezed
abstract class ScenePaths with _$ScenePaths {
  const factory ScenePaths({
    required String? screenshot,
    required String? preview,
    required String? stream,
  }) = _ScenePaths;

  factory ScenePaths.fromJson(Map<String, dynamic> json) => _$ScenePathsFromJson(json);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Scene _$SceneFromJson(Map<String, dynamic> json) => _Scene(
  id: json['id'] as String,
  title: json['title'] as String,
  details: json['details'] as String?,
  path: json['path'] as String?,
  date: DateTime.parse(json['date'] as String),
  rating100: (json['rating100'] as num?)?.toInt(),
  oCounter: (json['oCounter'] as num).toInt(),
  organized: json['organized'] as bool,
  interactive: json['interactive'] as bool,
  resumeTime: (json['resumeTime'] as num?)?.toDouble(),
  playCount: (json['playCount'] as num).toInt(),
  files: (json['files'] as List<dynamic>)
      .map((e) => SceneFile.fromJson(e as Map<String, dynamic>))
      .toList(),
  paths: ScenePaths.fromJson(json['paths'] as Map<String, dynamic>),
  studioId: json['studioId'] as String?,
  studioName: json['studioName'] as String?,
  performerIds: (json['performerIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  performerNames: (json['performerNames'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  tagIds: (json['tagIds'] as List<dynamic>).map((e) => e as String).toList(),
  tagNames: (json['tagNames'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$SceneToJson(_Scene instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'details': instance.details,
  'path': instance.path,
  'date': instance.date.toIso8601String(),
  'rating100': instance.rating100,
  'oCounter': instance.oCounter,
  'organized': instance.organized,
  'interactive': instance.interactive,
  'resumeTime': instance.resumeTime,
  'playCount': instance.playCount,
  'files': instance.files,
  'paths': instance.paths,
  'studioId': instance.studioId,
  'studioName': instance.studioName,
  'performerIds': instance.performerIds,
  'performerNames': instance.performerNames,
  'tagIds': instance.tagIds,
  'tagNames': instance.tagNames,
};

_SceneFile _$SceneFileFromJson(Map<String, dynamic> json) => _SceneFile(
  format: json['format'] as String?,
  width: (json['width'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
  videoCodec: json['videoCodec'] as String?,
  audioCodec: json['audioCodec'] as String?,
  bitRate: (json['bitRate'] as num?)?.toInt(),
);

Map<String, dynamic> _$SceneFileToJson(_SceneFile instance) =>
    <String, dynamic>{
      'format': instance.format,
      'width': instance.width,
      'height': instance.height,
      'videoCodec': instance.videoCodec,
      'audioCodec': instance.audioCodec,
      'bitRate': instance.bitRate,
    };

_ScenePaths _$ScenePathsFromJson(Map<String, dynamic> json) => _ScenePaths(
  screenshot: json['screenshot'] as String?,
  preview: json['preview'] as String?,
  stream: json['stream'] as String?,
);

Map<String, dynamic> _$ScenePathsToJson(_ScenePaths instance) =>
    <String, dynamic>{
      'screenshot': instance.screenshot,
      'preview': instance.preview,
      'stream': instance.stream,
    };

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
  rating: (json['rating'] as num).toDouble(),
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  performers: (json['performers'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  studio: json['studio'] as String?,
  streamUrl: json['streamUrl'] as String?,
  thumbUrl: json['thumbUrl'] as String?,
);

Map<String, dynamic> _$SceneToJson(_Scene instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'details': instance.details,
  'path': instance.path,
  'date': instance.date.toIso8601String(),
  'rating': instance.rating,
  'tags': instance.tags,
  'performers': instance.performers,
  'studio': instance.studio,
  'streamUrl': instance.streamUrl,
  'thumbUrl': instance.thumbUrl,
};

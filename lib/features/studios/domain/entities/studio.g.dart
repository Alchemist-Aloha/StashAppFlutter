// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Studio _$StudioFromJson(Map<String, dynamic> json) => _Studio(
  id: json['id'] as String,
  name: json['name'] as String,
  url: json['url'] as String?,
  imagePath: json['image_path'] as String?,
  details: json['details'] as String?,
  rating100: (json['rating100'] as num?)?.toInt(),
  sceneCount: (json['scene_count'] as num).toInt(),
  imageCount: (json['image_count'] as num).toInt(),
  galleryCount: (json['gallery_count'] as num).toInt(),
  performerCount: (json['performer_count'] as num).toInt(),
  favorite: json['favorite'] as bool,
);

Map<String, dynamic> _$StudioToJson(_Studio instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'url': instance.url,
  'image_path': instance.imagePath,
  'details': instance.details,
  'rating100': instance.rating100,
  'scene_count': instance.sceneCount,
  'image_count': instance.imageCount,
  'gallery_count': instance.galleryCount,
  'performer_count': instance.performerCount,
  'favorite': instance.favorite,
};

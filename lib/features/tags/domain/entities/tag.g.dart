// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Tag _$TagFromJson(Map<String, dynamic> json) => _Tag(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  imagePath: json['image_path'] as String?,
  sceneCount: (json['scene_count'] as num).toInt(),
  imageCount: (json['image_count'] as num).toInt(),
  galleryCount: (json['gallery_count'] as num).toInt(),
  performerCount: (json['performer_count'] as num).toInt(),
  favorite: json['favorite'] as bool,
);

Map<String, dynamic> _$TagToJson(_Tag instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'image_path': instance.imagePath,
  'scene_count': instance.sceneCount,
  'image_count': instance.imageCount,
  'gallery_count': instance.galleryCount,
  'performer_count': instance.performerCount,
  'favorite': instance.favorite,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Performer _$PerformerFromJson(Map<String, dynamic> json) => _Performer(
  id: json['id'] as String,
  name: json['name'] as String,
  disambiguation: json['disambiguation'] as String?,
  urls: (json['urls'] as List<dynamic>).map((e) => e as String).toList(),
  gender: json['gender'] as String?,
  birthdate: json['birthdate'] as String?,
  ethnicity: json['ethnicity'] as String?,
  country: json['country'] as String?,
  eyeColor: json['eye_color'] as String?,
  heightCm: (json['height_cm'] as num?)?.toInt(),
  measurements: json['measurements'] as String?,
  fakeTits: json['fake_tits'] as String?,
  penisLength: (json['penis_length'] as num?)?.toDouble(),
  circumcised: json['circumcised'] as String?,
  careerStart: json['career_start'] as String?,
  careerEnd: json['career_end'] as String?,
  tattoos: json['tattoos'] as String?,
  piercings: json['piercings'] as String?,
  aliasList: (json['alias_list'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  favorite: json['favorite'] as bool,
  imagePath: json['image_path'] as String?,
  sceneCount: (json['scene_count'] as num).toInt(),
  imageCount: (json['image_count'] as num).toInt(),
  galleryCount: (json['gallery_count'] as num).toInt(),
  groupCount: (json['group_count'] as num).toInt(),
  rating100: (json['rating100'] as num?)?.toInt(),
  details: json['details'] as String?,
  deathDate: json['death_date'] as String?,
  hairColor: json['hair_color'] as String?,
  weight: (json['weight'] as num?)?.toInt(),
  tagIds: (json['tag_ids'] as List<dynamic>).map((e) => e as String).toList(),
  tagNames: (json['tag_names'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$PerformerToJson(_Performer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'disambiguation': instance.disambiguation,
      'urls': instance.urls,
      'gender': instance.gender,
      'birthdate': instance.birthdate,
      'ethnicity': instance.ethnicity,
      'country': instance.country,
      'eye_color': instance.eyeColor,
      'height_cm': instance.heightCm,
      'measurements': instance.measurements,
      'fake_tits': instance.fakeTits,
      'penis_length': instance.penisLength,
      'circumcised': instance.circumcised,
      'career_start': instance.careerStart,
      'career_end': instance.careerEnd,
      'tattoos': instance.tattoos,
      'piercings': instance.piercings,
      'alias_list': instance.aliasList,
      'favorite': instance.favorite,
      'image_path': instance.imagePath,
      'scene_count': instance.sceneCount,
      'image_count': instance.imageCount,
      'gallery_count': instance.galleryCount,
      'group_count': instance.groupCount,
      'rating100': instance.rating100,
      'details': instance.details,
      'death_date': instance.deathDate,
      'hair_color': instance.hairColor,
      'weight': instance.weight,
      'tag_ids': instance.tagIds,
      'tag_names': instance.tagNames,
    };

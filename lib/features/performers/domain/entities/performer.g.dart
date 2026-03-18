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
  eyeColor: json['eyeColor'] as String?,
  heightCm: (json['heightCm'] as num?)?.toInt(),
  measurements: json['measurements'] as String?,
  fakeTits: json['fakeTits'] as String?,
  penisLength: (json['penisLength'] as num?)?.toDouble(),
  circumcised: json['circumcised'] as String?,
  careerStart: json['careerStart'] as String?,
  careerEnd: json['careerEnd'] as String?,
  tattoos: json['tattoos'] as String?,
  piercings: json['piercings'] as String?,
  aliasList: (json['aliasList'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  favorite: json['favorite'] as bool,
  imagePath: json['imagePath'] as String?,
  sceneCount: (json['sceneCount'] as num).toInt(),
  imageCount: (json['imageCount'] as num).toInt(),
  galleryCount: (json['galleryCount'] as num).toInt(),
  groupCount: (json['groupCount'] as num).toInt(),
  rating100: (json['rating100'] as num?)?.toInt(),
  details: json['details'] as String?,
  deathDate: json['deathDate'] as String?,
  hairColor: json['hairColor'] as String?,
  weight: (json['weight'] as num?)?.toInt(),
  tagIds: (json['tagIds'] as List<dynamic>).map((e) => e as String).toList(),
  tagNames: (json['tagNames'] as List<dynamic>)
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
      'eyeColor': instance.eyeColor,
      'heightCm': instance.heightCm,
      'measurements': instance.measurements,
      'fakeTits': instance.fakeTits,
      'penisLength': instance.penisLength,
      'circumcised': instance.circumcised,
      'careerStart': instance.careerStart,
      'careerEnd': instance.careerEnd,
      'tattoos': instance.tattoos,
      'piercings': instance.piercings,
      'aliasList': instance.aliasList,
      'favorite': instance.favorite,
      'imagePath': instance.imagePath,
      'sceneCount': instance.sceneCount,
      'imageCount': instance.imageCount,
      'galleryCount': instance.galleryCount,
      'groupCount': instance.groupCount,
      'rating100': instance.rating100,
      'details': instance.details,
      'deathDate': instance.deathDate,
      'hairColor': instance.hairColor,
      'weight': instance.weight,
      'tagIds': instance.tagIds,
      'tagNames': instance.tagNames,
    };

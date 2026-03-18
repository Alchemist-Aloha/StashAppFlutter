// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Performer _$PerformerFromJson(Map<String, dynamic> json) => _Performer(
  id: json['id'] as String,
  name: json['name'] as String,
  details: json['details'] as String?,
  gender: json['gender'] as String?,
  birthdate: json['birthdate'] as String?,
  imagePath: json['imagePath'] as String?,
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$PerformerToJson(_Performer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'details': instance.details,
      'gender': instance.gender,
      'birthdate': instance.birthdate,
      'imagePath': instance.imagePath,
      'tags': instance.tags,
    };

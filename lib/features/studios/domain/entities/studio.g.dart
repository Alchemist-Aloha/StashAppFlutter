// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Studio _$StudioFromJson(Map<String, dynamic> json) => _Studio(
  id: json['id'] as String,
  name: json['name'] as String,
  details: json['details'] as String?,
  imagePath: json['imagePath'] as String?,
  parentId: json['parentId'] as String?,
  parentName: json['parentName'] as String?,
);

Map<String, dynamic> _$StudioToJson(_Studio instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'details': instance.details,
  'imagePath': instance.imagePath,
  'parentId': instance.parentId,
  'parentName': instance.parentName,
};

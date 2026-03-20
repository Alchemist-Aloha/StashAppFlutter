// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scraper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Scraper _$ScraperFromJson(Map<String, dynamic> json) => _Scraper(
  id: json['id'] as String,
  name: json['name'] as String,
  supportedScrapes: (json['supportedScrapes'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$ScraperToJson(_Scraper instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'supportedScrapes': instance.supportedScrapes,
};

_ScrapedScene _$ScrapedSceneFromJson(Map<String, dynamic> json) =>
    _ScrapedScene(
      title: json['title'] as String?,
      code: json['code'] as String?,
      details: json['details'] as String?,
      director: json['director'] as String?,
      urls: (json['urls'] as List<dynamic>).map((e) => e as String).toList(),
      date: json['date'] as String?,
      image: json['image'] as String?,
      studio: json['studio'] == null
          ? null
          : ScrapedEntity.fromJson(json['studio'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>)
          .map((e) => ScrapedEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      performers: (json['performers'] as List<dynamic>)
          .map((e) => ScrapedEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScrapedSceneToJson(_ScrapedScene instance) =>
    <String, dynamic>{
      'title': instance.title,
      'code': instance.code,
      'details': instance.details,
      'director': instance.director,
      'urls': instance.urls,
      'date': instance.date,
      'image': instance.image,
      'studio': instance.studio,
      'tags': instance.tags,
      'performers': instance.performers,
    };

_ScrapedEntity _$ScrapedEntityFromJson(Map<String, dynamic> json) =>
    _ScrapedEntity(
      storedId: json['stored_id'] as String?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ScrapedEntityToJson(_ScrapedEntity instance) =>
    <String, dynamic>{'stored_id': instance.storedId, 'name': instance.name};

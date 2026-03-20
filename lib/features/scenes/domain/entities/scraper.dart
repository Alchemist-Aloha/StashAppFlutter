import 'package:freezed_annotation/freezed_annotation.dart';

part 'scraper.freezed.dart';
part 'scraper.g.dart';

@freezed
abstract class Scraper with _$Scraper {
  const factory Scraper({
    required String id,
    required String name,
    required List<String> supportedScrapes,
  }) = _Scraper;

  factory Scraper.fromJson(Map<String, dynamic> json) => _$ScraperFromJson(json);
}

@freezed
abstract class ScrapedScene with _$ScrapedScene {
  const factory ScrapedScene({
    String? title,
    String? code,
    String? details,
    String? director,
    required List<String> urls,
    String? date,
    String? image,
    ScrapedEntity? studio,
    required List<ScrapedEntity> tags,
    required List<ScrapedEntity> performers,
  }) = _ScrapedScene;

  factory ScrapedScene.fromJson(Map<String, dynamic> json) =>
      _$ScrapedSceneFromJson(json);
}

@freezed
abstract class ScrapedEntity with _$ScrapedEntity {
  const factory ScrapedEntity({
    @JsonKey(name: 'stored_id') String? storedId,
    required String name,
  }) = _ScrapedEntity;

  factory ScrapedEntity.fromJson(Map<String, dynamic> json) =>
      _$ScrapedEntityFromJson(json);
}

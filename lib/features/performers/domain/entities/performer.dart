import 'package:freezed_annotation/freezed_annotation.dart';

part 'performer.freezed.dart';
part 'performer.g.dart';

@freezed
abstract class Performer with _$Performer {
  const factory Performer({
    required String id,
    required String name,
    String? disambiguation,
    required List<String> urls,
    String? gender,
    required String? birthdate,
    String? ethnicity,
    String? country,
    String? eyeColor,
    int? heightCm,
    String? measurements,
    String? fakeTits,
    double? penisLength,
    String? circumcised,
    String? careerStart,
    String? careerEnd,
    String? tattoos,
    String? piercings,
    required List<String> aliasList,
    required bool favorite,
    required String? imagePath,
    required int sceneCount,
    required int imageCount,
    required int galleryCount,
    required int groupCount,
    int? rating100,
    String? details,
    String? deathDate,
    String? hairColor,
    int? weight,
    required List<String> tagIds,
    required List<String> tagNames,
  }) = _Performer;

  factory Performer.fromJson(Map<String, dynamic> json) => _$PerformerFromJson(json);
}

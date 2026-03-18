import 'package:freezed_annotation/freezed_annotation.dart';

part 'performer.freezed.dart';
part 'performer.g.dart';

@freezed
class Performer with _$Performer {
  const factory Performer({
    required String id,
    required String name,
    String? details,
    String? gender,
    required String? birthdate,
    required String? imagePath,
    required List<String> tags,
  }) = _Performer;

  factory Performer.fromJson(Map<String, dynamic> json) => _$PerformerFromJson(json);
}

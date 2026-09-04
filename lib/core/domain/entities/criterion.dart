import 'package:freezed_annotation/freezed_annotation.dart';

part 'criterion.freezed.dart';
part 'criterion.g.dart';

enum CriterionModifier {
  @JsonValue('EQUALS')
  equals,
  @JsonValue('NOT_EQUALS')
  notEquals,
  @JsonValue('GREATER_THAN')
  greaterThan,
  @JsonValue('LESS_THAN')
  lessThan,
  @JsonValue('IS_NULL')
  isNull,
  @JsonValue('NOT_NULL')
  notNull,
  @JsonValue('INCLUDES_ALL')
  includesAll,
  @JsonValue('INCLUDES')
  includes,
  @JsonValue('EXCLUDES')
  excludes,
  @JsonValue('MATCHES_REGEX')
  matchesRegex,
  @JsonValue('NOT_MATCHES_REGEX')
  notMatchesRegex,
  @JsonValue('BETWEEN')
  between,
  @JsonValue('NOT_BETWEEN')
  notBetween,
}

@freezed
abstract class IntCriterion with _$IntCriterion {
  const factory IntCriterion({
    required int value,
    int? value2,
    @Default(CriterionModifier.equals) CriterionModifier modifier,
  }) = _IntCriterion;

  factory IntCriterion.fromJson(Map<String, dynamic> json) =>
      _$IntCriterionFromJson(_flattenSavedRangeCriterion(json, 0));
}

@freezed
abstract class StringCriterion with _$StringCriterion {
  const factory StringCriterion({
    required String value,
    @Default(CriterionModifier.equals) CriterionModifier modifier,
  }) = _StringCriterion;

  factory StringCriterion.fromJson(Map<String, dynamic> json) =>
      _$StringCriterionFromJson(json);
}

@freezed
abstract class DateCriterion with _$DateCriterion {
  const factory DateCriterion({
    required String value,
    String? value2,
    @Default(CriterionModifier.equals) CriterionModifier modifier,
  }) = _DateCriterion;

  factory DateCriterion.fromJson(Map<String, dynamic> json) =>
      _$DateCriterionFromJson(_flattenSavedRangeCriterion(json, ''));
}

Map<String, dynamic> _flattenSavedRangeCriterion(
  Map<String, dynamic> json,
  Object nullModifierValue,
) {
  final range = json['value'];
  if (range is! Map) return json;

  final modifier = json['modifier'];
  final value = range['value'];
  return {
    ...json,
    'value':
        value ??
        (modifier == 'IS_NULL' || modifier == 'NOT_NULL'
            ? nullModifierValue
            : value),
    'value2': range['value2'],
  };
}

@freezed
abstract class MultiCriterion with _$MultiCriterion {
  const factory MultiCriterion({
    required List<String> value,
    @Default(<String>[]) List<String> excludes,
    @Default(CriterionModifier.includes) CriterionModifier modifier,
  }) = _MultiCriterion;

  factory MultiCriterion.fromJson(Map<String, dynamic> json) =>
      _$MultiCriterionFromJson(json);
}

@freezed
abstract class HierarchicalMultiCriterion with _$HierarchicalMultiCriterion {
  const factory HierarchicalMultiCriterion({
    required List<String> value,
    @Default(<String>[]) List<String> excludes,
    @Default(0) int depth,
    @Default(CriterionModifier.includes) CriterionModifier modifier,
  }) = _HierarchicalMultiCriterion;

  factory HierarchicalMultiCriterion.fromJson(Map<String, dynamic> json) =>
      _$HierarchicalMultiCriterionFromJson(json);
}

@freezed
abstract class PhashCriterion with _$PhashCriterion {
  const factory PhashCriterion({
    required String value,
    int? distance,
    @Default(CriterionModifier.equals) CriterionModifier modifier,
  }) = _PhashCriterion;

  factory PhashCriterion.fromJson(Map<String, dynamic> json) =>
      _$PhashCriterionFromJson(_flattenSavedPhashCriterion(json));
}

@freezed
abstract class StashIdCriterion with _$StashIdCriterion {
  const factory StashIdCriterion({
    @Default('') String endpoint,
    @Default('') String stashId,
    @Default(CriterionModifier.equals) CriterionModifier modifier,
  }) = _StashIdCriterion;

  factory StashIdCriterion.fromJson(Map<String, dynamic> json) =>
      _$StashIdCriterionFromJson(_flattenSavedStashIdCriterion(json));
}

Map<String, dynamic> _flattenSavedStashIdCriterion(Map<String, dynamic> json) {
  final value = json['value'];
  if (value is! Map) return json;
  return {
    ...json,
    'endpoint': value['endpoint'] ?? '',
    'stashId': value['stashID'] ?? value['stash_id'] ?? '',
  };
}

@freezed
abstract class CustomFieldCriterion with _$CustomFieldCriterion {
  const factory CustomFieldCriterion({
    required String field,
    @Default(<Object>[]) List<Object> value,
    @Default(CriterionModifier.equals) CriterionModifier modifier,
  }) = _CustomFieldCriterion;

  factory CustomFieldCriterion.fromJson(Map<String, dynamic> json) =>
      _$CustomFieldCriterionFromJson(json);
}

Map<String, dynamic> _flattenSavedPhashCriterion(Map<String, dynamic> json) {
  final value = json['value'];
  if (value is! Map) return json;
  return {...json, 'value': value['value'], 'distance': value['distance']};
}

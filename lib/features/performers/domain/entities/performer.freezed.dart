// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'performer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Performer {

 String get id; String get name; String? get disambiguation; List<String> get urls; String? get gender; String? get birthdate; String? get ethnicity; String? get country;@JsonKey(name: 'eye_color') String? get eyeColor;@JsonKey(name: 'height_cm') int? get heightCm; String? get measurements;@JsonKey(name: 'fake_tits') String? get fakeTits;@JsonKey(name: 'penis_length') double? get penisLength; String? get circumcised;@JsonKey(name: 'career_start') String? get careerStart;@JsonKey(name: 'career_end') String? get careerEnd; String? get tattoos; String? get piercings;@JsonKey(name: 'alias_list') List<String> get aliasList; bool get favorite;@JsonKey(name: 'image_path') String? get imagePath;@JsonKey(name: 'scene_count') int get sceneCount;@JsonKey(name: 'image_count') int get imageCount;@JsonKey(name: 'gallery_count') int get galleryCount;@JsonKey(name: 'group_count') int get groupCount; int? get rating100; String? get details;@JsonKey(name: 'death_date') String? get deathDate;@JsonKey(name: 'hair_color') String? get hairColor; int? get weight;@JsonKey(name: 'tag_ids') List<String> get tagIds;@JsonKey(name: 'tag_names') List<String> get tagNames;
/// Create a copy of Performer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformerCopyWith<Performer> get copyWith => _$PerformerCopyWithImpl<Performer>(this as Performer, _$identity);

  /// Serializes this Performer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Performer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.disambiguation, disambiguation) || other.disambiguation == disambiguation)&&const DeepCollectionEquality().equals(other.urls, urls)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.ethnicity, ethnicity) || other.ethnicity == ethnicity)&&(identical(other.country, country) || other.country == country)&&(identical(other.eyeColor, eyeColor) || other.eyeColor == eyeColor)&&(identical(other.heightCm, heightCm) || other.heightCm == heightCm)&&(identical(other.measurements, measurements) || other.measurements == measurements)&&(identical(other.fakeTits, fakeTits) || other.fakeTits == fakeTits)&&(identical(other.penisLength, penisLength) || other.penisLength == penisLength)&&(identical(other.circumcised, circumcised) || other.circumcised == circumcised)&&(identical(other.careerStart, careerStart) || other.careerStart == careerStart)&&(identical(other.careerEnd, careerEnd) || other.careerEnd == careerEnd)&&(identical(other.tattoos, tattoos) || other.tattoos == tattoos)&&(identical(other.piercings, piercings) || other.piercings == piercings)&&const DeepCollectionEquality().equals(other.aliasList, aliasList)&&(identical(other.favorite, favorite) || other.favorite == favorite)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.sceneCount, sceneCount) || other.sceneCount == sceneCount)&&(identical(other.imageCount, imageCount) || other.imageCount == imageCount)&&(identical(other.galleryCount, galleryCount) || other.galleryCount == galleryCount)&&(identical(other.groupCount, groupCount) || other.groupCount == groupCount)&&(identical(other.rating100, rating100) || other.rating100 == rating100)&&(identical(other.details, details) || other.details == details)&&(identical(other.deathDate, deathDate) || other.deathDate == deathDate)&&(identical(other.hairColor, hairColor) || other.hairColor == hairColor)&&(identical(other.weight, weight) || other.weight == weight)&&const DeepCollectionEquality().equals(other.tagIds, tagIds)&&const DeepCollectionEquality().equals(other.tagNames, tagNames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,disambiguation,const DeepCollectionEquality().hash(urls),gender,birthdate,ethnicity,country,eyeColor,heightCm,measurements,fakeTits,penisLength,circumcised,careerStart,careerEnd,tattoos,piercings,const DeepCollectionEquality().hash(aliasList),favorite,imagePath,sceneCount,imageCount,galleryCount,groupCount,rating100,details,deathDate,hairColor,weight,const DeepCollectionEquality().hash(tagIds),const DeepCollectionEquality().hash(tagNames)]);

@override
String toString() {
  return 'Performer(id: $id, name: $name, disambiguation: $disambiguation, urls: $urls, gender: $gender, birthdate: $birthdate, ethnicity: $ethnicity, country: $country, eyeColor: $eyeColor, heightCm: $heightCm, measurements: $measurements, fakeTits: $fakeTits, penisLength: $penisLength, circumcised: $circumcised, careerStart: $careerStart, careerEnd: $careerEnd, tattoos: $tattoos, piercings: $piercings, aliasList: $aliasList, favorite: $favorite, imagePath: $imagePath, sceneCount: $sceneCount, imageCount: $imageCount, galleryCount: $galleryCount, groupCount: $groupCount, rating100: $rating100, details: $details, deathDate: $deathDate, hairColor: $hairColor, weight: $weight, tagIds: $tagIds, tagNames: $tagNames)';
}


}

/// @nodoc
abstract mixin class $PerformerCopyWith<$Res>  {
  factory $PerformerCopyWith(Performer value, $Res Function(Performer) _then) = _$PerformerCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? disambiguation, List<String> urls, String? gender, String? birthdate, String? ethnicity, String? country,@JsonKey(name: 'eye_color') String? eyeColor,@JsonKey(name: 'height_cm') int? heightCm, String? measurements,@JsonKey(name: 'fake_tits') String? fakeTits,@JsonKey(name: 'penis_length') double? penisLength, String? circumcised,@JsonKey(name: 'career_start') String? careerStart,@JsonKey(name: 'career_end') String? careerEnd, String? tattoos, String? piercings,@JsonKey(name: 'alias_list') List<String> aliasList, bool favorite,@JsonKey(name: 'image_path') String? imagePath,@JsonKey(name: 'scene_count') int sceneCount,@JsonKey(name: 'image_count') int imageCount,@JsonKey(name: 'gallery_count') int galleryCount,@JsonKey(name: 'group_count') int groupCount, int? rating100, String? details,@JsonKey(name: 'death_date') String? deathDate,@JsonKey(name: 'hair_color') String? hairColor, int? weight,@JsonKey(name: 'tag_ids') List<String> tagIds,@JsonKey(name: 'tag_names') List<String> tagNames
});




}
/// @nodoc
class _$PerformerCopyWithImpl<$Res>
    implements $PerformerCopyWith<$Res> {
  _$PerformerCopyWithImpl(this._self, this._then);

  final Performer _self;
  final $Res Function(Performer) _then;

/// Create a copy of Performer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? disambiguation = freezed,Object? urls = null,Object? gender = freezed,Object? birthdate = freezed,Object? ethnicity = freezed,Object? country = freezed,Object? eyeColor = freezed,Object? heightCm = freezed,Object? measurements = freezed,Object? fakeTits = freezed,Object? penisLength = freezed,Object? circumcised = freezed,Object? careerStart = freezed,Object? careerEnd = freezed,Object? tattoos = freezed,Object? piercings = freezed,Object? aliasList = null,Object? favorite = null,Object? imagePath = freezed,Object? sceneCount = null,Object? imageCount = null,Object? galleryCount = null,Object? groupCount = null,Object? rating100 = freezed,Object? details = freezed,Object? deathDate = freezed,Object? hairColor = freezed,Object? weight = freezed,Object? tagIds = null,Object? tagNames = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,disambiguation: freezed == disambiguation ? _self.disambiguation : disambiguation // ignore: cast_nullable_to_non_nullable
as String?,urls: null == urls ? _self.urls : urls // ignore: cast_nullable_to_non_nullable
as List<String>,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as String?,ethnicity: freezed == ethnicity ? _self.ethnicity : ethnicity // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,eyeColor: freezed == eyeColor ? _self.eyeColor : eyeColor // ignore: cast_nullable_to_non_nullable
as String?,heightCm: freezed == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as int?,measurements: freezed == measurements ? _self.measurements : measurements // ignore: cast_nullable_to_non_nullable
as String?,fakeTits: freezed == fakeTits ? _self.fakeTits : fakeTits // ignore: cast_nullable_to_non_nullable
as String?,penisLength: freezed == penisLength ? _self.penisLength : penisLength // ignore: cast_nullable_to_non_nullable
as double?,circumcised: freezed == circumcised ? _self.circumcised : circumcised // ignore: cast_nullable_to_non_nullable
as String?,careerStart: freezed == careerStart ? _self.careerStart : careerStart // ignore: cast_nullable_to_non_nullable
as String?,careerEnd: freezed == careerEnd ? _self.careerEnd : careerEnd // ignore: cast_nullable_to_non_nullable
as String?,tattoos: freezed == tattoos ? _self.tattoos : tattoos // ignore: cast_nullable_to_non_nullable
as String?,piercings: freezed == piercings ? _self.piercings : piercings // ignore: cast_nullable_to_non_nullable
as String?,aliasList: null == aliasList ? _self.aliasList : aliasList // ignore: cast_nullable_to_non_nullable
as List<String>,favorite: null == favorite ? _self.favorite : favorite // ignore: cast_nullable_to_non_nullable
as bool,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,sceneCount: null == sceneCount ? _self.sceneCount : sceneCount // ignore: cast_nullable_to_non_nullable
as int,imageCount: null == imageCount ? _self.imageCount : imageCount // ignore: cast_nullable_to_non_nullable
as int,galleryCount: null == galleryCount ? _self.galleryCount : galleryCount // ignore: cast_nullable_to_non_nullable
as int,groupCount: null == groupCount ? _self.groupCount : groupCount // ignore: cast_nullable_to_non_nullable
as int,rating100: freezed == rating100 ? _self.rating100 : rating100 // ignore: cast_nullable_to_non_nullable
as int?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,deathDate: freezed == deathDate ? _self.deathDate : deathDate // ignore: cast_nullable_to_non_nullable
as String?,hairColor: freezed == hairColor ? _self.hairColor : hairColor // ignore: cast_nullable_to_non_nullable
as String?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int?,tagIds: null == tagIds ? _self.tagIds : tagIds // ignore: cast_nullable_to_non_nullable
as List<String>,tagNames: null == tagNames ? _self.tagNames : tagNames // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Performer].
extension PerformerPatterns on Performer {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Performer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Performer() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Performer value)  $default,){
final _that = this;
switch (_that) {
case _Performer():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Performer value)?  $default,){
final _that = this;
switch (_that) {
case _Performer() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? disambiguation,  List<String> urls,  String? gender,  String? birthdate,  String? ethnicity,  String? country, @JsonKey(name: 'eye_color')  String? eyeColor, @JsonKey(name: 'height_cm')  int? heightCm,  String? measurements, @JsonKey(name: 'fake_tits')  String? fakeTits, @JsonKey(name: 'penis_length')  double? penisLength,  String? circumcised, @JsonKey(name: 'career_start')  String? careerStart, @JsonKey(name: 'career_end')  String? careerEnd,  String? tattoos,  String? piercings, @JsonKey(name: 'alias_list')  List<String> aliasList,  bool favorite, @JsonKey(name: 'image_path')  String? imagePath, @JsonKey(name: 'scene_count')  int sceneCount, @JsonKey(name: 'image_count')  int imageCount, @JsonKey(name: 'gallery_count')  int galleryCount, @JsonKey(name: 'group_count')  int groupCount,  int? rating100,  String? details, @JsonKey(name: 'death_date')  String? deathDate, @JsonKey(name: 'hair_color')  String? hairColor,  int? weight, @JsonKey(name: 'tag_ids')  List<String> tagIds, @JsonKey(name: 'tag_names')  List<String> tagNames)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Performer() when $default != null:
return $default(_that.id,_that.name,_that.disambiguation,_that.urls,_that.gender,_that.birthdate,_that.ethnicity,_that.country,_that.eyeColor,_that.heightCm,_that.measurements,_that.fakeTits,_that.penisLength,_that.circumcised,_that.careerStart,_that.careerEnd,_that.tattoos,_that.piercings,_that.aliasList,_that.favorite,_that.imagePath,_that.sceneCount,_that.imageCount,_that.galleryCount,_that.groupCount,_that.rating100,_that.details,_that.deathDate,_that.hairColor,_that.weight,_that.tagIds,_that.tagNames);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? disambiguation,  List<String> urls,  String? gender,  String? birthdate,  String? ethnicity,  String? country, @JsonKey(name: 'eye_color')  String? eyeColor, @JsonKey(name: 'height_cm')  int? heightCm,  String? measurements, @JsonKey(name: 'fake_tits')  String? fakeTits, @JsonKey(name: 'penis_length')  double? penisLength,  String? circumcised, @JsonKey(name: 'career_start')  String? careerStart, @JsonKey(name: 'career_end')  String? careerEnd,  String? tattoos,  String? piercings, @JsonKey(name: 'alias_list')  List<String> aliasList,  bool favorite, @JsonKey(name: 'image_path')  String? imagePath, @JsonKey(name: 'scene_count')  int sceneCount, @JsonKey(name: 'image_count')  int imageCount, @JsonKey(name: 'gallery_count')  int galleryCount, @JsonKey(name: 'group_count')  int groupCount,  int? rating100,  String? details, @JsonKey(name: 'death_date')  String? deathDate, @JsonKey(name: 'hair_color')  String? hairColor,  int? weight, @JsonKey(name: 'tag_ids')  List<String> tagIds, @JsonKey(name: 'tag_names')  List<String> tagNames)  $default,) {final _that = this;
switch (_that) {
case _Performer():
return $default(_that.id,_that.name,_that.disambiguation,_that.urls,_that.gender,_that.birthdate,_that.ethnicity,_that.country,_that.eyeColor,_that.heightCm,_that.measurements,_that.fakeTits,_that.penisLength,_that.circumcised,_that.careerStart,_that.careerEnd,_that.tattoos,_that.piercings,_that.aliasList,_that.favorite,_that.imagePath,_that.sceneCount,_that.imageCount,_that.galleryCount,_that.groupCount,_that.rating100,_that.details,_that.deathDate,_that.hairColor,_that.weight,_that.tagIds,_that.tagNames);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? disambiguation,  List<String> urls,  String? gender,  String? birthdate,  String? ethnicity,  String? country, @JsonKey(name: 'eye_color')  String? eyeColor, @JsonKey(name: 'height_cm')  int? heightCm,  String? measurements, @JsonKey(name: 'fake_tits')  String? fakeTits, @JsonKey(name: 'penis_length')  double? penisLength,  String? circumcised, @JsonKey(name: 'career_start')  String? careerStart, @JsonKey(name: 'career_end')  String? careerEnd,  String? tattoos,  String? piercings, @JsonKey(name: 'alias_list')  List<String> aliasList,  bool favorite, @JsonKey(name: 'image_path')  String? imagePath, @JsonKey(name: 'scene_count')  int sceneCount, @JsonKey(name: 'image_count')  int imageCount, @JsonKey(name: 'gallery_count')  int galleryCount, @JsonKey(name: 'group_count')  int groupCount,  int? rating100,  String? details, @JsonKey(name: 'death_date')  String? deathDate, @JsonKey(name: 'hair_color')  String? hairColor,  int? weight, @JsonKey(name: 'tag_ids')  List<String> tagIds, @JsonKey(name: 'tag_names')  List<String> tagNames)?  $default,) {final _that = this;
switch (_that) {
case _Performer() when $default != null:
return $default(_that.id,_that.name,_that.disambiguation,_that.urls,_that.gender,_that.birthdate,_that.ethnicity,_that.country,_that.eyeColor,_that.heightCm,_that.measurements,_that.fakeTits,_that.penisLength,_that.circumcised,_that.careerStart,_that.careerEnd,_that.tattoos,_that.piercings,_that.aliasList,_that.favorite,_that.imagePath,_that.sceneCount,_that.imageCount,_that.galleryCount,_that.groupCount,_that.rating100,_that.details,_that.deathDate,_that.hairColor,_that.weight,_that.tagIds,_that.tagNames);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Performer implements Performer {
  const _Performer({required this.id, required this.name, this.disambiguation, required final  List<String> urls, this.gender, required this.birthdate, this.ethnicity, this.country, @JsonKey(name: 'eye_color') this.eyeColor, @JsonKey(name: 'height_cm') this.heightCm, this.measurements, @JsonKey(name: 'fake_tits') this.fakeTits, @JsonKey(name: 'penis_length') this.penisLength, this.circumcised, @JsonKey(name: 'career_start') this.careerStart, @JsonKey(name: 'career_end') this.careerEnd, this.tattoos, this.piercings, @JsonKey(name: 'alias_list') required final  List<String> aliasList, required this.favorite, @JsonKey(name: 'image_path') required this.imagePath, @JsonKey(name: 'scene_count') required this.sceneCount, @JsonKey(name: 'image_count') required this.imageCount, @JsonKey(name: 'gallery_count') required this.galleryCount, @JsonKey(name: 'group_count') required this.groupCount, this.rating100, this.details, @JsonKey(name: 'death_date') this.deathDate, @JsonKey(name: 'hair_color') this.hairColor, this.weight, @JsonKey(name: 'tag_ids') required final  List<String> tagIds, @JsonKey(name: 'tag_names') required final  List<String> tagNames}): _urls = urls,_aliasList = aliasList,_tagIds = tagIds,_tagNames = tagNames;
  factory _Performer.fromJson(Map<String, dynamic> json) => _$PerformerFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? disambiguation;
 final  List<String> _urls;
@override List<String> get urls {
  if (_urls is EqualUnmodifiableListView) return _urls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_urls);
}

@override final  String? gender;
@override final  String? birthdate;
@override final  String? ethnicity;
@override final  String? country;
@override@JsonKey(name: 'eye_color') final  String? eyeColor;
@override@JsonKey(name: 'height_cm') final  int? heightCm;
@override final  String? measurements;
@override@JsonKey(name: 'fake_tits') final  String? fakeTits;
@override@JsonKey(name: 'penis_length') final  double? penisLength;
@override final  String? circumcised;
@override@JsonKey(name: 'career_start') final  String? careerStart;
@override@JsonKey(name: 'career_end') final  String? careerEnd;
@override final  String? tattoos;
@override final  String? piercings;
 final  List<String> _aliasList;
@override@JsonKey(name: 'alias_list') List<String> get aliasList {
  if (_aliasList is EqualUnmodifiableListView) return _aliasList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_aliasList);
}

@override final  bool favorite;
@override@JsonKey(name: 'image_path') final  String? imagePath;
@override@JsonKey(name: 'scene_count') final  int sceneCount;
@override@JsonKey(name: 'image_count') final  int imageCount;
@override@JsonKey(name: 'gallery_count') final  int galleryCount;
@override@JsonKey(name: 'group_count') final  int groupCount;
@override final  int? rating100;
@override final  String? details;
@override@JsonKey(name: 'death_date') final  String? deathDate;
@override@JsonKey(name: 'hair_color') final  String? hairColor;
@override final  int? weight;
 final  List<String> _tagIds;
@override@JsonKey(name: 'tag_ids') List<String> get tagIds {
  if (_tagIds is EqualUnmodifiableListView) return _tagIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tagIds);
}

 final  List<String> _tagNames;
@override@JsonKey(name: 'tag_names') List<String> get tagNames {
  if (_tagNames is EqualUnmodifiableListView) return _tagNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tagNames);
}


/// Create a copy of Performer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PerformerCopyWith<_Performer> get copyWith => __$PerformerCopyWithImpl<_Performer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PerformerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Performer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.disambiguation, disambiguation) || other.disambiguation == disambiguation)&&const DeepCollectionEquality().equals(other._urls, _urls)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.ethnicity, ethnicity) || other.ethnicity == ethnicity)&&(identical(other.country, country) || other.country == country)&&(identical(other.eyeColor, eyeColor) || other.eyeColor == eyeColor)&&(identical(other.heightCm, heightCm) || other.heightCm == heightCm)&&(identical(other.measurements, measurements) || other.measurements == measurements)&&(identical(other.fakeTits, fakeTits) || other.fakeTits == fakeTits)&&(identical(other.penisLength, penisLength) || other.penisLength == penisLength)&&(identical(other.circumcised, circumcised) || other.circumcised == circumcised)&&(identical(other.careerStart, careerStart) || other.careerStart == careerStart)&&(identical(other.careerEnd, careerEnd) || other.careerEnd == careerEnd)&&(identical(other.tattoos, tattoos) || other.tattoos == tattoos)&&(identical(other.piercings, piercings) || other.piercings == piercings)&&const DeepCollectionEquality().equals(other._aliasList, _aliasList)&&(identical(other.favorite, favorite) || other.favorite == favorite)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.sceneCount, sceneCount) || other.sceneCount == sceneCount)&&(identical(other.imageCount, imageCount) || other.imageCount == imageCount)&&(identical(other.galleryCount, galleryCount) || other.galleryCount == galleryCount)&&(identical(other.groupCount, groupCount) || other.groupCount == groupCount)&&(identical(other.rating100, rating100) || other.rating100 == rating100)&&(identical(other.details, details) || other.details == details)&&(identical(other.deathDate, deathDate) || other.deathDate == deathDate)&&(identical(other.hairColor, hairColor) || other.hairColor == hairColor)&&(identical(other.weight, weight) || other.weight == weight)&&const DeepCollectionEquality().equals(other._tagIds, _tagIds)&&const DeepCollectionEquality().equals(other._tagNames, _tagNames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,disambiguation,const DeepCollectionEquality().hash(_urls),gender,birthdate,ethnicity,country,eyeColor,heightCm,measurements,fakeTits,penisLength,circumcised,careerStart,careerEnd,tattoos,piercings,const DeepCollectionEquality().hash(_aliasList),favorite,imagePath,sceneCount,imageCount,galleryCount,groupCount,rating100,details,deathDate,hairColor,weight,const DeepCollectionEquality().hash(_tagIds),const DeepCollectionEquality().hash(_tagNames)]);

@override
String toString() {
  return 'Performer(id: $id, name: $name, disambiguation: $disambiguation, urls: $urls, gender: $gender, birthdate: $birthdate, ethnicity: $ethnicity, country: $country, eyeColor: $eyeColor, heightCm: $heightCm, measurements: $measurements, fakeTits: $fakeTits, penisLength: $penisLength, circumcised: $circumcised, careerStart: $careerStart, careerEnd: $careerEnd, tattoos: $tattoos, piercings: $piercings, aliasList: $aliasList, favorite: $favorite, imagePath: $imagePath, sceneCount: $sceneCount, imageCount: $imageCount, galleryCount: $galleryCount, groupCount: $groupCount, rating100: $rating100, details: $details, deathDate: $deathDate, hairColor: $hairColor, weight: $weight, tagIds: $tagIds, tagNames: $tagNames)';
}


}

/// @nodoc
abstract mixin class _$PerformerCopyWith<$Res> implements $PerformerCopyWith<$Res> {
  factory _$PerformerCopyWith(_Performer value, $Res Function(_Performer) _then) = __$PerformerCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? disambiguation, List<String> urls, String? gender, String? birthdate, String? ethnicity, String? country,@JsonKey(name: 'eye_color') String? eyeColor,@JsonKey(name: 'height_cm') int? heightCm, String? measurements,@JsonKey(name: 'fake_tits') String? fakeTits,@JsonKey(name: 'penis_length') double? penisLength, String? circumcised,@JsonKey(name: 'career_start') String? careerStart,@JsonKey(name: 'career_end') String? careerEnd, String? tattoos, String? piercings,@JsonKey(name: 'alias_list') List<String> aliasList, bool favorite,@JsonKey(name: 'image_path') String? imagePath,@JsonKey(name: 'scene_count') int sceneCount,@JsonKey(name: 'image_count') int imageCount,@JsonKey(name: 'gallery_count') int galleryCount,@JsonKey(name: 'group_count') int groupCount, int? rating100, String? details,@JsonKey(name: 'death_date') String? deathDate,@JsonKey(name: 'hair_color') String? hairColor, int? weight,@JsonKey(name: 'tag_ids') List<String> tagIds,@JsonKey(name: 'tag_names') List<String> tagNames
});




}
/// @nodoc
class __$PerformerCopyWithImpl<$Res>
    implements _$PerformerCopyWith<$Res> {
  __$PerformerCopyWithImpl(this._self, this._then);

  final _Performer _self;
  final $Res Function(_Performer) _then;

/// Create a copy of Performer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? disambiguation = freezed,Object? urls = null,Object? gender = freezed,Object? birthdate = freezed,Object? ethnicity = freezed,Object? country = freezed,Object? eyeColor = freezed,Object? heightCm = freezed,Object? measurements = freezed,Object? fakeTits = freezed,Object? penisLength = freezed,Object? circumcised = freezed,Object? careerStart = freezed,Object? careerEnd = freezed,Object? tattoos = freezed,Object? piercings = freezed,Object? aliasList = null,Object? favorite = null,Object? imagePath = freezed,Object? sceneCount = null,Object? imageCount = null,Object? galleryCount = null,Object? groupCount = null,Object? rating100 = freezed,Object? details = freezed,Object? deathDate = freezed,Object? hairColor = freezed,Object? weight = freezed,Object? tagIds = null,Object? tagNames = null,}) {
  return _then(_Performer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,disambiguation: freezed == disambiguation ? _self.disambiguation : disambiguation // ignore: cast_nullable_to_non_nullable
as String?,urls: null == urls ? _self._urls : urls // ignore: cast_nullable_to_non_nullable
as List<String>,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as String?,ethnicity: freezed == ethnicity ? _self.ethnicity : ethnicity // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,eyeColor: freezed == eyeColor ? _self.eyeColor : eyeColor // ignore: cast_nullable_to_non_nullable
as String?,heightCm: freezed == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as int?,measurements: freezed == measurements ? _self.measurements : measurements // ignore: cast_nullable_to_non_nullable
as String?,fakeTits: freezed == fakeTits ? _self.fakeTits : fakeTits // ignore: cast_nullable_to_non_nullable
as String?,penisLength: freezed == penisLength ? _self.penisLength : penisLength // ignore: cast_nullable_to_non_nullable
as double?,circumcised: freezed == circumcised ? _self.circumcised : circumcised // ignore: cast_nullable_to_non_nullable
as String?,careerStart: freezed == careerStart ? _self.careerStart : careerStart // ignore: cast_nullable_to_non_nullable
as String?,careerEnd: freezed == careerEnd ? _self.careerEnd : careerEnd // ignore: cast_nullable_to_non_nullable
as String?,tattoos: freezed == tattoos ? _self.tattoos : tattoos // ignore: cast_nullable_to_non_nullable
as String?,piercings: freezed == piercings ? _self.piercings : piercings // ignore: cast_nullable_to_non_nullable
as String?,aliasList: null == aliasList ? _self._aliasList : aliasList // ignore: cast_nullable_to_non_nullable
as List<String>,favorite: null == favorite ? _self.favorite : favorite // ignore: cast_nullable_to_non_nullable
as bool,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,sceneCount: null == sceneCount ? _self.sceneCount : sceneCount // ignore: cast_nullable_to_non_nullable
as int,imageCount: null == imageCount ? _self.imageCount : imageCount // ignore: cast_nullable_to_non_nullable
as int,galleryCount: null == galleryCount ? _self.galleryCount : galleryCount // ignore: cast_nullable_to_non_nullable
as int,groupCount: null == groupCount ? _self.groupCount : groupCount // ignore: cast_nullable_to_non_nullable
as int,rating100: freezed == rating100 ? _self.rating100 : rating100 // ignore: cast_nullable_to_non_nullable
as int?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,deathDate: freezed == deathDate ? _self.deathDate : deathDate // ignore: cast_nullable_to_non_nullable
as String?,hairColor: freezed == hairColor ? _self.hairColor : hairColor // ignore: cast_nullable_to_non_nullable
as String?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int?,tagIds: null == tagIds ? _self._tagIds : tagIds // ignore: cast_nullable_to_non_nullable
as List<String>,tagNames: null == tagNames ? _self._tagNames : tagNames // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on

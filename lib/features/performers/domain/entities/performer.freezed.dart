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

 String get id; String get name; String? get details; String? get gender; String? get birthdate; String? get imagePath; List<String> get tags;
/// Create a copy of Performer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformerCopyWith<Performer> get copyWith => _$PerformerCopyWithImpl<Performer>(this as Performer, _$identity);

  /// Serializes this Performer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Performer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.details, details) || other.details == details)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,details,gender,birthdate,imagePath,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'Performer(id: $id, name: $name, details: $details, gender: $gender, birthdate: $birthdate, imagePath: $imagePath, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $PerformerCopyWith<$Res>  {
  factory $PerformerCopyWith(Performer value, $Res Function(Performer) _then) = _$PerformerCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? details, String? gender, String? birthdate, String? imagePath, List<String> tags
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? details = freezed,Object? gender = freezed,Object? birthdate = freezed,Object? imagePath = freezed,Object? tags = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as String?,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? details,  String? gender,  String? birthdate,  String? imagePath,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Performer() when $default != null:
return $default(_that.id,_that.name,_that.details,_that.gender,_that.birthdate,_that.imagePath,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? details,  String? gender,  String? birthdate,  String? imagePath,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _Performer():
return $default(_that.id,_that.name,_that.details,_that.gender,_that.birthdate,_that.imagePath,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? details,  String? gender,  String? birthdate,  String? imagePath,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _Performer() when $default != null:
return $default(_that.id,_that.name,_that.details,_that.gender,_that.birthdate,_that.imagePath,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Performer implements Performer {
  const _Performer({required this.id, required this.name, this.details, this.gender, required this.birthdate, required this.imagePath, required final  List<String> tags}): _tags = tags;
  factory _Performer.fromJson(Map<String, dynamic> json) => _$PerformerFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? details;
@override final  String? gender;
@override final  String? birthdate;
@override final  String? imagePath;
 final  List<String> _tags;
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Performer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.details, details) || other.details == details)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,details,gender,birthdate,imagePath,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'Performer(id: $id, name: $name, details: $details, gender: $gender, birthdate: $birthdate, imagePath: $imagePath, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$PerformerCopyWith<$Res> implements $PerformerCopyWith<$Res> {
  factory _$PerformerCopyWith(_Performer value, $Res Function(_Performer) _then) = __$PerformerCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? details, String? gender, String? birthdate, String? imagePath, List<String> tags
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? details = freezed,Object? gender = freezed,Object? birthdate = freezed,Object? imagePath = freezed,Object? tags = null,}) {
  return _then(_Performer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as String?,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on

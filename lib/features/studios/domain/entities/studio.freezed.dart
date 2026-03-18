// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'studio.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Studio {

 String get id; String get name; String? get details; String? get imagePath; String? get parentId; String? get parentName;
/// Create a copy of Studio
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudioCopyWith<Studio> get copyWith => _$StudioCopyWithImpl<Studio>(this as Studio, _$identity);

  /// Serializes this Studio to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Studio&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.details, details) || other.details == details)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.parentName, parentName) || other.parentName == parentName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,details,imagePath,parentId,parentName);

@override
String toString() {
  return 'Studio(id: $id, name: $name, details: $details, imagePath: $imagePath, parentId: $parentId, parentName: $parentName)';
}


}

/// @nodoc
abstract mixin class $StudioCopyWith<$Res>  {
  factory $StudioCopyWith(Studio value, $Res Function(Studio) _then) = _$StudioCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? details, String? imagePath, String? parentId, String? parentName
});




}
/// @nodoc
class _$StudioCopyWithImpl<$Res>
    implements $StudioCopyWith<$Res> {
  _$StudioCopyWithImpl(this._self, this._then);

  final Studio _self;
  final $Res Function(Studio) _then;

/// Create a copy of Studio
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? details = freezed,Object? imagePath = freezed,Object? parentId = freezed,Object? parentName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,parentName: freezed == parentName ? _self.parentName : parentName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Studio].
extension StudioPatterns on Studio {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Studio value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Studio() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Studio value)  $default,){
final _that = this;
switch (_that) {
case _Studio():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Studio value)?  $default,){
final _that = this;
switch (_that) {
case _Studio() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? details,  String? imagePath,  String? parentId,  String? parentName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Studio() when $default != null:
return $default(_that.id,_that.name,_that.details,_that.imagePath,_that.parentId,_that.parentName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? details,  String? imagePath,  String? parentId,  String? parentName)  $default,) {final _that = this;
switch (_that) {
case _Studio():
return $default(_that.id,_that.name,_that.details,_that.imagePath,_that.parentId,_that.parentName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? details,  String? imagePath,  String? parentId,  String? parentName)?  $default,) {final _that = this;
switch (_that) {
case _Studio() when $default != null:
return $default(_that.id,_that.name,_that.details,_that.imagePath,_that.parentId,_that.parentName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Studio implements Studio {
  const _Studio({required this.id, required this.name, this.details, required this.imagePath, this.parentId, this.parentName});
  factory _Studio.fromJson(Map<String, dynamic> json) => _$StudioFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? details;
@override final  String? imagePath;
@override final  String? parentId;
@override final  String? parentName;

/// Create a copy of Studio
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudioCopyWith<_Studio> get copyWith => __$StudioCopyWithImpl<_Studio>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudioToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Studio&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.details, details) || other.details == details)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.parentName, parentName) || other.parentName == parentName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,details,imagePath,parentId,parentName);

@override
String toString() {
  return 'Studio(id: $id, name: $name, details: $details, imagePath: $imagePath, parentId: $parentId, parentName: $parentName)';
}


}

/// @nodoc
abstract mixin class _$StudioCopyWith<$Res> implements $StudioCopyWith<$Res> {
  factory _$StudioCopyWith(_Studio value, $Res Function(_Studio) _then) = __$StudioCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? details, String? imagePath, String? parentId, String? parentName
});




}
/// @nodoc
class __$StudioCopyWithImpl<$Res>
    implements _$StudioCopyWith<$Res> {
  __$StudioCopyWithImpl(this._self, this._then);

  final _Studio _self;
  final $Res Function(_Studio) _then;

/// Create a copy of Studio
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? details = freezed,Object? imagePath = freezed,Object? parentId = freezed,Object? parentName = freezed,}) {
  return _then(_Studio(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,parentName: freezed == parentName ? _self.parentName : parentName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

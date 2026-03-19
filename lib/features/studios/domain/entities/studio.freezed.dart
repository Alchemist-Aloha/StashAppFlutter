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

 String get id; String get name; String? get url;@JsonKey(name: 'image_path') String? get imagePath; String? get details; int? get rating100;@JsonKey(name: 'scene_count') int get sceneCount;@JsonKey(name: 'image_count') int get imageCount;@JsonKey(name: 'gallery_count') int get galleryCount;@JsonKey(name: 'performer_count') int get performerCount; bool get favorite;
/// Create a copy of Studio
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudioCopyWith<Studio> get copyWith => _$StudioCopyWithImpl<Studio>(this as Studio, _$identity);

  /// Serializes this Studio to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Studio&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.details, details) || other.details == details)&&(identical(other.rating100, rating100) || other.rating100 == rating100)&&(identical(other.sceneCount, sceneCount) || other.sceneCount == sceneCount)&&(identical(other.imageCount, imageCount) || other.imageCount == imageCount)&&(identical(other.galleryCount, galleryCount) || other.galleryCount == galleryCount)&&(identical(other.performerCount, performerCount) || other.performerCount == performerCount)&&(identical(other.favorite, favorite) || other.favorite == favorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,url,imagePath,details,rating100,sceneCount,imageCount,galleryCount,performerCount,favorite);

@override
String toString() {
  return 'Studio(id: $id, name: $name, url: $url, imagePath: $imagePath, details: $details, rating100: $rating100, sceneCount: $sceneCount, imageCount: $imageCount, galleryCount: $galleryCount, performerCount: $performerCount, favorite: $favorite)';
}


}

/// @nodoc
abstract mixin class $StudioCopyWith<$Res>  {
  factory $StudioCopyWith(Studio value, $Res Function(Studio) _then) = _$StudioCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? url,@JsonKey(name: 'image_path') String? imagePath, String? details, int? rating100,@JsonKey(name: 'scene_count') int sceneCount,@JsonKey(name: 'image_count') int imageCount,@JsonKey(name: 'gallery_count') int galleryCount,@JsonKey(name: 'performer_count') int performerCount, bool favorite
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? url = freezed,Object? imagePath = freezed,Object? details = freezed,Object? rating100 = freezed,Object? sceneCount = null,Object? imageCount = null,Object? galleryCount = null,Object? performerCount = null,Object? favorite = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,rating100: freezed == rating100 ? _self.rating100 : rating100 // ignore: cast_nullable_to_non_nullable
as int?,sceneCount: null == sceneCount ? _self.sceneCount : sceneCount // ignore: cast_nullable_to_non_nullable
as int,imageCount: null == imageCount ? _self.imageCount : imageCount // ignore: cast_nullable_to_non_nullable
as int,galleryCount: null == galleryCount ? _self.galleryCount : galleryCount // ignore: cast_nullable_to_non_nullable
as int,performerCount: null == performerCount ? _self.performerCount : performerCount // ignore: cast_nullable_to_non_nullable
as int,favorite: null == favorite ? _self.favorite : favorite // ignore: cast_nullable_to_non_nullable
as bool,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? url, @JsonKey(name: 'image_path')  String? imagePath,  String? details,  int? rating100, @JsonKey(name: 'scene_count')  int sceneCount, @JsonKey(name: 'image_count')  int imageCount, @JsonKey(name: 'gallery_count')  int galleryCount, @JsonKey(name: 'performer_count')  int performerCount,  bool favorite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Studio() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.imagePath,_that.details,_that.rating100,_that.sceneCount,_that.imageCount,_that.galleryCount,_that.performerCount,_that.favorite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? url, @JsonKey(name: 'image_path')  String? imagePath,  String? details,  int? rating100, @JsonKey(name: 'scene_count')  int sceneCount, @JsonKey(name: 'image_count')  int imageCount, @JsonKey(name: 'gallery_count')  int galleryCount, @JsonKey(name: 'performer_count')  int performerCount,  bool favorite)  $default,) {final _that = this;
switch (_that) {
case _Studio():
return $default(_that.id,_that.name,_that.url,_that.imagePath,_that.details,_that.rating100,_that.sceneCount,_that.imageCount,_that.galleryCount,_that.performerCount,_that.favorite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? url, @JsonKey(name: 'image_path')  String? imagePath,  String? details,  int? rating100, @JsonKey(name: 'scene_count')  int sceneCount, @JsonKey(name: 'image_count')  int imageCount, @JsonKey(name: 'gallery_count')  int galleryCount, @JsonKey(name: 'performer_count')  int performerCount,  bool favorite)?  $default,) {final _that = this;
switch (_that) {
case _Studio() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.imagePath,_that.details,_that.rating100,_that.sceneCount,_that.imageCount,_that.galleryCount,_that.performerCount,_that.favorite);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Studio implements Studio {
  const _Studio({required this.id, required this.name, this.url, @JsonKey(name: 'image_path') this.imagePath, this.details, this.rating100, @JsonKey(name: 'scene_count') required this.sceneCount, @JsonKey(name: 'image_count') required this.imageCount, @JsonKey(name: 'gallery_count') required this.galleryCount, @JsonKey(name: 'performer_count') required this.performerCount, required this.favorite});
  factory _Studio.fromJson(Map<String, dynamic> json) => _$StudioFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? url;
@override@JsonKey(name: 'image_path') final  String? imagePath;
@override final  String? details;
@override final  int? rating100;
@override@JsonKey(name: 'scene_count') final  int sceneCount;
@override@JsonKey(name: 'image_count') final  int imageCount;
@override@JsonKey(name: 'gallery_count') final  int galleryCount;
@override@JsonKey(name: 'performer_count') final  int performerCount;
@override final  bool favorite;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Studio&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.details, details) || other.details == details)&&(identical(other.rating100, rating100) || other.rating100 == rating100)&&(identical(other.sceneCount, sceneCount) || other.sceneCount == sceneCount)&&(identical(other.imageCount, imageCount) || other.imageCount == imageCount)&&(identical(other.galleryCount, galleryCount) || other.galleryCount == galleryCount)&&(identical(other.performerCount, performerCount) || other.performerCount == performerCount)&&(identical(other.favorite, favorite) || other.favorite == favorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,url,imagePath,details,rating100,sceneCount,imageCount,galleryCount,performerCount,favorite);

@override
String toString() {
  return 'Studio(id: $id, name: $name, url: $url, imagePath: $imagePath, details: $details, rating100: $rating100, sceneCount: $sceneCount, imageCount: $imageCount, galleryCount: $galleryCount, performerCount: $performerCount, favorite: $favorite)';
}


}

/// @nodoc
abstract mixin class _$StudioCopyWith<$Res> implements $StudioCopyWith<$Res> {
  factory _$StudioCopyWith(_Studio value, $Res Function(_Studio) _then) = __$StudioCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? url,@JsonKey(name: 'image_path') String? imagePath, String? details, int? rating100,@JsonKey(name: 'scene_count') int sceneCount,@JsonKey(name: 'image_count') int imageCount,@JsonKey(name: 'gallery_count') int galleryCount,@JsonKey(name: 'performer_count') int performerCount, bool favorite
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? url = freezed,Object? imagePath = freezed,Object? details = freezed,Object? rating100 = freezed,Object? sceneCount = null,Object? imageCount = null,Object? galleryCount = null,Object? performerCount = null,Object? favorite = null,}) {
  return _then(_Studio(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,rating100: freezed == rating100 ? _self.rating100 : rating100 // ignore: cast_nullable_to_non_nullable
as int?,sceneCount: null == sceneCount ? _self.sceneCount : sceneCount // ignore: cast_nullable_to_non_nullable
as int,imageCount: null == imageCount ? _self.imageCount : imageCount // ignore: cast_nullable_to_non_nullable
as int,galleryCount: null == galleryCount ? _self.galleryCount : galleryCount // ignore: cast_nullable_to_non_nullable
as int,performerCount: null == performerCount ? _self.performerCount : performerCount // ignore: cast_nullable_to_non_nullable
as int,favorite: null == favorite ? _self.favorite : favorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

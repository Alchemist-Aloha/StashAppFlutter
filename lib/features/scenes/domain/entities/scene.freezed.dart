// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scene.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Scene {

 String get id; String get title; String? get details; String? get path; DateTime get date; double get rating; List<String> get tags; List<String> get performers; String? get studio; String? get streamUrl; String? get thumbUrl;
/// Create a copy of Scene
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SceneCopyWith<Scene> get copyWith => _$SceneCopyWithImpl<Scene>(this as Scene, _$identity);

  /// Serializes this Scene to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Scene&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.details, details) || other.details == details)&&(identical(other.path, path) || other.path == path)&&(identical(other.date, date) || other.date == date)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.performers, performers)&&(identical(other.studio, studio) || other.studio == studio)&&(identical(other.streamUrl, streamUrl) || other.streamUrl == streamUrl)&&(identical(other.thumbUrl, thumbUrl) || other.thumbUrl == thumbUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,details,path,date,rating,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(performers),studio,streamUrl,thumbUrl);

@override
String toString() {
  return 'Scene(id: $id, title: $title, details: $details, path: $path, date: $date, rating: $rating, tags: $tags, performers: $performers, studio: $studio, streamUrl: $streamUrl, thumbUrl: $thumbUrl)';
}


}

/// @nodoc
abstract mixin class $SceneCopyWith<$Res>  {
  factory $SceneCopyWith(Scene value, $Res Function(Scene) _then) = _$SceneCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? details, String? path, DateTime date, double rating, List<String> tags, List<String> performers, String? studio, String? streamUrl, String? thumbUrl
});




}
/// @nodoc
class _$SceneCopyWithImpl<$Res>
    implements $SceneCopyWith<$Res> {
  _$SceneCopyWithImpl(this._self, this._then);

  final Scene _self;
  final $Res Function(Scene) _then;

/// Create a copy of Scene
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? details = freezed,Object? path = freezed,Object? date = null,Object? rating = null,Object? tags = null,Object? performers = null,Object? studio = freezed,Object? streamUrl = freezed,Object? thumbUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,performers: null == performers ? _self.performers : performers // ignore: cast_nullable_to_non_nullable
as List<String>,studio: freezed == studio ? _self.studio : studio // ignore: cast_nullable_to_non_nullable
as String?,streamUrl: freezed == streamUrl ? _self.streamUrl : streamUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbUrl: freezed == thumbUrl ? _self.thumbUrl : thumbUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Scene].
extension ScenePatterns on Scene {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Scene value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Scene() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Scene value)  $default,){
final _that = this;
switch (_that) {
case _Scene():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Scene value)?  $default,){
final _that = this;
switch (_that) {
case _Scene() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? details,  String? path,  DateTime date,  double rating,  List<String> tags,  List<String> performers,  String? studio,  String? streamUrl,  String? thumbUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Scene() when $default != null:
return $default(_that.id,_that.title,_that.details,_that.path,_that.date,_that.rating,_that.tags,_that.performers,_that.studio,_that.streamUrl,_that.thumbUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? details,  String? path,  DateTime date,  double rating,  List<String> tags,  List<String> performers,  String? studio,  String? streamUrl,  String? thumbUrl)  $default,) {final _that = this;
switch (_that) {
case _Scene():
return $default(_that.id,_that.title,_that.details,_that.path,_that.date,_that.rating,_that.tags,_that.performers,_that.studio,_that.streamUrl,_that.thumbUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? details,  String? path,  DateTime date,  double rating,  List<String> tags,  List<String> performers,  String? studio,  String? streamUrl,  String? thumbUrl)?  $default,) {final _that = this;
switch (_that) {
case _Scene() when $default != null:
return $default(_that.id,_that.title,_that.details,_that.path,_that.date,_that.rating,_that.tags,_that.performers,_that.studio,_that.streamUrl,_that.thumbUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Scene implements Scene {
  const _Scene({required this.id, required this.title, this.details, this.path, required this.date, required this.rating, required final  List<String> tags, required final  List<String> performers, required this.studio, required this.streamUrl, required this.thumbUrl}): _tags = tags,_performers = performers;
  factory _Scene.fromJson(Map<String, dynamic> json) => _$SceneFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? details;
@override final  String? path;
@override final  DateTime date;
@override final  double rating;
 final  List<String> _tags;
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

 final  List<String> _performers;
@override List<String> get performers {
  if (_performers is EqualUnmodifiableListView) return _performers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_performers);
}

@override final  String? studio;
@override final  String? streamUrl;
@override final  String? thumbUrl;

/// Create a copy of Scene
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SceneCopyWith<_Scene> get copyWith => __$SceneCopyWithImpl<_Scene>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SceneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Scene&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.details, details) || other.details == details)&&(identical(other.path, path) || other.path == path)&&(identical(other.date, date) || other.date == date)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._performers, _performers)&&(identical(other.studio, studio) || other.studio == studio)&&(identical(other.streamUrl, streamUrl) || other.streamUrl == streamUrl)&&(identical(other.thumbUrl, thumbUrl) || other.thumbUrl == thumbUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,details,path,date,rating,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_performers),studio,streamUrl,thumbUrl);

@override
String toString() {
  return 'Scene(id: $id, title: $title, details: $details, path: $path, date: $date, rating: $rating, tags: $tags, performers: $performers, studio: $studio, streamUrl: $streamUrl, thumbUrl: $thumbUrl)';
}


}

/// @nodoc
abstract mixin class _$SceneCopyWith<$Res> implements $SceneCopyWith<$Res> {
  factory _$SceneCopyWith(_Scene value, $Res Function(_Scene) _then) = __$SceneCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? details, String? path, DateTime date, double rating, List<String> tags, List<String> performers, String? studio, String? streamUrl, String? thumbUrl
});




}
/// @nodoc
class __$SceneCopyWithImpl<$Res>
    implements _$SceneCopyWith<$Res> {
  __$SceneCopyWithImpl(this._self, this._then);

  final _Scene _self;
  final $Res Function(_Scene) _then;

/// Create a copy of Scene
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? details = freezed,Object? path = freezed,Object? date = null,Object? rating = null,Object? tags = null,Object? performers = null,Object? studio = freezed,Object? streamUrl = freezed,Object? thumbUrl = freezed,}) {
  return _then(_Scene(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,performers: null == performers ? _self._performers : performers // ignore: cast_nullable_to_non_nullable
as List<String>,studio: freezed == studio ? _self.studio : studio // ignore: cast_nullable_to_non_nullable
as String?,streamUrl: freezed == streamUrl ? _self.streamUrl : streamUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbUrl: freezed == thumbUrl ? _self.thumbUrl : thumbUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

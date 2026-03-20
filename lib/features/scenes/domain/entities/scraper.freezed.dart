// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scraper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Scraper {

 String get id; String get name; List<String> get supportedScrapes;
/// Create a copy of Scraper
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScraperCopyWith<Scraper> get copyWith => _$ScraperCopyWithImpl<Scraper>(this as Scraper, _$identity);

  /// Serializes this Scraper to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Scraper&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.supportedScrapes, supportedScrapes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(supportedScrapes));

@override
String toString() {
  return 'Scraper(id: $id, name: $name, supportedScrapes: $supportedScrapes)';
}


}

/// @nodoc
abstract mixin class $ScraperCopyWith<$Res>  {
  factory $ScraperCopyWith(Scraper value, $Res Function(Scraper) _then) = _$ScraperCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<String> supportedScrapes
});




}
/// @nodoc
class _$ScraperCopyWithImpl<$Res>
    implements $ScraperCopyWith<$Res> {
  _$ScraperCopyWithImpl(this._self, this._then);

  final Scraper _self;
  final $Res Function(Scraper) _then;

/// Create a copy of Scraper
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? supportedScrapes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,supportedScrapes: null == supportedScrapes ? _self.supportedScrapes : supportedScrapes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Scraper].
extension ScraperPatterns on Scraper {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Scraper value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Scraper() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Scraper value)  $default,){
final _that = this;
switch (_that) {
case _Scraper():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Scraper value)?  $default,){
final _that = this;
switch (_that) {
case _Scraper() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<String> supportedScrapes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Scraper() when $default != null:
return $default(_that.id,_that.name,_that.supportedScrapes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<String> supportedScrapes)  $default,) {final _that = this;
switch (_that) {
case _Scraper():
return $default(_that.id,_that.name,_that.supportedScrapes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<String> supportedScrapes)?  $default,) {final _that = this;
switch (_that) {
case _Scraper() when $default != null:
return $default(_that.id,_that.name,_that.supportedScrapes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Scraper implements Scraper {
  const _Scraper({required this.id, required this.name, required final  List<String> supportedScrapes}): _supportedScrapes = supportedScrapes;
  factory _Scraper.fromJson(Map<String, dynamic> json) => _$ScraperFromJson(json);

@override final  String id;
@override final  String name;
 final  List<String> _supportedScrapes;
@override List<String> get supportedScrapes {
  if (_supportedScrapes is EqualUnmodifiableListView) return _supportedScrapes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_supportedScrapes);
}


/// Create a copy of Scraper
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScraperCopyWith<_Scraper> get copyWith => __$ScraperCopyWithImpl<_Scraper>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScraperToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Scraper&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._supportedScrapes, _supportedScrapes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_supportedScrapes));

@override
String toString() {
  return 'Scraper(id: $id, name: $name, supportedScrapes: $supportedScrapes)';
}


}

/// @nodoc
abstract mixin class _$ScraperCopyWith<$Res> implements $ScraperCopyWith<$Res> {
  factory _$ScraperCopyWith(_Scraper value, $Res Function(_Scraper) _then) = __$ScraperCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<String> supportedScrapes
});




}
/// @nodoc
class __$ScraperCopyWithImpl<$Res>
    implements _$ScraperCopyWith<$Res> {
  __$ScraperCopyWithImpl(this._self, this._then);

  final _Scraper _self;
  final $Res Function(_Scraper) _then;

/// Create a copy of Scraper
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? supportedScrapes = null,}) {
  return _then(_Scraper(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,supportedScrapes: null == supportedScrapes ? _self._supportedScrapes : supportedScrapes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ScrapedScene {

 String? get title; String? get code; String? get details; String? get director; List<String> get urls; String? get date; String? get image; ScrapedEntity? get studio; List<ScrapedEntity> get tags; List<ScrapedEntity> get performers;
/// Create a copy of ScrapedScene
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScrapedSceneCopyWith<ScrapedScene> get copyWith => _$ScrapedSceneCopyWithImpl<ScrapedScene>(this as ScrapedScene, _$identity);

  /// Serializes this ScrapedScene to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScrapedScene&&(identical(other.title, title) || other.title == title)&&(identical(other.code, code) || other.code == code)&&(identical(other.details, details) || other.details == details)&&(identical(other.director, director) || other.director == director)&&const DeepCollectionEquality().equals(other.urls, urls)&&(identical(other.date, date) || other.date == date)&&(identical(other.image, image) || other.image == image)&&(identical(other.studio, studio) || other.studio == studio)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.performers, performers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,code,details,director,const DeepCollectionEquality().hash(urls),date,image,studio,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(performers));

@override
String toString() {
  return 'ScrapedScene(title: $title, code: $code, details: $details, director: $director, urls: $urls, date: $date, image: $image, studio: $studio, tags: $tags, performers: $performers)';
}


}

/// @nodoc
abstract mixin class $ScrapedSceneCopyWith<$Res>  {
  factory $ScrapedSceneCopyWith(ScrapedScene value, $Res Function(ScrapedScene) _then) = _$ScrapedSceneCopyWithImpl;
@useResult
$Res call({
 String? title, String? code, String? details, String? director, List<String> urls, String? date, String? image, ScrapedEntity? studio, List<ScrapedEntity> tags, List<ScrapedEntity> performers
});


$ScrapedEntityCopyWith<$Res>? get studio;

}
/// @nodoc
class _$ScrapedSceneCopyWithImpl<$Res>
    implements $ScrapedSceneCopyWith<$Res> {
  _$ScrapedSceneCopyWithImpl(this._self, this._then);

  final ScrapedScene _self;
  final $Res Function(ScrapedScene) _then;

/// Create a copy of ScrapedScene
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? code = freezed,Object? details = freezed,Object? director = freezed,Object? urls = null,Object? date = freezed,Object? image = freezed,Object? studio = freezed,Object? tags = null,Object? performers = null,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,director: freezed == director ? _self.director : director // ignore: cast_nullable_to_non_nullable
as String?,urls: null == urls ? _self.urls : urls // ignore: cast_nullable_to_non_nullable
as List<String>,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,studio: freezed == studio ? _self.studio : studio // ignore: cast_nullable_to_non_nullable
as ScrapedEntity?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<ScrapedEntity>,performers: null == performers ? _self.performers : performers // ignore: cast_nullable_to_non_nullable
as List<ScrapedEntity>,
  ));
}
/// Create a copy of ScrapedScene
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScrapedEntityCopyWith<$Res>? get studio {
    if (_self.studio == null) {
    return null;
  }

  return $ScrapedEntityCopyWith<$Res>(_self.studio!, (value) {
    return _then(_self.copyWith(studio: value));
  });
}
}


/// Adds pattern-matching-related methods to [ScrapedScene].
extension ScrapedScenePatterns on ScrapedScene {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScrapedScene value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScrapedScene() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScrapedScene value)  $default,){
final _that = this;
switch (_that) {
case _ScrapedScene():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScrapedScene value)?  $default,){
final _that = this;
switch (_that) {
case _ScrapedScene() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  String? code,  String? details,  String? director,  List<String> urls,  String? date,  String? image,  ScrapedEntity? studio,  List<ScrapedEntity> tags,  List<ScrapedEntity> performers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScrapedScene() when $default != null:
return $default(_that.title,_that.code,_that.details,_that.director,_that.urls,_that.date,_that.image,_that.studio,_that.tags,_that.performers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  String? code,  String? details,  String? director,  List<String> urls,  String? date,  String? image,  ScrapedEntity? studio,  List<ScrapedEntity> tags,  List<ScrapedEntity> performers)  $default,) {final _that = this;
switch (_that) {
case _ScrapedScene():
return $default(_that.title,_that.code,_that.details,_that.director,_that.urls,_that.date,_that.image,_that.studio,_that.tags,_that.performers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  String? code,  String? details,  String? director,  List<String> urls,  String? date,  String? image,  ScrapedEntity? studio,  List<ScrapedEntity> tags,  List<ScrapedEntity> performers)?  $default,) {final _that = this;
switch (_that) {
case _ScrapedScene() when $default != null:
return $default(_that.title,_that.code,_that.details,_that.director,_that.urls,_that.date,_that.image,_that.studio,_that.tags,_that.performers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScrapedScene implements ScrapedScene {
  const _ScrapedScene({this.title, this.code, this.details, this.director, required final  List<String> urls, this.date, this.image, this.studio, required final  List<ScrapedEntity> tags, required final  List<ScrapedEntity> performers}): _urls = urls,_tags = tags,_performers = performers;
  factory _ScrapedScene.fromJson(Map<String, dynamic> json) => _$ScrapedSceneFromJson(json);

@override final  String? title;
@override final  String? code;
@override final  String? details;
@override final  String? director;
 final  List<String> _urls;
@override List<String> get urls {
  if (_urls is EqualUnmodifiableListView) return _urls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_urls);
}

@override final  String? date;
@override final  String? image;
@override final  ScrapedEntity? studio;
 final  List<ScrapedEntity> _tags;
@override List<ScrapedEntity> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

 final  List<ScrapedEntity> _performers;
@override List<ScrapedEntity> get performers {
  if (_performers is EqualUnmodifiableListView) return _performers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_performers);
}


/// Create a copy of ScrapedScene
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScrapedSceneCopyWith<_ScrapedScene> get copyWith => __$ScrapedSceneCopyWithImpl<_ScrapedScene>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScrapedSceneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScrapedScene&&(identical(other.title, title) || other.title == title)&&(identical(other.code, code) || other.code == code)&&(identical(other.details, details) || other.details == details)&&(identical(other.director, director) || other.director == director)&&const DeepCollectionEquality().equals(other._urls, _urls)&&(identical(other.date, date) || other.date == date)&&(identical(other.image, image) || other.image == image)&&(identical(other.studio, studio) || other.studio == studio)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._performers, _performers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,code,details,director,const DeepCollectionEquality().hash(_urls),date,image,studio,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_performers));

@override
String toString() {
  return 'ScrapedScene(title: $title, code: $code, details: $details, director: $director, urls: $urls, date: $date, image: $image, studio: $studio, tags: $tags, performers: $performers)';
}


}

/// @nodoc
abstract mixin class _$ScrapedSceneCopyWith<$Res> implements $ScrapedSceneCopyWith<$Res> {
  factory _$ScrapedSceneCopyWith(_ScrapedScene value, $Res Function(_ScrapedScene) _then) = __$ScrapedSceneCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? code, String? details, String? director, List<String> urls, String? date, String? image, ScrapedEntity? studio, List<ScrapedEntity> tags, List<ScrapedEntity> performers
});


@override $ScrapedEntityCopyWith<$Res>? get studio;

}
/// @nodoc
class __$ScrapedSceneCopyWithImpl<$Res>
    implements _$ScrapedSceneCopyWith<$Res> {
  __$ScrapedSceneCopyWithImpl(this._self, this._then);

  final _ScrapedScene _self;
  final $Res Function(_ScrapedScene) _then;

/// Create a copy of ScrapedScene
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? code = freezed,Object? details = freezed,Object? director = freezed,Object? urls = null,Object? date = freezed,Object? image = freezed,Object? studio = freezed,Object? tags = null,Object? performers = null,}) {
  return _then(_ScrapedScene(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,director: freezed == director ? _self.director : director // ignore: cast_nullable_to_non_nullable
as String?,urls: null == urls ? _self._urls : urls // ignore: cast_nullable_to_non_nullable
as List<String>,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,studio: freezed == studio ? _self.studio : studio // ignore: cast_nullable_to_non_nullable
as ScrapedEntity?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<ScrapedEntity>,performers: null == performers ? _self._performers : performers // ignore: cast_nullable_to_non_nullable
as List<ScrapedEntity>,
  ));
}

/// Create a copy of ScrapedScene
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScrapedEntityCopyWith<$Res>? get studio {
    if (_self.studio == null) {
    return null;
  }

  return $ScrapedEntityCopyWith<$Res>(_self.studio!, (value) {
    return _then(_self.copyWith(studio: value));
  });
}
}


/// @nodoc
mixin _$ScrapedEntity {

@JsonKey(name: 'stored_id') String? get storedId; String get name;
/// Create a copy of ScrapedEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScrapedEntityCopyWith<ScrapedEntity> get copyWith => _$ScrapedEntityCopyWithImpl<ScrapedEntity>(this as ScrapedEntity, _$identity);

  /// Serializes this ScrapedEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScrapedEntity&&(identical(other.storedId, storedId) || other.storedId == storedId)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,storedId,name);

@override
String toString() {
  return 'ScrapedEntity(storedId: $storedId, name: $name)';
}


}

/// @nodoc
abstract mixin class $ScrapedEntityCopyWith<$Res>  {
  factory $ScrapedEntityCopyWith(ScrapedEntity value, $Res Function(ScrapedEntity) _then) = _$ScrapedEntityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'stored_id') String? storedId, String name
});




}
/// @nodoc
class _$ScrapedEntityCopyWithImpl<$Res>
    implements $ScrapedEntityCopyWith<$Res> {
  _$ScrapedEntityCopyWithImpl(this._self, this._then);

  final ScrapedEntity _self;
  final $Res Function(ScrapedEntity) _then;

/// Create a copy of ScrapedEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? storedId = freezed,Object? name = null,}) {
  return _then(_self.copyWith(
storedId: freezed == storedId ? _self.storedId : storedId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ScrapedEntity].
extension ScrapedEntityPatterns on ScrapedEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScrapedEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScrapedEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScrapedEntity value)  $default,){
final _that = this;
switch (_that) {
case _ScrapedEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScrapedEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ScrapedEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'stored_id')  String? storedId,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScrapedEntity() when $default != null:
return $default(_that.storedId,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'stored_id')  String? storedId,  String name)  $default,) {final _that = this;
switch (_that) {
case _ScrapedEntity():
return $default(_that.storedId,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'stored_id')  String? storedId,  String name)?  $default,) {final _that = this;
switch (_that) {
case _ScrapedEntity() when $default != null:
return $default(_that.storedId,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScrapedEntity implements ScrapedEntity {
  const _ScrapedEntity({@JsonKey(name: 'stored_id') this.storedId, required this.name});
  factory _ScrapedEntity.fromJson(Map<String, dynamic> json) => _$ScrapedEntityFromJson(json);

@override@JsonKey(name: 'stored_id') final  String? storedId;
@override final  String name;

/// Create a copy of ScrapedEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScrapedEntityCopyWith<_ScrapedEntity> get copyWith => __$ScrapedEntityCopyWithImpl<_ScrapedEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScrapedEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScrapedEntity&&(identical(other.storedId, storedId) || other.storedId == storedId)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,storedId,name);

@override
String toString() {
  return 'ScrapedEntity(storedId: $storedId, name: $name)';
}


}

/// @nodoc
abstract mixin class _$ScrapedEntityCopyWith<$Res> implements $ScrapedEntityCopyWith<$Res> {
  factory _$ScrapedEntityCopyWith(_ScrapedEntity value, $Res Function(_ScrapedEntity) _then) = __$ScrapedEntityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'stored_id') String? storedId, String name
});




}
/// @nodoc
class __$ScrapedEntityCopyWithImpl<$Res>
    implements _$ScrapedEntityCopyWith<$Res> {
  __$ScrapedEntityCopyWithImpl(this._self, this._then);

  final _ScrapedEntity _self;
  final $Res Function(_ScrapedEntity) _then;

/// Create a copy of ScrapedEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? storedId = freezed,Object? name = null,}) {
  return _then(_ScrapedEntity(
storedId: freezed == storedId ? _self.storedId : storedId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

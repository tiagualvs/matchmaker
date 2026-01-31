// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlayerEntity {

 int get id; String get name; PlayerGender get gender; PlayerLevel get level; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of PlayerEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerEntityCopyWith<PlayerEntity> get copyWith => _$PlayerEntityCopyWithImpl<PlayerEntity>(this as PlayerEntity, _$identity);

  /// Serializes this PlayerEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.level, level) || other.level == level)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,gender,level,createdAt,updatedAt);

@override
String toString() {
  return 'PlayerEntity(id: $id, name: $name, gender: $gender, level: $level, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PlayerEntityCopyWith<$Res>  {
  factory $PlayerEntityCopyWith(PlayerEntity value, $Res Function(PlayerEntity) _then) = _$PlayerEntityCopyWithImpl;
@useResult
$Res call({
 int id, String name, PlayerGender gender, PlayerLevel level, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$PlayerEntityCopyWithImpl<$Res>
    implements $PlayerEntityCopyWith<$Res> {
  _$PlayerEntityCopyWithImpl(this._self, this._then);

  final PlayerEntity _self;
  final $Res Function(PlayerEntity) _then;

/// Create a copy of PlayerEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? gender = null,Object? level = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as PlayerGender,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as PlayerLevel,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerEntity].
extension PlayerEntityPatterns on PlayerEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerEntity value)  $default,){
final _that = this;
switch (_that) {
case _PlayerEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  PlayerGender gender,  PlayerLevel level,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerEntity() when $default != null:
return $default(_that.id,_that.name,_that.gender,_that.level,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  PlayerGender gender,  PlayerLevel level,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PlayerEntity():
return $default(_that.id,_that.name,_that.gender,_that.level,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  PlayerGender gender,  PlayerLevel level,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PlayerEntity() when $default != null:
return $default(_that.id,_that.name,_that.gender,_that.level,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerEntity extends PlayerEntity {
  const _PlayerEntity({required this.id, required this.name, this.gender = PlayerGender.unknown, this.level = PlayerLevel.basic, required this.createdAt, required this.updatedAt}): super._();
  factory _PlayerEntity.fromJson(Map<String, dynamic> json) => _$PlayerEntityFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey() final  PlayerGender gender;
@override@JsonKey() final  PlayerLevel level;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of PlayerEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerEntityCopyWith<_PlayerEntity> get copyWith => __$PlayerEntityCopyWithImpl<_PlayerEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.level, level) || other.level == level)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,gender,level,createdAt,updatedAt);

@override
String toString() {
  return 'PlayerEntity(id: $id, name: $name, gender: $gender, level: $level, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PlayerEntityCopyWith<$Res> implements $PlayerEntityCopyWith<$Res> {
  factory _$PlayerEntityCopyWith(_PlayerEntity value, $Res Function(_PlayerEntity) _then) = __$PlayerEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, PlayerGender gender, PlayerLevel level, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$PlayerEntityCopyWithImpl<$Res>
    implements _$PlayerEntityCopyWith<$Res> {
  __$PlayerEntityCopyWithImpl(this._self, this._then);

  final _PlayerEntity _self;
  final $Res Function(_PlayerEntity) _then;

/// Create a copy of PlayerEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? gender = null,Object? level = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_PlayerEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as PlayerGender,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as PlayerLevel,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

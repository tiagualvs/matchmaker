// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'score_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScoreEntity {

 String get id;@JsonKey(name: 'match_id') String get matchId;@JsonKey(name: 'team_id') String get teamId; bool get reversed;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of ScoreEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoreEntityCopyWith<ScoreEntity> get copyWith => _$ScoreEntityCopyWithImpl<ScoreEntity>(this as ScoreEntity, _$identity);

  /// Serializes this ScoreEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoreEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.reversed, reversed) || other.reversed == reversed)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,matchId,teamId,reversed,createdAt,updatedAt);

@override
String toString() {
  return 'ScoreEntity(id: $id, matchId: $matchId, teamId: $teamId, reversed: $reversed, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ScoreEntityCopyWith<$Res>  {
  factory $ScoreEntityCopyWith(ScoreEntity value, $Res Function(ScoreEntity) _then) = _$ScoreEntityCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'match_id') String matchId,@JsonKey(name: 'team_id') String teamId, bool reversed,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$ScoreEntityCopyWithImpl<$Res>
    implements $ScoreEntityCopyWith<$Res> {
  _$ScoreEntityCopyWithImpl(this._self, this._then);

  final ScoreEntity _self;
  final $Res Function(ScoreEntity) _then;

/// Create a copy of ScoreEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? matchId = null,Object? teamId = null,Object? reversed = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,reversed: null == reversed ? _self.reversed : reversed // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ScoreEntity].
extension ScoreEntityPatterns on ScoreEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoreEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoreEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoreEntity value)  $default,){
final _that = this;
switch (_that) {
case _ScoreEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoreEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ScoreEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'match_id')  String matchId, @JsonKey(name: 'team_id')  String teamId,  bool reversed, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoreEntity() when $default != null:
return $default(_that.id,_that.matchId,_that.teamId,_that.reversed,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'match_id')  String matchId, @JsonKey(name: 'team_id')  String teamId,  bool reversed, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ScoreEntity():
return $default(_that.id,_that.matchId,_that.teamId,_that.reversed,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'match_id')  String matchId, @JsonKey(name: 'team_id')  String teamId,  bool reversed, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ScoreEntity() when $default != null:
return $default(_that.id,_that.matchId,_that.teamId,_that.reversed,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoreEntity extends ScoreEntity {
  const _ScoreEntity({required this.id, @JsonKey(name: 'match_id') required this.matchId, @JsonKey(name: 'team_id') required this.teamId, this.reversed = false, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt}): super._();
  factory _ScoreEntity.fromJson(Map<String, dynamic> json) => _$ScoreEntityFromJson(json);

@override final  String id;
@override@JsonKey(name: 'match_id') final  String matchId;
@override@JsonKey(name: 'team_id') final  String teamId;
@override@JsonKey() final  bool reversed;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of ScoreEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoreEntityCopyWith<_ScoreEntity> get copyWith => __$ScoreEntityCopyWithImpl<_ScoreEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoreEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoreEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.reversed, reversed) || other.reversed == reversed)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,matchId,teamId,reversed,createdAt,updatedAt);

@override
String toString() {
  return 'ScoreEntity(id: $id, matchId: $matchId, teamId: $teamId, reversed: $reversed, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ScoreEntityCopyWith<$Res> implements $ScoreEntityCopyWith<$Res> {
  factory _$ScoreEntityCopyWith(_ScoreEntity value, $Res Function(_ScoreEntity) _then) = __$ScoreEntityCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'match_id') String matchId,@JsonKey(name: 'team_id') String teamId, bool reversed,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$ScoreEntityCopyWithImpl<$Res>
    implements _$ScoreEntityCopyWith<$Res> {
  __$ScoreEntityCopyWithImpl(this._self, this._then);

  final _ScoreEntity _self;
  final $Res Function(_ScoreEntity) _then;

/// Create a copy of ScoreEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? matchId = null,Object? teamId = null,Object? reversed = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ScoreEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,reversed: null == reversed ? _self.reversed : reversed // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

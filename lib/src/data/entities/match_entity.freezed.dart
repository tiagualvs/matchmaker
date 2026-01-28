// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchEntity {

 int get id;@JsonKey(name: 'event_id') int get eventId; String get name;@JsonKey(name: 'first_team') TeamEntity get firstTeam;@JsonKey(name: 'second_team') TeamEntity get secondTeam; List<ScoreEntity> get scores;@JsonKey(name: 'max_score') int get maxScore;@JsonKey(name: 'half_score_to_eliminate') bool get halfScoreToEliminate; bool get ended;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;@JsonKey(name: 'ended_at') DateTime? get endedAt;
/// Create a copy of MatchEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchEntityCopyWith<MatchEntity> get copyWith => _$MatchEntityCopyWithImpl<MatchEntity>(this as MatchEntity, _$identity);

  /// Serializes this MatchEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.name, name) || other.name == name)&&(identical(other.firstTeam, firstTeam) || other.firstTeam == firstTeam)&&(identical(other.secondTeam, secondTeam) || other.secondTeam == secondTeam)&&const DeepCollectionEquality().equals(other.scores, scores)&&(identical(other.maxScore, maxScore) || other.maxScore == maxScore)&&(identical(other.halfScoreToEliminate, halfScoreToEliminate) || other.halfScoreToEliminate == halfScoreToEliminate)&&(identical(other.ended, ended) || other.ended == ended)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,name,firstTeam,secondTeam,const DeepCollectionEquality().hash(scores),maxScore,halfScoreToEliminate,ended,createdAt,updatedAt,endedAt);

@override
String toString() {
  return 'MatchEntity(id: $id, eventId: $eventId, name: $name, firstTeam: $firstTeam, secondTeam: $secondTeam, scores: $scores, maxScore: $maxScore, halfScoreToEliminate: $halfScoreToEliminate, ended: $ended, createdAt: $createdAt, updatedAt: $updatedAt, endedAt: $endedAt)';
}


}

/// @nodoc
abstract mixin class $MatchEntityCopyWith<$Res>  {
  factory $MatchEntityCopyWith(MatchEntity value, $Res Function(MatchEntity) _then) = _$MatchEntityCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'event_id') int eventId, String name,@JsonKey(name: 'first_team') TeamEntity firstTeam,@JsonKey(name: 'second_team') TeamEntity secondTeam, List<ScoreEntity> scores,@JsonKey(name: 'max_score') int maxScore,@JsonKey(name: 'half_score_to_eliminate') bool halfScoreToEliminate, bool ended,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(name: 'ended_at') DateTime? endedAt
});


$TeamEntityCopyWith<$Res> get firstTeam;$TeamEntityCopyWith<$Res> get secondTeam;

}
/// @nodoc
class _$MatchEntityCopyWithImpl<$Res>
    implements $MatchEntityCopyWith<$Res> {
  _$MatchEntityCopyWithImpl(this._self, this._then);

  final MatchEntity _self;
  final $Res Function(MatchEntity) _then;

/// Create a copy of MatchEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventId = null,Object? name = null,Object? firstTeam = null,Object? secondTeam = null,Object? scores = null,Object? maxScore = null,Object? halfScoreToEliminate = null,Object? ended = null,Object? createdAt = null,Object? updatedAt = null,Object? endedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,firstTeam: null == firstTeam ? _self.firstTeam : firstTeam // ignore: cast_nullable_to_non_nullable
as TeamEntity,secondTeam: null == secondTeam ? _self.secondTeam : secondTeam // ignore: cast_nullable_to_non_nullable
as TeamEntity,scores: null == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as List<ScoreEntity>,maxScore: null == maxScore ? _self.maxScore : maxScore // ignore: cast_nullable_to_non_nullable
as int,halfScoreToEliminate: null == halfScoreToEliminate ? _self.halfScoreToEliminate : halfScoreToEliminate // ignore: cast_nullable_to_non_nullable
as bool,ended: null == ended ? _self.ended : ended // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of MatchEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamEntityCopyWith<$Res> get firstTeam {
  
  return $TeamEntityCopyWith<$Res>(_self.firstTeam, (value) {
    return _then(_self.copyWith(firstTeam: value));
  });
}/// Create a copy of MatchEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamEntityCopyWith<$Res> get secondTeam {
  
  return $TeamEntityCopyWith<$Res>(_self.secondTeam, (value) {
    return _then(_self.copyWith(secondTeam: value));
  });
}
}


/// Adds pattern-matching-related methods to [MatchEntity].
extension MatchEntityPatterns on MatchEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchEntity value)  $default,){
final _that = this;
switch (_that) {
case _MatchEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MatchEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'event_id')  int eventId,  String name, @JsonKey(name: 'first_team')  TeamEntity firstTeam, @JsonKey(name: 'second_team')  TeamEntity secondTeam,  List<ScoreEntity> scores, @JsonKey(name: 'max_score')  int maxScore, @JsonKey(name: 'half_score_to_eliminate')  bool halfScoreToEliminate,  bool ended, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'ended_at')  DateTime? endedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchEntity() when $default != null:
return $default(_that.id,_that.eventId,_that.name,_that.firstTeam,_that.secondTeam,_that.scores,_that.maxScore,_that.halfScoreToEliminate,_that.ended,_that.createdAt,_that.updatedAt,_that.endedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'event_id')  int eventId,  String name, @JsonKey(name: 'first_team')  TeamEntity firstTeam, @JsonKey(name: 'second_team')  TeamEntity secondTeam,  List<ScoreEntity> scores, @JsonKey(name: 'max_score')  int maxScore, @JsonKey(name: 'half_score_to_eliminate')  bool halfScoreToEliminate,  bool ended, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'ended_at')  DateTime? endedAt)  $default,) {final _that = this;
switch (_that) {
case _MatchEntity():
return $default(_that.id,_that.eventId,_that.name,_that.firstTeam,_that.secondTeam,_that.scores,_that.maxScore,_that.halfScoreToEliminate,_that.ended,_that.createdAt,_that.updatedAt,_that.endedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'event_id')  int eventId,  String name, @JsonKey(name: 'first_team')  TeamEntity firstTeam, @JsonKey(name: 'second_team')  TeamEntity secondTeam,  List<ScoreEntity> scores, @JsonKey(name: 'max_score')  int maxScore, @JsonKey(name: 'half_score_to_eliminate')  bool halfScoreToEliminate,  bool ended, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'ended_at')  DateTime? endedAt)?  $default,) {final _that = this;
switch (_that) {
case _MatchEntity() when $default != null:
return $default(_that.id,_that.eventId,_that.name,_that.firstTeam,_that.secondTeam,_that.scores,_that.maxScore,_that.halfScoreToEliminate,_that.ended,_that.createdAt,_that.updatedAt,_that.endedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchEntity extends MatchEntity {
  const _MatchEntity({required this.id, @JsonKey(name: 'event_id') required this.eventId, required this.name, @JsonKey(name: 'first_team') required this.firstTeam, @JsonKey(name: 'second_team') required this.secondTeam, final  List<ScoreEntity> scores = const [], @JsonKey(name: 'max_score') required this.maxScore, @JsonKey(name: 'half_score_to_eliminate') required this.halfScoreToEliminate, this.ended = false, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, @JsonKey(name: 'ended_at') this.endedAt}): _scores = scores,super._();
  factory _MatchEntity.fromJson(Map<String, dynamic> json) => _$MatchEntityFromJson(json);

@override final  int id;
@override@JsonKey(name: 'event_id') final  int eventId;
@override final  String name;
@override@JsonKey(name: 'first_team') final  TeamEntity firstTeam;
@override@JsonKey(name: 'second_team') final  TeamEntity secondTeam;
 final  List<ScoreEntity> _scores;
@override@JsonKey() List<ScoreEntity> get scores {
  if (_scores is EqualUnmodifiableListView) return _scores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scores);
}

@override@JsonKey(name: 'max_score') final  int maxScore;
@override@JsonKey(name: 'half_score_to_eliminate') final  bool halfScoreToEliminate;
@override@JsonKey() final  bool ended;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;
@override@JsonKey(name: 'ended_at') final  DateTime? endedAt;

/// Create a copy of MatchEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchEntityCopyWith<_MatchEntity> get copyWith => __$MatchEntityCopyWithImpl<_MatchEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.name, name) || other.name == name)&&(identical(other.firstTeam, firstTeam) || other.firstTeam == firstTeam)&&(identical(other.secondTeam, secondTeam) || other.secondTeam == secondTeam)&&const DeepCollectionEquality().equals(other._scores, _scores)&&(identical(other.maxScore, maxScore) || other.maxScore == maxScore)&&(identical(other.halfScoreToEliminate, halfScoreToEliminate) || other.halfScoreToEliminate == halfScoreToEliminate)&&(identical(other.ended, ended) || other.ended == ended)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,name,firstTeam,secondTeam,const DeepCollectionEquality().hash(_scores),maxScore,halfScoreToEliminate,ended,createdAt,updatedAt,endedAt);

@override
String toString() {
  return 'MatchEntity(id: $id, eventId: $eventId, name: $name, firstTeam: $firstTeam, secondTeam: $secondTeam, scores: $scores, maxScore: $maxScore, halfScoreToEliminate: $halfScoreToEliminate, ended: $ended, createdAt: $createdAt, updatedAt: $updatedAt, endedAt: $endedAt)';
}


}

/// @nodoc
abstract mixin class _$MatchEntityCopyWith<$Res> implements $MatchEntityCopyWith<$Res> {
  factory _$MatchEntityCopyWith(_MatchEntity value, $Res Function(_MatchEntity) _then) = __$MatchEntityCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'event_id') int eventId, String name,@JsonKey(name: 'first_team') TeamEntity firstTeam,@JsonKey(name: 'second_team') TeamEntity secondTeam, List<ScoreEntity> scores,@JsonKey(name: 'max_score') int maxScore,@JsonKey(name: 'half_score_to_eliminate') bool halfScoreToEliminate, bool ended,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(name: 'ended_at') DateTime? endedAt
});


@override $TeamEntityCopyWith<$Res> get firstTeam;@override $TeamEntityCopyWith<$Res> get secondTeam;

}
/// @nodoc
class __$MatchEntityCopyWithImpl<$Res>
    implements _$MatchEntityCopyWith<$Res> {
  __$MatchEntityCopyWithImpl(this._self, this._then);

  final _MatchEntity _self;
  final $Res Function(_MatchEntity) _then;

/// Create a copy of MatchEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventId = null,Object? name = null,Object? firstTeam = null,Object? secondTeam = null,Object? scores = null,Object? maxScore = null,Object? halfScoreToEliminate = null,Object? ended = null,Object? createdAt = null,Object? updatedAt = null,Object? endedAt = freezed,}) {
  return _then(_MatchEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,firstTeam: null == firstTeam ? _self.firstTeam : firstTeam // ignore: cast_nullable_to_non_nullable
as TeamEntity,secondTeam: null == secondTeam ? _self.secondTeam : secondTeam // ignore: cast_nullable_to_non_nullable
as TeamEntity,scores: null == scores ? _self._scores : scores // ignore: cast_nullable_to_non_nullable
as List<ScoreEntity>,maxScore: null == maxScore ? _self.maxScore : maxScore // ignore: cast_nullable_to_non_nullable
as int,halfScoreToEliminate: null == halfScoreToEliminate ? _self.halfScoreToEliminate : halfScoreToEliminate // ignore: cast_nullable_to_non_nullable
as bool,ended: null == ended ? _self.ended : ended // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of MatchEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamEntityCopyWith<$Res> get firstTeam {
  
  return $TeamEntityCopyWith<$Res>(_self.firstTeam, (value) {
    return _then(_self.copyWith(firstTeam: value));
  });
}/// Create a copy of MatchEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamEntityCopyWith<$Res> get secondTeam {
  
  return $TeamEntityCopyWith<$Res>(_self.secondTeam, (value) {
    return _then(_self.copyWith(secondTeam: value));
  });
}
}

// dart format on

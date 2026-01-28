// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventEntity {

 int get id; String get name; List<TeamEntity> get teams; List<MatchEntity> get matches; List<int> get queue;@JsonKey(name: 'max_score') int get maxScore;@JsonKey(name: 'max_player_per_team') int get maxPlayerPerTeam;@JsonKey(name: 'balanced_by_gender') bool get balancedByGender;@JsonKey(name: 'balanced_by_level') bool get balancedByLevel;@JsonKey(name: 'max_wins_in_a_row') int get maxWinsInARow;@JsonKey(name: 'half_score_to_eliminate') bool get halfScoreToEliminate; bool get ended;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;@JsonKey(name: 'ended_at') DateTime? get endedAt;
/// Create a copy of EventEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventEntityCopyWith<EventEntity> get copyWith => _$EventEntityCopyWithImpl<EventEntity>(this as EventEntity, _$identity);

  /// Serializes this EventEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.teams, teams)&&const DeepCollectionEquality().equals(other.matches, matches)&&const DeepCollectionEquality().equals(other.queue, queue)&&(identical(other.maxScore, maxScore) || other.maxScore == maxScore)&&(identical(other.maxPlayerPerTeam, maxPlayerPerTeam) || other.maxPlayerPerTeam == maxPlayerPerTeam)&&(identical(other.balancedByGender, balancedByGender) || other.balancedByGender == balancedByGender)&&(identical(other.balancedByLevel, balancedByLevel) || other.balancedByLevel == balancedByLevel)&&(identical(other.maxWinsInARow, maxWinsInARow) || other.maxWinsInARow == maxWinsInARow)&&(identical(other.halfScoreToEliminate, halfScoreToEliminate) || other.halfScoreToEliminate == halfScoreToEliminate)&&(identical(other.ended, ended) || other.ended == ended)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(teams),const DeepCollectionEquality().hash(matches),const DeepCollectionEquality().hash(queue),maxScore,maxPlayerPerTeam,balancedByGender,balancedByLevel,maxWinsInARow,halfScoreToEliminate,ended,createdAt,updatedAt,endedAt);

@override
String toString() {
  return 'EventEntity(id: $id, name: $name, teams: $teams, matches: $matches, queue: $queue, maxScore: $maxScore, maxPlayerPerTeam: $maxPlayerPerTeam, balancedByGender: $balancedByGender, balancedByLevel: $balancedByLevel, maxWinsInARow: $maxWinsInARow, halfScoreToEliminate: $halfScoreToEliminate, ended: $ended, createdAt: $createdAt, updatedAt: $updatedAt, endedAt: $endedAt)';
}


}

/// @nodoc
abstract mixin class $EventEntityCopyWith<$Res>  {
  factory $EventEntityCopyWith(EventEntity value, $Res Function(EventEntity) _then) = _$EventEntityCopyWithImpl;
@useResult
$Res call({
 int id, String name, List<TeamEntity> teams, List<MatchEntity> matches, List<int> queue,@JsonKey(name: 'max_score') int maxScore,@JsonKey(name: 'max_player_per_team') int maxPlayerPerTeam,@JsonKey(name: 'balanced_by_gender') bool balancedByGender,@JsonKey(name: 'balanced_by_level') bool balancedByLevel,@JsonKey(name: 'max_wins_in_a_row') int maxWinsInARow,@JsonKey(name: 'half_score_to_eliminate') bool halfScoreToEliminate, bool ended,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(name: 'ended_at') DateTime? endedAt
});




}
/// @nodoc
class _$EventEntityCopyWithImpl<$Res>
    implements $EventEntityCopyWith<$Res> {
  _$EventEntityCopyWithImpl(this._self, this._then);

  final EventEntity _self;
  final $Res Function(EventEntity) _then;

/// Create a copy of EventEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? teams = null,Object? matches = null,Object? queue = null,Object? maxScore = null,Object? maxPlayerPerTeam = null,Object? balancedByGender = null,Object? balancedByLevel = null,Object? maxWinsInARow = null,Object? halfScoreToEliminate = null,Object? ended = null,Object? createdAt = null,Object? updatedAt = null,Object? endedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,teams: null == teams ? _self.teams : teams // ignore: cast_nullable_to_non_nullable
as List<TeamEntity>,matches: null == matches ? _self.matches : matches // ignore: cast_nullable_to_non_nullable
as List<MatchEntity>,queue: null == queue ? _self.queue : queue // ignore: cast_nullable_to_non_nullable
as List<int>,maxScore: null == maxScore ? _self.maxScore : maxScore // ignore: cast_nullable_to_non_nullable
as int,maxPlayerPerTeam: null == maxPlayerPerTeam ? _self.maxPlayerPerTeam : maxPlayerPerTeam // ignore: cast_nullable_to_non_nullable
as int,balancedByGender: null == balancedByGender ? _self.balancedByGender : balancedByGender // ignore: cast_nullable_to_non_nullable
as bool,balancedByLevel: null == balancedByLevel ? _self.balancedByLevel : balancedByLevel // ignore: cast_nullable_to_non_nullable
as bool,maxWinsInARow: null == maxWinsInARow ? _self.maxWinsInARow : maxWinsInARow // ignore: cast_nullable_to_non_nullable
as int,halfScoreToEliminate: null == halfScoreToEliminate ? _self.halfScoreToEliminate : halfScoreToEliminate // ignore: cast_nullable_to_non_nullable
as bool,ended: null == ended ? _self.ended : ended // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventEntity].
extension EventEntityPatterns on EventEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventEntity value)  $default,){
final _that = this;
switch (_that) {
case _EventEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventEntity value)?  $default,){
final _that = this;
switch (_that) {
case _EventEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  List<TeamEntity> teams,  List<MatchEntity> matches,  List<int> queue, @JsonKey(name: 'max_score')  int maxScore, @JsonKey(name: 'max_player_per_team')  int maxPlayerPerTeam, @JsonKey(name: 'balanced_by_gender')  bool balancedByGender, @JsonKey(name: 'balanced_by_level')  bool balancedByLevel, @JsonKey(name: 'max_wins_in_a_row')  int maxWinsInARow, @JsonKey(name: 'half_score_to_eliminate')  bool halfScoreToEliminate,  bool ended, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'ended_at')  DateTime? endedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventEntity() when $default != null:
return $default(_that.id,_that.name,_that.teams,_that.matches,_that.queue,_that.maxScore,_that.maxPlayerPerTeam,_that.balancedByGender,_that.balancedByLevel,_that.maxWinsInARow,_that.halfScoreToEliminate,_that.ended,_that.createdAt,_that.updatedAt,_that.endedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  List<TeamEntity> teams,  List<MatchEntity> matches,  List<int> queue, @JsonKey(name: 'max_score')  int maxScore, @JsonKey(name: 'max_player_per_team')  int maxPlayerPerTeam, @JsonKey(name: 'balanced_by_gender')  bool balancedByGender, @JsonKey(name: 'balanced_by_level')  bool balancedByLevel, @JsonKey(name: 'max_wins_in_a_row')  int maxWinsInARow, @JsonKey(name: 'half_score_to_eliminate')  bool halfScoreToEliminate,  bool ended, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'ended_at')  DateTime? endedAt)  $default,) {final _that = this;
switch (_that) {
case _EventEntity():
return $default(_that.id,_that.name,_that.teams,_that.matches,_that.queue,_that.maxScore,_that.maxPlayerPerTeam,_that.balancedByGender,_that.balancedByLevel,_that.maxWinsInARow,_that.halfScoreToEliminate,_that.ended,_that.createdAt,_that.updatedAt,_that.endedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  List<TeamEntity> teams,  List<MatchEntity> matches,  List<int> queue, @JsonKey(name: 'max_score')  int maxScore, @JsonKey(name: 'max_player_per_team')  int maxPlayerPerTeam, @JsonKey(name: 'balanced_by_gender')  bool balancedByGender, @JsonKey(name: 'balanced_by_level')  bool balancedByLevel, @JsonKey(name: 'max_wins_in_a_row')  int maxWinsInARow, @JsonKey(name: 'half_score_to_eliminate')  bool halfScoreToEliminate,  bool ended, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt, @JsonKey(name: 'ended_at')  DateTime? endedAt)?  $default,) {final _that = this;
switch (_that) {
case _EventEntity() when $default != null:
return $default(_that.id,_that.name,_that.teams,_that.matches,_that.queue,_that.maxScore,_that.maxPlayerPerTeam,_that.balancedByGender,_that.balancedByLevel,_that.maxWinsInARow,_that.halfScoreToEliminate,_that.ended,_that.createdAt,_that.updatedAt,_that.endedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventEntity extends EventEntity {
  const _EventEntity({required this.id, required this.name, final  List<TeamEntity> teams = const [], final  List<MatchEntity> matches = const [], final  List<int> queue = const [], @JsonKey(name: 'max_score') this.maxScore = 12, @JsonKey(name: 'max_player_per_team') this.maxPlayerPerTeam = 4, @JsonKey(name: 'balanced_by_gender') this.balancedByGender = true, @JsonKey(name: 'balanced_by_level') this.balancedByLevel = true, @JsonKey(name: 'max_wins_in_a_row') this.maxWinsInARow = 0, @JsonKey(name: 'half_score_to_eliminate') this.halfScoreToEliminate = false, this.ended = false, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, @JsonKey(name: 'ended_at') this.endedAt}): _teams = teams,_matches = matches,_queue = queue,super._();
  factory _EventEntity.fromJson(Map<String, dynamic> json) => _$EventEntityFromJson(json);

@override final  int id;
@override final  String name;
 final  List<TeamEntity> _teams;
@override@JsonKey() List<TeamEntity> get teams {
  if (_teams is EqualUnmodifiableListView) return _teams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_teams);
}

 final  List<MatchEntity> _matches;
@override@JsonKey() List<MatchEntity> get matches {
  if (_matches is EqualUnmodifiableListView) return _matches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matches);
}

 final  List<int> _queue;
@override@JsonKey() List<int> get queue {
  if (_queue is EqualUnmodifiableListView) return _queue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_queue);
}

@override@JsonKey(name: 'max_score') final  int maxScore;
@override@JsonKey(name: 'max_player_per_team') final  int maxPlayerPerTeam;
@override@JsonKey(name: 'balanced_by_gender') final  bool balancedByGender;
@override@JsonKey(name: 'balanced_by_level') final  bool balancedByLevel;
@override@JsonKey(name: 'max_wins_in_a_row') final  int maxWinsInARow;
@override@JsonKey(name: 'half_score_to_eliminate') final  bool halfScoreToEliminate;
@override@JsonKey() final  bool ended;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;
@override@JsonKey(name: 'ended_at') final  DateTime? endedAt;

/// Create a copy of EventEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventEntityCopyWith<_EventEntity> get copyWith => __$EventEntityCopyWithImpl<_EventEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._teams, _teams)&&const DeepCollectionEquality().equals(other._matches, _matches)&&const DeepCollectionEquality().equals(other._queue, _queue)&&(identical(other.maxScore, maxScore) || other.maxScore == maxScore)&&(identical(other.maxPlayerPerTeam, maxPlayerPerTeam) || other.maxPlayerPerTeam == maxPlayerPerTeam)&&(identical(other.balancedByGender, balancedByGender) || other.balancedByGender == balancedByGender)&&(identical(other.balancedByLevel, balancedByLevel) || other.balancedByLevel == balancedByLevel)&&(identical(other.maxWinsInARow, maxWinsInARow) || other.maxWinsInARow == maxWinsInARow)&&(identical(other.halfScoreToEliminate, halfScoreToEliminate) || other.halfScoreToEliminate == halfScoreToEliminate)&&(identical(other.ended, ended) || other.ended == ended)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_teams),const DeepCollectionEquality().hash(_matches),const DeepCollectionEquality().hash(_queue),maxScore,maxPlayerPerTeam,balancedByGender,balancedByLevel,maxWinsInARow,halfScoreToEliminate,ended,createdAt,updatedAt,endedAt);

@override
String toString() {
  return 'EventEntity(id: $id, name: $name, teams: $teams, matches: $matches, queue: $queue, maxScore: $maxScore, maxPlayerPerTeam: $maxPlayerPerTeam, balancedByGender: $balancedByGender, balancedByLevel: $balancedByLevel, maxWinsInARow: $maxWinsInARow, halfScoreToEliminate: $halfScoreToEliminate, ended: $ended, createdAt: $createdAt, updatedAt: $updatedAt, endedAt: $endedAt)';
}


}

/// @nodoc
abstract mixin class _$EventEntityCopyWith<$Res> implements $EventEntityCopyWith<$Res> {
  factory _$EventEntityCopyWith(_EventEntity value, $Res Function(_EventEntity) _then) = __$EventEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, List<TeamEntity> teams, List<MatchEntity> matches, List<int> queue,@JsonKey(name: 'max_score') int maxScore,@JsonKey(name: 'max_player_per_team') int maxPlayerPerTeam,@JsonKey(name: 'balanced_by_gender') bool balancedByGender,@JsonKey(name: 'balanced_by_level') bool balancedByLevel,@JsonKey(name: 'max_wins_in_a_row') int maxWinsInARow,@JsonKey(name: 'half_score_to_eliminate') bool halfScoreToEliminate, bool ended,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(name: 'ended_at') DateTime? endedAt
});




}
/// @nodoc
class __$EventEntityCopyWithImpl<$Res>
    implements _$EventEntityCopyWith<$Res> {
  __$EventEntityCopyWithImpl(this._self, this._then);

  final _EventEntity _self;
  final $Res Function(_EventEntity) _then;

/// Create a copy of EventEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? teams = null,Object? matches = null,Object? queue = null,Object? maxScore = null,Object? maxPlayerPerTeam = null,Object? balancedByGender = null,Object? balancedByLevel = null,Object? maxWinsInARow = null,Object? halfScoreToEliminate = null,Object? ended = null,Object? createdAt = null,Object? updatedAt = null,Object? endedAt = freezed,}) {
  return _then(_EventEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,teams: null == teams ? _self._teams : teams // ignore: cast_nullable_to_non_nullable
as List<TeamEntity>,matches: null == matches ? _self._matches : matches // ignore: cast_nullable_to_non_nullable
as List<MatchEntity>,queue: null == queue ? _self._queue : queue // ignore: cast_nullable_to_non_nullable
as List<int>,maxScore: null == maxScore ? _self.maxScore : maxScore // ignore: cast_nullable_to_non_nullable
as int,maxPlayerPerTeam: null == maxPlayerPerTeam ? _self.maxPlayerPerTeam : maxPlayerPerTeam // ignore: cast_nullable_to_non_nullable
as int,balancedByGender: null == balancedByGender ? _self.balancedByGender : balancedByGender // ignore: cast_nullable_to_non_nullable
as bool,balancedByLevel: null == balancedByLevel ? _self.balancedByLevel : balancedByLevel // ignore: cast_nullable_to_non_nullable
as bool,maxWinsInARow: null == maxWinsInARow ? _self.maxWinsInARow : maxWinsInARow // ignore: cast_nullable_to_non_nullable
as int,halfScoreToEliminate: null == halfScoreToEliminate ? _self.halfScoreToEliminate : halfScoreToEliminate // ignore: cast_nullable_to_non_nullable
as bool,ended: null == ended ? _self.ended : ended // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

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
PlayerGender _$PlayerGenderFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'male':
          return PlayerGenderMale.fromJson(
            json
          );
                case 'female':
          return PlayerGenderFemale.fromJson(
            json
          );
                case 'unknown':
          return PlayerGenderUnknown.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'PlayerGender',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$PlayerGender {

 String get value;
/// Create a copy of PlayerGender
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerGenderCopyWith<PlayerGender> get copyWith => _$PlayerGenderCopyWithImpl<PlayerGender>(this as PlayerGender, _$identity);

  /// Serializes this PlayerGender to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerGender&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'PlayerGender(value: $value)';
}


}

/// @nodoc
abstract mixin class $PlayerGenderCopyWith<$Res>  {
  factory $PlayerGenderCopyWith(PlayerGender value, $Res Function(PlayerGender) _then) = _$PlayerGenderCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$PlayerGenderCopyWithImpl<$Res>
    implements $PlayerGenderCopyWith<$Res> {
  _$PlayerGenderCopyWithImpl(this._self, this._then);

  final PlayerGender _self;
  final $Res Function(PlayerGender) _then;

/// Create a copy of PlayerGender
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerGender].
extension PlayerGenderPatterns on PlayerGender {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PlayerGenderMale value)?  male,TResult Function( PlayerGenderFemale value)?  female,TResult Function( PlayerGenderUnknown value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PlayerGenderMale() when male != null:
return male(_that);case PlayerGenderFemale() when female != null:
return female(_that);case PlayerGenderUnknown() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PlayerGenderMale value)  male,required TResult Function( PlayerGenderFemale value)  female,required TResult Function( PlayerGenderUnknown value)  unknown,}){
final _that = this;
switch (_that) {
case PlayerGenderMale():
return male(_that);case PlayerGenderFemale():
return female(_that);case PlayerGenderUnknown():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PlayerGenderMale value)?  male,TResult? Function( PlayerGenderFemale value)?  female,TResult? Function( PlayerGenderUnknown value)?  unknown,}){
final _that = this;
switch (_that) {
case PlayerGenderMale() when male != null:
return male(_that);case PlayerGenderFemale() when female != null:
return female(_that);case PlayerGenderUnknown() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String value)?  male,TResult Function( String value)?  female,TResult Function( String value)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PlayerGenderMale() when male != null:
return male(_that.value);case PlayerGenderFemale() when female != null:
return female(_that.value);case PlayerGenderUnknown() when unknown != null:
return unknown(_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String value)  male,required TResult Function( String value)  female,required TResult Function( String value)  unknown,}) {final _that = this;
switch (_that) {
case PlayerGenderMale():
return male(_that.value);case PlayerGenderFemale():
return female(_that.value);case PlayerGenderUnknown():
return unknown(_that.value);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String value)?  male,TResult? Function( String value)?  female,TResult? Function( String value)?  unknown,}) {final _that = this;
switch (_that) {
case PlayerGenderMale() when male != null:
return male(_that.value);case PlayerGenderFemale() when female != null:
return female(_that.value);case PlayerGenderUnknown() when unknown != null:
return unknown(_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class PlayerGenderMale extends PlayerGender {
  const PlayerGenderMale({this.value = 'male', final  String? $type}): $type = $type ?? 'male',super._();
  factory PlayerGenderMale.fromJson(Map<String, dynamic> json) => _$PlayerGenderMaleFromJson(json);

@override@JsonKey() final  String value;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of PlayerGender
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerGenderMaleCopyWith<PlayerGenderMale> get copyWith => _$PlayerGenderMaleCopyWithImpl<PlayerGenderMale>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerGenderMaleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerGenderMale&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'PlayerGender.male(value: $value)';
}


}

/// @nodoc
abstract mixin class $PlayerGenderMaleCopyWith<$Res> implements $PlayerGenderCopyWith<$Res> {
  factory $PlayerGenderMaleCopyWith(PlayerGenderMale value, $Res Function(PlayerGenderMale) _then) = _$PlayerGenderMaleCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class _$PlayerGenderMaleCopyWithImpl<$Res>
    implements $PlayerGenderMaleCopyWith<$Res> {
  _$PlayerGenderMaleCopyWithImpl(this._self, this._then);

  final PlayerGenderMale _self;
  final $Res Function(PlayerGenderMale) _then;

/// Create a copy of PlayerGender
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(PlayerGenderMale(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PlayerGenderFemale extends PlayerGender {
  const PlayerGenderFemale({this.value = 'female', final  String? $type}): $type = $type ?? 'female',super._();
  factory PlayerGenderFemale.fromJson(Map<String, dynamic> json) => _$PlayerGenderFemaleFromJson(json);

@override@JsonKey() final  String value;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of PlayerGender
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerGenderFemaleCopyWith<PlayerGenderFemale> get copyWith => _$PlayerGenderFemaleCopyWithImpl<PlayerGenderFemale>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerGenderFemaleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerGenderFemale&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'PlayerGender.female(value: $value)';
}


}

/// @nodoc
abstract mixin class $PlayerGenderFemaleCopyWith<$Res> implements $PlayerGenderCopyWith<$Res> {
  factory $PlayerGenderFemaleCopyWith(PlayerGenderFemale value, $Res Function(PlayerGenderFemale) _then) = _$PlayerGenderFemaleCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class _$PlayerGenderFemaleCopyWithImpl<$Res>
    implements $PlayerGenderFemaleCopyWith<$Res> {
  _$PlayerGenderFemaleCopyWithImpl(this._self, this._then);

  final PlayerGenderFemale _self;
  final $Res Function(PlayerGenderFemale) _then;

/// Create a copy of PlayerGender
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(PlayerGenderFemale(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PlayerGenderUnknown extends PlayerGender {
  const PlayerGenderUnknown({this.value = 'unknown', final  String? $type}): $type = $type ?? 'unknown',super._();
  factory PlayerGenderUnknown.fromJson(Map<String, dynamic> json) => _$PlayerGenderUnknownFromJson(json);

@override@JsonKey() final  String value;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of PlayerGender
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerGenderUnknownCopyWith<PlayerGenderUnknown> get copyWith => _$PlayerGenderUnknownCopyWithImpl<PlayerGenderUnknown>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerGenderUnknownToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerGenderUnknown&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'PlayerGender.unknown(value: $value)';
}


}

/// @nodoc
abstract mixin class $PlayerGenderUnknownCopyWith<$Res> implements $PlayerGenderCopyWith<$Res> {
  factory $PlayerGenderUnknownCopyWith(PlayerGenderUnknown value, $Res Function(PlayerGenderUnknown) _then) = _$PlayerGenderUnknownCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class _$PlayerGenderUnknownCopyWithImpl<$Res>
    implements $PlayerGenderUnknownCopyWith<$Res> {
  _$PlayerGenderUnknownCopyWithImpl(this._self, this._then);

  final PlayerGenderUnknown _self;
  final $Res Function(PlayerGenderUnknown) _then;

/// Create a copy of PlayerGender
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(PlayerGenderUnknown(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

PlayerLevel _$PlayerLevelFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'basic':
          return _Basic.fromJson(
            json
          );
                case 'intermediate':
          return _Intermediate.fromJson(
            json
          );
                case 'advanced':
          return _Advanced.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'PlayerLevel',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$PlayerLevel {

 String get value;
/// Create a copy of PlayerLevel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerLevelCopyWith<PlayerLevel> get copyWith => _$PlayerLevelCopyWithImpl<PlayerLevel>(this as PlayerLevel, _$identity);

  /// Serializes this PlayerLevel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerLevel&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'PlayerLevel(value: $value)';
}


}

/// @nodoc
abstract mixin class $PlayerLevelCopyWith<$Res>  {
  factory $PlayerLevelCopyWith(PlayerLevel value, $Res Function(PlayerLevel) _then) = _$PlayerLevelCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$PlayerLevelCopyWithImpl<$Res>
    implements $PlayerLevelCopyWith<$Res> {
  _$PlayerLevelCopyWithImpl(this._self, this._then);

  final PlayerLevel _self;
  final $Res Function(PlayerLevel) _then;

/// Create a copy of PlayerLevel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerLevel].
extension PlayerLevelPatterns on PlayerLevel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Basic value)?  basic,TResult Function( _Intermediate value)?  intermediate,TResult Function( _Advanced value)?  advanced,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Basic() when basic != null:
return basic(_that);case _Intermediate() when intermediate != null:
return intermediate(_that);case _Advanced() when advanced != null:
return advanced(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Basic value)  basic,required TResult Function( _Intermediate value)  intermediate,required TResult Function( _Advanced value)  advanced,}){
final _that = this;
switch (_that) {
case _Basic():
return basic(_that);case _Intermediate():
return intermediate(_that);case _Advanced():
return advanced(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Basic value)?  basic,TResult? Function( _Intermediate value)?  intermediate,TResult? Function( _Advanced value)?  advanced,}){
final _that = this;
switch (_that) {
case _Basic() when basic != null:
return basic(_that);case _Intermediate() when intermediate != null:
return intermediate(_that);case _Advanced() when advanced != null:
return advanced(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String value)?  basic,TResult Function( String value)?  intermediate,TResult Function( String value)?  advanced,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Basic() when basic != null:
return basic(_that.value);case _Intermediate() when intermediate != null:
return intermediate(_that.value);case _Advanced() when advanced != null:
return advanced(_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String value)  basic,required TResult Function( String value)  intermediate,required TResult Function( String value)  advanced,}) {final _that = this;
switch (_that) {
case _Basic():
return basic(_that.value);case _Intermediate():
return intermediate(_that.value);case _Advanced():
return advanced(_that.value);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String value)?  basic,TResult? Function( String value)?  intermediate,TResult? Function( String value)?  advanced,}) {final _that = this;
switch (_that) {
case _Basic() when basic != null:
return basic(_that.value);case _Intermediate() when intermediate != null:
return intermediate(_that.value);case _Advanced() when advanced != null:
return advanced(_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Basic extends PlayerLevel {
  const _Basic({this.value = 'basic', final  String? $type}): $type = $type ?? 'basic',super._();
  factory _Basic.fromJson(Map<String, dynamic> json) => _$BasicFromJson(json);

@override@JsonKey() final  String value;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of PlayerLevel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BasicCopyWith<_Basic> get copyWith => __$BasicCopyWithImpl<_Basic>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BasicToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Basic&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'PlayerLevel.basic(value: $value)';
}


}

/// @nodoc
abstract mixin class _$BasicCopyWith<$Res> implements $PlayerLevelCopyWith<$Res> {
  factory _$BasicCopyWith(_Basic value, $Res Function(_Basic) _then) = __$BasicCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class __$BasicCopyWithImpl<$Res>
    implements _$BasicCopyWith<$Res> {
  __$BasicCopyWithImpl(this._self, this._then);

  final _Basic _self;
  final $Res Function(_Basic) _then;

/// Create a copy of PlayerLevel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_Basic(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _Intermediate extends PlayerLevel {
  const _Intermediate({this.value = 'intermediate', final  String? $type}): $type = $type ?? 'intermediate',super._();
  factory _Intermediate.fromJson(Map<String, dynamic> json) => _$IntermediateFromJson(json);

@override@JsonKey() final  String value;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of PlayerLevel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntermediateCopyWith<_Intermediate> get copyWith => __$IntermediateCopyWithImpl<_Intermediate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntermediateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Intermediate&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'PlayerLevel.intermediate(value: $value)';
}


}

/// @nodoc
abstract mixin class _$IntermediateCopyWith<$Res> implements $PlayerLevelCopyWith<$Res> {
  factory _$IntermediateCopyWith(_Intermediate value, $Res Function(_Intermediate) _then) = __$IntermediateCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class __$IntermediateCopyWithImpl<$Res>
    implements _$IntermediateCopyWith<$Res> {
  __$IntermediateCopyWithImpl(this._self, this._then);

  final _Intermediate _self;
  final $Res Function(_Intermediate) _then;

/// Create a copy of PlayerLevel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_Intermediate(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _Advanced extends PlayerLevel {
  const _Advanced({this.value = 'advanced', final  String? $type}): $type = $type ?? 'advanced',super._();
  factory _Advanced.fromJson(Map<String, dynamic> json) => _$AdvancedFromJson(json);

@override@JsonKey() final  String value;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of PlayerLevel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdvancedCopyWith<_Advanced> get copyWith => __$AdvancedCopyWithImpl<_Advanced>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdvancedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Advanced&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'PlayerLevel.advanced(value: $value)';
}


}

/// @nodoc
abstract mixin class _$AdvancedCopyWith<$Res> implements $PlayerLevelCopyWith<$Res> {
  factory _$AdvancedCopyWith(_Advanced value, $Res Function(_Advanced) _then) = __$AdvancedCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class __$AdvancedCopyWithImpl<$Res>
    implements _$AdvancedCopyWith<$Res> {
  __$AdvancedCopyWithImpl(this._self, this._then);

  final _Advanced _self;
  final $Res Function(_Advanced) _then;

/// Create a copy of PlayerLevel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_Advanced(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PlayerEntity {

 String get id; String get name; PlayerGender get gender; PlayerLevel get level;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;
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
 String id, String name, PlayerGender gender, PlayerLevel level,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});


$PlayerGenderCopyWith<$Res> get gender;$PlayerLevelCopyWith<$Res> get level;

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
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as PlayerGender,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as PlayerLevel,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of PlayerEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerGenderCopyWith<$Res> get gender {
  
  return $PlayerGenderCopyWith<$Res>(_self.gender, (value) {
    return _then(_self.copyWith(gender: value));
  });
}/// Create a copy of PlayerEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerLevelCopyWith<$Res> get level {
  
  return $PlayerLevelCopyWith<$Res>(_self.level, (value) {
    return _then(_self.copyWith(level: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  PlayerGender gender,  PlayerLevel level, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  PlayerGender gender,  PlayerLevel level, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  PlayerGender gender,  PlayerLevel level, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
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
  const _PlayerEntity({required this.id, required this.name, required this.gender, this.level = const PlayerLevel.basic(), @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt}): super._();
  factory _PlayerEntity.fromJson(Map<String, dynamic> json) => _$PlayerEntityFromJson(json);

@override final  String id;
@override final  String name;
@override final  PlayerGender gender;
@override@JsonKey() final  PlayerLevel level;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

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
 String id, String name, PlayerGender gender, PlayerLevel level,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});


@override $PlayerGenderCopyWith<$Res> get gender;@override $PlayerLevelCopyWith<$Res> get level;

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
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as PlayerGender,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as PlayerLevel,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of PlayerEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerGenderCopyWith<$Res> get gender {
  
  return $PlayerGenderCopyWith<$Res>(_self.gender, (value) {
    return _then(_self.copyWith(gender: value));
  });
}/// Create a copy of PlayerEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerLevelCopyWith<$Res> get level {
  
  return $PlayerLevelCopyWith<$Res>(_self.level, (value) {
    return _then(_self.copyWith(level: value));
  });
}
}

// dart format on

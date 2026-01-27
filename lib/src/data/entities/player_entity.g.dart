// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerGenderMale _$PlayerGenderMaleFromJson(Map<String, dynamic> json) =>
    PlayerGenderMale(
      value: json['value'] as String? ?? 'male',
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$PlayerGenderMaleToJson(PlayerGenderMale instance) =>
    <String, dynamic>{'value': instance.value, 'runtimeType': instance.$type};

PlayerGenderFemale _$PlayerGenderFemaleFromJson(Map<String, dynamic> json) =>
    PlayerGenderFemale(
      value: json['value'] as String? ?? 'female',
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$PlayerGenderFemaleToJson(PlayerGenderFemale instance) =>
    <String, dynamic>{'value': instance.value, 'runtimeType': instance.$type};

PlayerGenderUnknown _$PlayerGenderUnknownFromJson(Map<String, dynamic> json) =>
    PlayerGenderUnknown(
      value: json['value'] as String? ?? 'unknown',
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$PlayerGenderUnknownToJson(
  PlayerGenderUnknown instance,
) => <String, dynamic>{'value': instance.value, 'runtimeType': instance.$type};

_Basic _$BasicFromJson(Map<String, dynamic> json) => _Basic(
  value: json['value'] as String? ?? 'basic',
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$BasicToJson(_Basic instance) => <String, dynamic>{
  'value': instance.value,
  'runtimeType': instance.$type,
};

_Intermediate _$IntermediateFromJson(Map<String, dynamic> json) =>
    _Intermediate(
      value: json['value'] as String? ?? 'intermediate',
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$IntermediateToJson(_Intermediate instance) =>
    <String, dynamic>{'value': instance.value, 'runtimeType': instance.$type};

_Advanced _$AdvancedFromJson(Map<String, dynamic> json) => _Advanced(
  value: json['value'] as String? ?? 'advanced',
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$AdvancedToJson(_Advanced instance) => <String, dynamic>{
  'value': instance.value,
  'runtimeType': instance.$type,
};

_PlayerEntity _$PlayerEntityFromJson(Map<String, dynamic> json) =>
    _PlayerEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      gender: PlayerGender.fromJson(json['gender'] as Map<String, dynamic>),
      level: json['level'] == null
          ? const PlayerLevel.basic()
          : PlayerLevel.fromJson(json['level'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$PlayerEntityToJson(_PlayerEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'gender': instance.gender,
      'level': instance.level,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

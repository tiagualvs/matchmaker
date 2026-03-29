// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayerEntity _$PlayerEntityFromJson(Map<String, dynamic> json) =>
    _PlayerEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      gender:
          $enumDecodeNullable(_$PlayerGenderEnumMap, json['gender']) ??
          PlayerGender.unknown,
      level:
          $enumDecodeNullable(_$PlayerLevelEnumMap, json['level']) ??
          PlayerLevel.basic,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PlayerEntityToJson(_PlayerEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'gender': _$PlayerGenderEnumMap[instance.gender]!,
      'level': _$PlayerLevelEnumMap[instance.level]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$PlayerGenderEnumMap = {
  PlayerGender.male: 'male',
  PlayerGender.female: 'female',
  PlayerGender.unknown: 'unknown',
};

const _$PlayerLevelEnumMap = {
  PlayerLevel.basic: 'basic',
  PlayerLevel.intermediate: 'intermediate',
  PlayerLevel.advanced: 'advanced',
};

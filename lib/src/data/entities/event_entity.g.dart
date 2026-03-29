// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventEntity _$EventEntityFromJson(Map<String, dynamic> json) => _EventEntity(
  id: json['id'] as String,
  name: json['name'] as String,
  teams:
      (json['teams'] as List<dynamic>?)
          ?.map((e) => TeamEntity.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  matches:
      (json['matches'] as List<dynamic>?)
          ?.map((e) => MatchEntity.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  queue:
      (json['queue'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  maxScore: (json['maxScore'] as num?)?.toInt() ?? 12,
  maxPlayerPerTeam: (json['maxPlayerPerTeam'] as num?)?.toInt() ?? 4,
  balancedByGender: json['balancedByGender'] as bool? ?? true,
  balancedByLevel: json['balancedByLevel'] as bool? ?? true,
  maxWinsInARow: (json['maxWinsInARow'] as num?)?.toInt() ?? 0,
  halfScoreToEliminate: json['halfScoreToEliminate'] as bool? ?? false,
  ended: json['ended'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  endedAt: json['endedAt'] == null
      ? null
      : DateTime.parse(json['endedAt'] as String),
);

Map<String, dynamic> _$EventEntityToJson(_EventEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'teams': instance.teams,
      'matches': instance.matches,
      'queue': instance.queue,
      'maxScore': instance.maxScore,
      'maxPlayerPerTeam': instance.maxPlayerPerTeam,
      'balancedByGender': instance.balancedByGender,
      'balancedByLevel': instance.balancedByLevel,
      'maxWinsInARow': instance.maxWinsInARow,
      'halfScoreToEliminate': instance.halfScoreToEliminate,
      'ended': instance.ended,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
    };

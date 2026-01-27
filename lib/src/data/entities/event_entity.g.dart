// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventEntity _$EventEntityFromJson(Map<String, dynamic> json) => _EventEntity(
  id: (json['id'] as num).toInt(),
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
      (json['queue'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  maxScore: (json['max_score'] as num?)?.toInt() ?? 12,
  maxPlayerPerTeam: (json['max_player_per_team'] as num?)?.toInt() ?? 4,
  ended: json['ended'] as bool? ?? false,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  endedAt: json['ended_at'] == null
      ? null
      : DateTime.parse(json['ended_at'] as String),
);

Map<String, dynamic> _$EventEntityToJson(_EventEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'teams': instance.teams,
      'matches': instance.matches,
      'queue': instance.queue,
      'max_score': instance.maxScore,
      'max_player_per_team': instance.maxPlayerPerTeam,
      'ended': instance.ended,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'ended_at': instance.endedAt?.toIso8601String(),
    };

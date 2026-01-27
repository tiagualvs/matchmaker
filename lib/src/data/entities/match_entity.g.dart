// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchEntity _$MatchEntityFromJson(Map<String, dynamic> json) => _MatchEntity(
  id: (json['id'] as num).toInt(),
  eventId: (json['event_id'] as num).toInt(),
  name: json['name'] as String,
  firstTeam: TeamEntity.fromJson(json['first_team'] as Map<String, dynamic>),
  secondTeam: TeamEntity.fromJson(json['second_team'] as Map<String, dynamic>),
  scores:
      (json['scores'] as List<dynamic>?)
          ?.map((e) => ScoreEntity.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  maxScore: (json['max_score'] as num).toInt(),
  ended: json['ended'] as bool? ?? false,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  endedAt: json['ended_at'] == null
      ? null
      : DateTime.parse(json['ended_at'] as String),
);

Map<String, dynamic> _$MatchEntityToJson(_MatchEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'name': instance.name,
      'first_team': instance.firstTeam,
      'second_team': instance.secondTeam,
      'scores': instance.scores,
      'max_score': instance.maxScore,
      'ended': instance.ended,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'ended_at': instance.endedAt?.toIso8601String(),
    };

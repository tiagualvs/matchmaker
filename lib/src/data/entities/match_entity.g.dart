// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchEntity _$MatchEntityFromJson(Map<String, dynamic> json) => _MatchEntity(
  id: json['id'] as String,
  eventId: json['eventId'] as String,
  name: json['name'] as String,
  firstTeam: TeamEntity.fromJson(json['firstTeam'] as Map<String, dynamic>),
  secondTeam: TeamEntity.fromJson(json['secondTeam'] as Map<String, dynamic>),
  scores:
      (json['scores'] as List<dynamic>?)
          ?.map((e) => ScoreEntity.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  maxScore: (json['maxScore'] as num).toInt(),
  halfScoreToEliminate: json['halfScoreToEliminate'] as bool,
  ended: json['ended'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  endedAt: json['endedAt'] == null
      ? null
      : DateTime.parse(json['endedAt'] as String),
);

Map<String, dynamic> _$MatchEntityToJson(_MatchEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'name': instance.name,
      'firstTeam': instance.firstTeam,
      'secondTeam': instance.secondTeam,
      'scores': instance.scores,
      'maxScore': instance.maxScore,
      'halfScoreToEliminate': instance.halfScoreToEliminate,
      'ended': instance.ended,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
    };

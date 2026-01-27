// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScoreEntity _$ScoreEntityFromJson(Map<String, dynamic> json) => _ScoreEntity(
  id: (json['id'] as num).toInt(),
  matchId: (json['match_id'] as num).toInt(),
  teamId: (json['team_id'] as num).toInt(),
  reversed: json['reversed'] as bool? ?? false,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$ScoreEntityToJson(_ScoreEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'match_id': instance.matchId,
      'team_id': instance.teamId,
      'reversed': instance.reversed,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

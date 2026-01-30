// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScoreEntity _$ScoreEntityFromJson(Map<String, dynamic> json) => _ScoreEntity(
  id: (json['id'] as num).toInt(),
  matchId: (json['matchId'] as num).toInt(),
  teamId: (json['teamId'] as num).toInt(),
  reversed: json['reversed'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ScoreEntityToJson(_ScoreEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'matchId': instance.matchId,
      'teamId': instance.teamId,
      'reversed': instance.reversed,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

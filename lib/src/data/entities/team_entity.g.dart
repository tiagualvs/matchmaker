// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TeamEntity _$TeamEntityFromJson(Map<String, dynamic> json) => _TeamEntity(
  id: (json['id'] as num).toInt(),
  eventId: (json['event_id'] as num).toInt(),
  name: json['name'] as String,
  players: (json['players'] as List<dynamic>)
      .map((e) => PlayerEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$TeamEntityToJson(_TeamEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'name': instance.name,
      'players': instance.players,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

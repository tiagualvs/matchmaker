// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TeamEntity _$TeamEntityFromJson(Map<String, dynamic> json) => _TeamEntity(
  id: json['id'] as String,
  eventId: json['eventId'] as String,
  name: json['name'] as String,
  players: (json['players'] as List<dynamic>)
      .map((e) => PlayerEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$TeamEntityToJson(_TeamEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'name': instance.name,
      'players': instance.players,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

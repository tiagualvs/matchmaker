import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/services/database/database.dart';

part 'team_entity.freezed.dart';
part 'team_entity.g.dart';

@freezed
abstract class TeamEntity with _$TeamEntity {
  const TeamEntity._();

  const factory TeamEntity({
    required int id,
    required int eventId,
    required String name,
    required List<PlayerEntity> players,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _TeamEntity;

  factory TeamEntity.fromJson(Map<String, dynamic> json) => _$TeamEntityFromJson(json);

  static const List<String> names = <String>[
    'Aperreados',
    'Arrochados',
    'Bonequeiros',
    'Cabras da Peste',
    'Cangaceiros',
    'Desmantelados',
    'Esfomeados',
    'Fuleragens',
    'Fubangas',
    'Gaiatos',
    'Marmotas',
    'Miseráveis',
    'Ruma de Doido',
    'Aí Dento 🫳',
  ];

  factory TeamEntity.fromDrift(TeamData data) {
    return TeamEntity(
      id: data.id,
      eventId: data.eventId,
      name: data.name,
      players: [],
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  factory TeamEntity.withPlayers(TeamWithPlayer data) {
    return TeamEntity(
      id: data.id,
      eventId: data.eventId,
      name: data.name,
      players: List.from(
        (json.decode(data.players) as List).map(
          (player) => PlayerEntity(
            id: player['id'],
            name: player['name'],
            gender: PlayerGender.fromValue(player['gender']),
            level: PlayerLevel.fromValue(player['level']),
            createdAt: DateTime.parse(player['createdAt']).toLocal(),
            updatedAt: DateTime.parse(player['updatedAt']).toLocal(),
          ),
        ),
      ),
      createdAt: DateTime.parse(data.createdAt).toLocal(),
      updatedAt: DateTime.parse(data.updatedAt).toLocal(),
    );
  }

  factory TeamEntity.empty(String name) {
    return TeamEntity(
      id: -1,
      eventId: -1,
      name: name,
      players: [],
      createdAt: DateTime(0),
      updatedAt: DateTime(0),
    );
  }
}

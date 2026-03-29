import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matchmaker/src/common/shared/id.dart';
import 'package:matchmaker/src/common/shared/timestamp.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';

part 'team_entity.freezed.dart';
part 'team_entity.g.dart';

@freezed
abstract class TeamEntity with _$TeamEntity {
  const TeamEntity._();

  const factory TeamEntity({
    required String id,
    required String eventId,
    required String name,
    required List<PlayerEntity> players,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _TeamEntity;

  factory TeamEntity.fromJson(Map<String, dynamic> json) =>
      _$TeamEntityFromJson(json);

  factory TeamEntity.create({
    required String eventId,
    required String name,
    required List<PlayerEntity> players,
  }) {
    return TeamEntity(
      id: Id.generate(),
      eventId: eventId,
      name: name,
      players: players,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );
  }

  factory TeamEntity.empty(String name) {
    return TeamEntity(
      id: Id.min(),
      eventId: Id.min(),
      name: name,
      players: [],
      createdAt: Timestamp.min(),
      updatedAt: Timestamp.min(),
    );
  }

  bool get isEmpty => id == Id.min();

  bool get isNotEmpty => !isEmpty;

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
  ];

  String get playersNames {
    return players.map((player) => player.name).join(', ');
  }
}

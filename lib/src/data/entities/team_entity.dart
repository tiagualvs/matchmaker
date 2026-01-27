import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:uuid/v7.dart';

part 'team_entity.freezed.dart';
part 'team_entity.g.dart';

@freezed
abstract class TeamEntity with _$TeamEntity {
  const TeamEntity._();

  const factory TeamEntity({
    required String id,
    @JsonKey(name: 'event_id') required String eventId,
    required String name,
    required List<PlayerEntity> players,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _TeamEntity;

  factory TeamEntity.fromJson(Map<String, dynamic> json) => _$TeamEntityFromJson(json);

  factory TeamEntity.fromSqlite(Row row) {
    return TeamEntity(
      id: row['id'] as String,
      eventId: row['event_id'] as String,
      name: row['name'] as String,
      players: [],
      createdAt: DateTime.parse(row['created_at'] as String),
      updatedAt: DateTime.parse(row['updated_at'] as String),
    );
  }

  factory TeamEntity.empty() {
    return TeamEntity(
      id: '',
      eventId: '',
      name: '',
      players: [],
      createdAt: DateTime(0),
      updatedAt: DateTime(0),
    );
  }

  String get storageKey => 'team_$id';

  factory TeamEntity.create(String eventId, [int? index]) {
    return TeamEntity(
      id: const UuidV7().generate(),
      eventId: eventId,
      name: index != null ? 'Time ${index + 1}' : '',
      players: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

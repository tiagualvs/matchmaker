import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:uuid/v7.dart';

part 'event_entity.freezed.dart';
part 'event_entity.g.dart';

@freezed
abstract class EventEntity with _$EventEntity {
  const EventEntity._();

  const factory EventEntity({
    required String id,
    required String name,
    @Default([]) List<TeamEntity> teams,
    @Default([]) List<MatchEntity> matches,
    @Default([]) List<String> queue,
    @JsonKey(name: 'max_score') @Default(12) int maxScore,
    @JsonKey(name: 'max_player_per_team') @Default(4) int maxPlayerPerTeam,
    @Default(false) bool ended,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'ended_at') DateTime? endedAt,
  }) = _EventEntity;

  factory EventEntity.fromJson(Map<String, dynamic> json) => _$EventEntityFromJson(json);

  factory EventEntity.fromSqlite(Row row) {
    return EventEntity(
      id: row['id'] as String,
      name: row['name'] as String,
      maxScore: row['max_score'] as int,
      maxPlayerPerTeam: row['max_player_per_team'] as int,
      ended: row['ended'] == 1,
      createdAt: DateTime.parse(row['created_at'] as String),
      updatedAt: DateTime.parse(row['updated_at'] as String),
      endedAt: row['ended_at'] != null ? DateTime.parse(row['ended_at'] as String) : null,
    );
  }

  String get storageKey => 'event_$id';

  bool get isEmpty => id.isEmpty;

  bool get isNotEmpty => !isEmpty;

  factory EventEntity.empty() {
    return EventEntity(
      id: '',
      name: '',
      createdAt: DateTime(0),
      updatedAt: DateTime(0),
    );
  }

  factory EventEntity.create() {
    final now = DateTime.now();

    return EventEntity(
      id: const UuidV7().generate(),
      name: DateFormat("'Evento do dia 'dd/MM/yyyy").format(now),
      createdAt: now,
      updatedAt: now,
    );
  }
}

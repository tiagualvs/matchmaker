import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:uuid/v7.dart';

part 'score_entity.freezed.dart';
part 'score_entity.g.dart';

@freezed
abstract class ScoreEntity with _$ScoreEntity {
  const ScoreEntity._();

  const factory ScoreEntity({
    required String id,
    @JsonKey(name: 'match_id') required String matchId,
    @JsonKey(name: 'team_id') required String teamId,
    @Default(false) bool reversed,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _ScoreEntity;

  factory ScoreEntity.fromJson(Map<String, dynamic> json) => _$ScoreEntityFromJson(json);

  factory ScoreEntity.fromSqlite(Row row) {
    return ScoreEntity(
      id: row['id'] as String,
      matchId: row['match_id'] as String,
      teamId: row['team_id'] as String,
      reversed: row['reversed'] as int == 1,
      createdAt: DateTime.parse(row['created_at'] as String),
      updatedAt: DateTime.parse(row['updated_at'] as String),
    );
  }

  bool get isEmpty => id.isEmpty;

  bool get isNotEmpty => !isEmpty;

  factory ScoreEntity.empty() {
    return ScoreEntity(
      id: '',
      matchId: '',
      teamId: '',
      createdAt: DateTime(0),
      updatedAt: DateTime(0),
    );
  }

  factory ScoreEntity.create(String matchId, String teamId) {
    return ScoreEntity(
      id: const UuidV7().generate(),
      matchId: matchId,
      teamId: teamId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

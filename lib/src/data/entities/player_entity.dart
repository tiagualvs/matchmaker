import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:uuid/v7.dart';

part 'player_entity.freezed.dart';
part 'player_entity.g.dart';

@freezed
sealed class PlayerGender with _$PlayerGender {
  const PlayerGender._();
  const factory PlayerGender.male({@Default('male') String value}) = PlayerGenderMale;
  const factory PlayerGender.female({@Default('female') String value}) = PlayerGenderFemale;
  const factory PlayerGender.unknown({@Default('unknown') String value}) = PlayerGenderUnknown;
  factory PlayerGender.fromJson(Map<String, dynamic> json) => _$PlayerGenderFromJson(json);
}

@freezed
sealed class PlayerLevel with _$PlayerLevel {
  const PlayerLevel._();
  const factory PlayerLevel.basic({@Default('basic') String value}) = _Basic;
  const factory PlayerLevel.intermediate({@Default('intermediate') String value}) = _Intermediate;
  const factory PlayerLevel.advanced({@Default('advanced') String value}) = _Advanced;

  factory PlayerLevel.fromJson(Map<String, dynamic> json) => _$PlayerLevelFromJson(json);
}

@freezed
abstract class PlayerEntity with _$PlayerEntity {
  const PlayerEntity._();

  String get tableName => 'players';

  const factory PlayerEntity({
    required String id,
    required String name,
    required PlayerGender gender,
    @Default(PlayerLevel.basic()) PlayerLevel level,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _PlayerEntity;

  factory PlayerEntity.fromJson(Map<String, dynamic> json) => _$PlayerEntityFromJson(json);

  factory PlayerEntity.fromSqlite(Row row) {
    return PlayerEntity(
      id: row['id'] as String,
      name: row['name'] as String,
      gender: switch (row['gender']) {
        'male' => const PlayerGender.male(),
        'female' => const PlayerGender.female(),
        _ => const PlayerGender.unknown(),
      },
      level: switch (row['level']) {
        'basic' => const PlayerLevel.basic(),
        'intermediate' => const PlayerLevel.intermediate(),
        'advanced' => const PlayerLevel.advanced(),
        _ => const PlayerLevel.basic(),
      },
      createdAt: DateTime.parse(row['created_at'] as String),
      updatedAt: DateTime.parse(row['updated_at'] as String),
    );
  }

  String get storageKey => 'player_$id';

  bool get isJoker => id.startsWith('joker_');

  bool get isWoman => gender is PlayerGenderFemale;

  bool get isMan => gender is PlayerGenderMale;

  factory PlayerEntity.create(String name) {
    return PlayerEntity(
      id: const UuidV7().generate(),
      name: name,
      gender: const PlayerGender.unknown(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  factory PlayerEntity.joker(int index, PlayerGender gender) {
    return PlayerEntity(
      id: 'joker_${const UuidV7().generate()}',

      name: switch (gender) {
        PlayerGenderMale _ => 'Jogador Coringa',
        PlayerGenderFemale _ => 'Jogadora Coringa',
        _ => 'Jogador Coringa',
      },
      gender: gender,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

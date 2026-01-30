import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/score_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/services/database/database.dart';

part 'event_entity.freezed.dart';
part 'event_entity.g.dart';

@freezed
abstract class EventEntity with _$EventEntity {
  const EventEntity._();

  const factory EventEntity({
    required int id,
    required String name,
    @Default([]) List<TeamEntity> teams,
    @Default([]) List<MatchEntity> matches,
    @Default([]) List<int> queue,
    @Default(12) int maxScore,
    @Default(4) int maxPlayerPerTeam,
    @Default(true) bool balancedByGender,
    @Default(true) bool balancedByLevel,
    @Default(0) int maxWinsInARow,
    @Default(false) bool halfScoreToEliminate,
    @Default(false) bool ended,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? endedAt,
  }) = _EventEntity;

  factory EventEntity.fromJson(Map<String, dynamic> json) => _$EventEntityFromJson(json);

  factory EventEntity.fromDrift(EventData data) {
    return EventEntity(
      id: data.id,
      name: data.name,
      maxScore: data.maxScore,
      maxPlayerPerTeam: data.maxPlayerPerTeam,
      balancedByGender: data.balancedByGender,
      balancedByLevel: data.balancedByLevel,
      maxWinsInARow: data.maxWinsInARow,
      teams: [],
      matches: [],
      queue: data.queue.split(',').map((id) => int.parse(id)).toList(),
      halfScoreToEliminate: data.halfScoreToEliminate,
      ended: data.ended,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      endedAt: data.endedAt,
    );
  }

  factory EventEntity.withAllData(EventWithAllDataData data) {
    final teams = List<TeamEntity>.from(
      (json.decode(data.teams) as List).map(
        (source) => TeamEntity(
          id: source['id'] as int,
          eventId: source['eventId'] as int,
          name: source['name'] as String,
          players: List.from(
            (source['players'] as List).map(
              (player) => PlayerEntity(
                id: player['id'] as int,
                name: player['name'] as String,
                gender: PlayerGender.fromValue(player['gender'] as String),
                level: PlayerLevel.fromValue(player['level'] as String),
                createdAt: DateTime.parse(player['createdAt'] as String),
                updatedAt: DateTime.parse(player['updatedAt'] as String),
              ),
            ),
          ),
          createdAt: DateTime.parse(source['createdAt'] as String),
          updatedAt: DateTime.parse(source['updatedAt'] as String),
        ),
      ),
    );

    final matches = List<MatchEntity>.from(
      (json.decode(data.matches) as List).map(
        (source) {
          return MatchEntity(
            id: source['id'] as int,
            eventId: source['eventId'] as int,
            name: source['name'] as String,
            firstTeam: teams.firstWhere((team) => team.id == source['firstTeamId'] as int),
            secondTeam: teams.firstWhere((team) => team.id == source['secondTeamId'] as int),
            scores: List.from(
              (source['scores'] as List).map(
                (score) => ScoreEntity(
                  id: score['id'] as int,
                  matchId: score['matchId'] as int,
                  teamId: score['teamId'] as int,
                  reversed: score['reversed'] == 1,
                  createdAt: DateTime.parse(score['createdAt'] as String).toLocal(),
                  updatedAt: DateTime.parse(score['updatedAt'] as String).toLocal(),
                ),
              ),
            )..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
            maxScore: source['maxScore'] as int,
            halfScoreToEliminate: source['halfScoreToEliminate'] == 1,
            ended: source['ended'] == 1,
            createdAt: DateTime.parse(source['createdAt'] as String).toLocal(),
            updatedAt: DateTime.parse(source['updatedAt'] as String).toLocal(),
          );
        },
      ),
    )..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return EventEntity(
      id: data.id,
      name: data.name,
      maxScore: data.maxScore,
      maxPlayerPerTeam: data.maxPlayerPerTeam,
      balancedByGender: data.balancedByGender,
      balancedByLevel: data.balancedByLevel,
      maxWinsInARow: data.maxWinsInARow,
      teams: teams,
      matches: matches,
      queue: data.queue.split(',').map((id) => int.parse(id)).toList(),
      halfScoreToEliminate: data.halfScoreToEliminate,
      ended: data.ended,
      createdAt: DateTime.parse(data.createdAt).toLocal(),
      updatedAt: DateTime.parse(data.updatedAt).toLocal(),
      endedAt: switch (data.endedAt.isEmpty) {
        true => null,
        false => DateTime.parse(data.endedAt),
      },
    );
  }

  factory EventEntity.withLastMatch(EventWithLastMatchData data) {
    return EventEntity(
      id: data.id,
      name: data.name,
      maxScore: data.maxScore,
      maxPlayerPerTeam: data.maxPlayerPerTeam,
      balancedByGender: data.balancedByGender,
      balancedByLevel: data.balancedByLevel,
      maxWinsInARow: data.maxWinsInARow,
      teams: [],
      matches: List.from(
        (json.decode(data.matches) as List).map(
          (src) {
            final firstTeamSource = src['firstTeam'];
            final secondTeamSource = src['secondTeam'];

            return MatchEntity(
              id: src['id'] as int,
              eventId: data.id,
              name: src['name'] as String,
              firstTeam: TeamEntity(
                id: firstTeamSource['id'] as int,
                eventId: data.id,
                name: firstTeamSource['name'] as String,
                players: List.from(
                  (firstTeamSource['players'] as List).map(
                    (player) => PlayerEntity(
                      id: player['id'] as int,
                      name: player['name'] as String,
                      gender: PlayerGender.fromValue(player['gender'] as String),
                      level: PlayerLevel.fromValue(player['level'] as String),
                      createdAt: DateTime.parse(player['createdAt'] as String),
                      updatedAt: DateTime.parse(player['updatedAt'] as String),
                    ),
                  ),
                ),
                createdAt: DateTime.parse(firstTeamSource['createdAt'] as String),
                updatedAt: DateTime.parse(firstTeamSource['updatedAt'] as String),
              ),
              secondTeam: TeamEntity(
                id: secondTeamSource['id'] as int,
                eventId: data.id,
                name: secondTeamSource['name'] as String,
                players: List.from(
                  (secondTeamSource['players'] as List).map(
                    (player) => PlayerEntity(
                      id: player['id'] as int,
                      name: player['name'] as String,
                      gender: PlayerGender.fromValue(player['gender'] as String),
                      level: PlayerLevel.fromValue(player['level'] as String),
                      createdAt: DateTime.parse(player['createdAt'] as String),
                      updatedAt: DateTime.parse(player['updatedAt'] as String),
                    ),
                  ),
                ),
                createdAt: DateTime.parse(secondTeamSource['createdAt'] as String),
                updatedAt: DateTime.parse(secondTeamSource['updatedAt'] as String),
              ),

              scores: List.from(
                (src['scores'] as List).map(
                  (score) => ScoreEntity(
                    id: score['id'] as int,
                    matchId: score['matchId'] as int,
                    teamId: score['teamId'] as int,
                    reversed: score['reversed'] == 1,
                    createdAt: DateTime.parse(score['createdAt'] as String),
                    updatedAt: DateTime.parse(score['updatedAt'] as String),
                  ),
                ),
              ),
              maxScore: src['maxScore'] as int,
              halfScoreToEliminate: src['halfScoreToEliminate'] == 1,
              createdAt: DateTime.parse(src['createdAt'] as String),
              updatedAt: DateTime.parse(src['updatedAt'] as String),
            );
          },
        ),
      ),
      queue: data.queue.split(',').map((id) => int.parse(id)).toList(),
      halfScoreToEliminate: data.halfScoreToEliminate,
      ended: data.ended,
      createdAt: DateTime.parse(data.createdAt),
      updatedAt: DateTime.parse(data.updatedAt),
      endedAt: switch (data.endedAt.isEmpty) {
        true => null,
        false => DateTime.parse(data.endedAt),
      },
    );
  }

  bool teamHasMaxWinsInARow(int teamId) {
    if (maxWinsInARow == 0) return false;

    final ids = endedMatches.map((match) => match.winner?.id ?? -1).where((id) => !id.isNegative);

    if (ids.length < maxWinsInARow) return false;

    final range = ids.take(maxWinsInARow);

    return range.every((id) => id == teamId);
  }

  List<MatchEntity> get endedMatches => matches.where((match) => match.ended).toList();

  List<MatchEntity> get notEndedMatches => matches.where((match) => !match.ended).toList();

  MatchEntity? get currentMatch {
    if (notEndedMatches.isEmpty) return null;

    return notEndedMatches.first;
  }

  MatchEntity? get lastEndedMatch {
    if (endedMatches.isEmpty) return null;

    return endedMatches.first;
  }

  int teamWins(int teamId) {
    return endedMatches.where((match) => match.winner?.id == teamId).length;
  }

  int teamLosses(int teamId) {
    return endedMatches.where((match) => match.loser?.id == teamId).length;
  }

  List<TeamEntity> get sortedTeams {
    return List.from(teams)..sort((a, b) {
      final aWins = teamWins(a.id);
      final aLosses = teamLosses(a.id);
      final bWins = teamWins(b.id);
      final bLosses = teamLosses(b.id);

      return bWins.compareTo(aWins) == 0 ? aLosses.compareTo(bLosses) : bWins.compareTo(aWins);
    });
  }

  bool get isEmpty => id.isNegative;

  bool get isNotEmpty => !isEmpty;

  factory EventEntity.empty() {
    return EventEntity(
      id: -1,
      name: '',
      createdAt: DateTime(0),
      updatedAt: DateTime(0),
    );
  }
}

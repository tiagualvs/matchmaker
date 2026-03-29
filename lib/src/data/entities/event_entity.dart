import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matchmaker/src/common/shared/id.dart';
import 'package:matchmaker/src/common/shared/timestamp.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/services/shared_preferences/shared_preferences_service.dart';

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

  factory EventEntity.fromJson(Map<String, dynamic> json) =>
      _$EventEntityFromJson(json);

  factory EventEntity.create({
    required String name,
    int maxScore = 12,
    int maxPlayerPerTeam = 4,
    bool balancedByGender = true,
    bool balancedByLevel = true,
    int maxWinsInARow = 0,
    bool halfScoreToEliminate = false,
  }) {
    return EventEntity(
      id: Id.generate(),
      name: name,
      maxScore: maxScore,
      maxPlayerPerTeam: maxPlayerPerTeam,
      balancedByGender: balancedByGender,
      balancedByLevel: balancedByLevel,
      maxWinsInARow: maxWinsInARow,
      halfScoreToEliminate: halfScoreToEliminate,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );
  }

  factory EventEntity.empty() {
    return EventEntity(
      id: Id.min(),
      name: '',
      createdAt: Timestamp.min(),
      updatedAt: Timestamp.min(),
    );
  }

  (MatchEntity match, List<String> queue)? nextMatch() {
    if (ended) return (matches.first, queue);

    if (matches.isEmpty) {
      final match = MatchEntity.create(
        eventId: id,
        name: '#1',
        firstTeam: teams[0],
        secondTeam: teams[1],
        maxScore: maxScore,
        halfScoreToEliminate: halfScoreToEliminate,
      );

      return (match, teams.skip(2).map((team) => team.id).toList());
    }

    if (currentMatch != null) return null;

    if (lastEndedMatch == null) return null;

    final lastWinner = lastEndedMatch?.winner;

    final lastLoser = lastEndedMatch?.loser;

    if (lastWinner == null) return null;

    if (lastLoser == null) return null;

    if (teamWithMaxWinsInARow() != null) {
      final match = MatchEntity.create(
        eventId: id,
        name: (matches.length + 1).toString(),
        firstTeam: queueTeams[0],
        secondTeam: queueTeams[1],
        maxScore: maxScore,
        halfScoreToEliminate: halfScoreToEliminate,
      );

      return (match, [lastWinner.id, ...queue.sublist(2), lastLoser.id]);
    }

    final firstTeam = lastWinner == lastEndedMatch?.firstTeam
        ? lastWinner
        : queueTeams[0];

    final secondTeam = lastWinner == lastEndedMatch?.secondTeam
        ? lastWinner
        : queueTeams[0];

    final match = MatchEntity.create(
      eventId: id,
      name: (matches.length + 1).toString(),
      firstTeam: firstTeam,
      secondTeam: secondTeam,
      maxScore: maxScore,
      halfScoreToEliminate: halfScoreToEliminate,
    );

    return (match, [...queue.sublist(1), lastLoser.id]);
  }

  (TeamEntity first, TeamEntity second, List<TeamEntity> queue)?
  nextMatchData() {
    if (ended) return null;

    if (matches.isEmpty) {
      return (teams[0], teams[1], queueTeams.skip(2).toList());
    }

    if (currentMatch != null) return null;

    if (lastEndedMatch == null) return null;

    final lastWinner = lastEndedMatch?.winner;

    final lastLoser = lastEndedMatch?.loser;

    if (lastWinner == null || lastLoser == null) return null;

    if (teamWithMaxWinsInARow() != null) {
      return (
        queueTeams[0],
        queueTeams[1],
        [lastWinner, ...queueTeams.sublist(2), lastLoser],
      );
    } else {
      return (
        lastWinner == lastEndedMatch?.firstTeam ? lastWinner : queueTeams[0],
        lastWinner == lastEndedMatch?.secondTeam ? lastWinner : queueTeams[0],
        [...queueTeams.sublist(1), lastLoser],
      );
    }
  }

  bool needsToCreateAnotherMatch() {
    if (ended) return false;

    if (currentMatch != null) return false;

    if (lastEndedMatch == null) return false;

    return true;
  }

  TeamEntity lastWinner() {
    if (lastEndedMatch == null) throw Exception('No last ended match');

    if (lastEndedMatch?.winner == null) {
      throw Exception('No winner in last ended match');
    }

    return lastEndedMatch!.winner!;
  }

  TeamEntity? teamWithMaxWinsInARow() {
    if (maxWinsInARow == 0) return null;

    if (queue.length < 2) return null;

    final lastWinner = lastEndedMatch?.winner;

    if (lastWinner == null) return null;

    final ids = endedMatches
        .map((match) => match.winner?.id)
        .whereType<String>()
        .where((id) => Id.valid(id));

    if (ids.length < maxWinsInARow) return null;

    final range = ids.take(maxWinsInARow);

    if (!range.every((id) => id == lastWinner.id)) return null;

    return lastWinner;
  }

  List<TeamEntity> get queueTeams =>
      queue.map((id) => teams.firstWhere((team) => team.id == id)).toList();

  List<MatchEntity> get endedMatches =>
      matches.where((match) => match.ended).toList();

  List<MatchEntity> get notEndedMatches =>
      matches.where((match) => !match.ended).toList();

  MatchEntity? get currentMatch {
    if (notEndedMatches.isEmpty) return null;

    return notEndedMatches.first;
  }

  MatchEntity? get lastEndedMatch {
    if (endedMatches.isEmpty) return null;

    return endedMatches.first;
  }

  int teamWins(String teamId) {
    return endedMatches.where((match) => match.winner?.id == teamId).length;
  }

  int teamLosses(String teamId) {
    return endedMatches.where((match) => match.loser?.id == teamId).length;
  }

  List<TeamEntity> get sortedTeams {
    return List.from(teams)..sort((a, b) {
      final aWins = teamWins(a.id);
      final aLosses = teamLosses(a.id);
      final bWins = teamWins(b.id);
      final bLosses = teamLosses(b.id);

      return bWins.compareTo(aWins) == 0
          ? aLosses.compareTo(bLosses)
          : bWins.compareTo(aWins);
    });
  }

  bool get isEmpty => id == Id.min();

  bool get isNotEmpty => !isEmpty;

  bool get hasIncompleteTeams =>
      teams.any((team) => team.players.length != maxPlayerPerTeam);

  bool hasPlayer(String playerId) {
    return teams.any(
      (team) => team.players.any((player) => player.id == playerId),
    );
  }

  static SharedPreferencesEncoder<EventEntity> encoder() => _EventEncoder();
}

class _EventEncoder extends SharedPreferencesEncoder<EventEntity> {
  @override
  EventEntity? decode(String source) {
    return EventEntity.fromJson(json.decode(source));
  }

  @override
  String encode(EventEntity value) {
    return json.encode(value.toJson());
  }

  @override
  String identifier(EventEntity value) {
    return value.id;
  }
}

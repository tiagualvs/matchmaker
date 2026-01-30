import 'package:drift/drift.dart';

class Player extends Table {
  late final IntColumn id = integer().autoIncrement()();
  late final TextColumn name = text().unique()();
  late final TextColumn gender = text().check(gender.isIn(['male', 'female', 'unknown']))();
  late final TextColumn level = text().check(level.isIn(['basic', 'intermediate', 'advanced']))();
  late final DateTimeColumn createdAt = dateTime().named('created_at').clientDefault(() => DateTime.now().toUtc())();
  late final DateTimeColumn updatedAt = dateTime().named('updated_at').clientDefault(() => DateTime.now().toUtc())();

  @override
  String get tableName => 'tb_players';
}

class Event extends Table {
  late final IntColumn id = integer().autoIncrement()();
  late final TextColumn name = text()();
  late final IntColumn maxScore = integer().named('max_score').clientDefault(() => 12)();
  late final IntColumn maxPlayerPerTeam = integer().named('max_player_per_team').clientDefault(() => 4)();
  late final BoolColumn balancedByGender = boolean().named('balanced_by_gender').clientDefault(() => true)();
  late final BoolColumn balancedByLevel = boolean().named('balanced_by_level').clientDefault(() => false)();
  late final IntColumn maxWinsInARow = integer().named('max_wins_in_a_row').clientDefault(() => 0)();
  late final BoolColumn halfScoreToEliminate = boolean().named('half_score_to_eliminate').clientDefault(() => false)();
  late final TextColumn queue = text().clientDefault(() => '')();
  late final BoolColumn ended = boolean().clientDefault(() => false)();
  late final DateTimeColumn createdAt = dateTime().named('created_at').clientDefault(() => DateTime.now().toUtc())();
  late final DateTimeColumn updatedAt = dateTime().named('updated_at').clientDefault(() => DateTime.now().toUtc())();
  late final DateTimeColumn endedAt = dateTime().nullable().named('ended_at')();

  @override
  String get tableName => 'tb_events';
}

class EventTeam extends Table {
  late final IntColumn id = integer().autoIncrement()();
  late final IntColumn eventId = integer().named('event_id').references(Event, #id, onDelete: .cascade)();
  late final TextColumn name = text()();
  late final DateTimeColumn createdAt = dateTime().named('created_at').clientDefault(() => DateTime.now().toUtc())();
  late final DateTimeColumn updatedAt = dateTime().named('updated_at').clientDefault(() => DateTime.now().toUtc())();

  @override
  String get tableName => 'tb_event_teams';
}

class EventTeamPlayer extends Table {
  late final IntColumn teamId = integer().named('team_id').references(EventTeam, #id, onDelete: .cascade)();
  late final IntColumn playerId = integer().named('player_id').references(Player, #id, onDelete: .cascade)();
  late final DateTimeColumn createdAt = dateTime().named('created_at').clientDefault(() => DateTime.now().toUtc())();
  late final DateTimeColumn updatedAt = dateTime().named('updated_at').clientDefault(() => DateTime.now().toUtc())();

  @override
  String get tableName => 'tb_event_team_players';

  @override
  Set<Column<Object>> get primaryKey => {teamId, playerId};
}

class EventMatch extends Table {
  late final IntColumn id = integer().autoIncrement()();
  late final IntColumn eventId = integer().named('event_id').references(Event, #id, onDelete: .cascade)();
  late final IntColumn firstTeamId = integer().named('first_team_id').references(EventTeam, #id, onDelete: .cascade)();
  late final IntColumn secondTeamId = integer()
      .named('second_team_id')
      .references(EventTeam, #id, onDelete: .cascade)();
  late final TextColumn name = text()();
  late final IntColumn maxScore = integer().named('max_score')();
  late final BoolColumn halfScoreToEliminate = boolean().named('half_score_to_eliminate')();
  late final BoolColumn ended = boolean().clientDefault(() => false)();
  late final DateTimeColumn createdAt = dateTime().named('created_at').clientDefault(() => DateTime.now().toUtc())();
  late final DateTimeColumn updatedAt = dateTime().named('updated_at').clientDefault(() => DateTime.now().toUtc())();
  late final DateTimeColumn endedAt = dateTime().nullable().named('ended_at')();

  @override
  String get tableName => 'tb_event_matches';
}

class MatchScore extends Table {
  late final IntColumn id = integer().autoIncrement()();
  late final IntColumn matchId = integer().named('match_id').references(EventMatch, #id, onDelete: .cascade)();
  late final IntColumn teamId = integer().named('team_id').references(EventTeam, #id, onDelete: .cascade)();
  late final BoolColumn reversed = boolean().clientDefault(() => false)();
  late final DateTimeColumn createdAt = dateTime().named('created_at').clientDefault(() => DateTime.now().toUtc())();
  late final DateTimeColumn updatedAt = dateTime().named('updated_at').clientDefault(() => DateTime.now().toUtc())();

  @override
  String get tableName => 'tb_match_scores';
}

const tables = <Type>[
  Event,
  Player,
  EventTeam,
  EventTeamPlayer,
  EventMatch,
  MatchScore,
];

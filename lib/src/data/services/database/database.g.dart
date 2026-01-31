// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class EventWithAllDataData extends DataClass {
  final int id;
  final String name;
  final int maxScore;
  final int maxPlayerPerTeam;
  final bool balancedByGender;
  final bool balancedByLevel;
  final int maxWinsInARow;
  final bool halfScoreToEliminate;
  final String queue;
  final bool ended;
  final String createdAt;
  final String updatedAt;
  final String endedAt;
  final String teams;
  final String matches;
  const EventWithAllDataData({
    required this.id,
    required this.name,
    required this.maxScore,
    required this.maxPlayerPerTeam,
    required this.balancedByGender,
    required this.balancedByLevel,
    required this.maxWinsInARow,
    required this.halfScoreToEliminate,
    required this.queue,
    required this.ended,
    required this.createdAt,
    required this.updatedAt,
    required this.endedAt,
    required this.teams,
    required this.matches,
  });
  factory EventWithAllDataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventWithAllDataData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      maxScore: serializer.fromJson<int>(json['maxScore']),
      maxPlayerPerTeam: serializer.fromJson<int>(json['maxPlayerPerTeam']),
      balancedByGender: serializer.fromJson<bool>(json['balancedByGender']),
      balancedByLevel: serializer.fromJson<bool>(json['balancedByLevel']),
      maxWinsInARow: serializer.fromJson<int>(json['maxWinsInARow']),
      halfScoreToEliminate: serializer.fromJson<bool>(
        json['halfScoreToEliminate'],
      ),
      queue: serializer.fromJson<String>(json['queue']),
      ended: serializer.fromJson<bool>(json['ended']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      endedAt: serializer.fromJson<String>(json['endedAt']),
      teams: serializer.fromJson<String>(json['teams']),
      matches: serializer.fromJson<String>(json['matches']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'maxScore': serializer.toJson<int>(maxScore),
      'maxPlayerPerTeam': serializer.toJson<int>(maxPlayerPerTeam),
      'balancedByGender': serializer.toJson<bool>(balancedByGender),
      'balancedByLevel': serializer.toJson<bool>(balancedByLevel),
      'maxWinsInARow': serializer.toJson<int>(maxWinsInARow),
      'halfScoreToEliminate': serializer.toJson<bool>(halfScoreToEliminate),
      'queue': serializer.toJson<String>(queue),
      'ended': serializer.toJson<bool>(ended),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'endedAt': serializer.toJson<String>(endedAt),
      'teams': serializer.toJson<String>(teams),
      'matches': serializer.toJson<String>(matches),
    };
  }

  EventWithAllDataData copyWith({
    int? id,
    String? name,
    int? maxScore,
    int? maxPlayerPerTeam,
    bool? balancedByGender,
    bool? balancedByLevel,
    int? maxWinsInARow,
    bool? halfScoreToEliminate,
    String? queue,
    bool? ended,
    String? createdAt,
    String? updatedAt,
    String? endedAt,
    String? teams,
    String? matches,
  }) => EventWithAllDataData(
    id: id ?? this.id,
    name: name ?? this.name,
    maxScore: maxScore ?? this.maxScore,
    maxPlayerPerTeam: maxPlayerPerTeam ?? this.maxPlayerPerTeam,
    balancedByGender: balancedByGender ?? this.balancedByGender,
    balancedByLevel: balancedByLevel ?? this.balancedByLevel,
    maxWinsInARow: maxWinsInARow ?? this.maxWinsInARow,
    halfScoreToEliminate: halfScoreToEliminate ?? this.halfScoreToEliminate,
    queue: queue ?? this.queue,
    ended: ended ?? this.ended,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    endedAt: endedAt ?? this.endedAt,
    teams: teams ?? this.teams,
    matches: matches ?? this.matches,
  );
  @override
  String toString() {
    return (StringBuffer('EventWithAllDataData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('maxScore: $maxScore, ')
          ..write('maxPlayerPerTeam: $maxPlayerPerTeam, ')
          ..write('balancedByGender: $balancedByGender, ')
          ..write('balancedByLevel: $balancedByLevel, ')
          ..write('maxWinsInARow: $maxWinsInARow, ')
          ..write('halfScoreToEliminate: $halfScoreToEliminate, ')
          ..write('queue: $queue, ')
          ..write('ended: $ended, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('teams: $teams, ')
          ..write('matches: $matches')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    maxScore,
    maxPlayerPerTeam,
    balancedByGender,
    balancedByLevel,
    maxWinsInARow,
    halfScoreToEliminate,
    queue,
    ended,
    createdAt,
    updatedAt,
    endedAt,
    teams,
    matches,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventWithAllDataData &&
          other.id == this.id &&
          other.name == this.name &&
          other.maxScore == this.maxScore &&
          other.maxPlayerPerTeam == this.maxPlayerPerTeam &&
          other.balancedByGender == this.balancedByGender &&
          other.balancedByLevel == this.balancedByLevel &&
          other.maxWinsInARow == this.maxWinsInARow &&
          other.halfScoreToEliminate == this.halfScoreToEliminate &&
          other.queue == this.queue &&
          other.ended == this.ended &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.endedAt == this.endedAt &&
          other.teams == this.teams &&
          other.matches == this.matches);
}

class EventWithAllData extends ViewInfo<EventWithAllData, EventWithAllDataData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  EventWithAllData(this.attachedDatabase, [this._alias]);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    maxScore,
    maxPlayerPerTeam,
    balancedByGender,
    balancedByLevel,
    maxWinsInARow,
    halfScoreToEliminate,
    queue,
    ended,
    createdAt,
    updatedAt,
    endedAt,
    teams,
    matches,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'event_with_all_data';
  @override
  Map<SqlDialect, String> get createViewStatements => {
    SqlDialect.sqlite:
        'CREATE VIEW IF NOT EXISTS event_with_all_data AS SELECT CAST(e.id AS INT) AS id, CAST(e.name AS TEXT) AS name, CAST(e.max_score AS INT) AS maxScore, CAST(e.max_player_per_team AS INT) AS maxPlayerPerTeam, CAST(e.balanced_by_gender AS INT) AS balancedByGender, CAST(e.balanced_by_level AS INT) AS balancedByLevel, CAST(e.max_wins_in_a_row AS INT) AS maxWinsInARow, CAST(e.half_score_to_eliminate AS INT) AS halfScoreToEliminate, CAST(e.queue AS TEXT) AS queue, CAST(e.ended AS INT) AS ended, CAST(e.created_at AS TEXT) AS createdAt, CAST(e.updated_at AS TEXT) AS updatedAt, COALESCE(CAST(e.ended_at AS TEXT), \'\') AS endedAt, COALESCE((SELECT json_group_array(json_object(\'id\', t.id, \'eventId\', t.event_id, \'name\', t.name, \'createdAt\', t.created_at, \'updatedAt\', t.updated_at, \'players\', COALESCE((SELECT json_group_array(json_object(\'id\', p.id, \'name\', p.name, \'gender\', p.gender, \'level\', p.level, \'createdAt\', p.created_at, \'updatedAt\', p.updated_at)) FROM tb_team_players AS tp JOIN tb_players AS p ON p.id = tp.player_id WHERE tp.team_id = t.id), json(\'[]\')))) FROM tb_teams AS t WHERE t.event_id = e.id), json(\'[]\')) AS teams, COALESCE((SELECT json_group_array(json_object(\'id\', m.id, \'eventId\', m.event_id, \'name\', m.name, \'firstTeamId\', m.first_team_id, \'secondTeamId\', m.second_team_id, \'maxScore\', m.max_score, \'halfScoreToEliminate\', m.half_score_to_eliminate, \'ended\', m.ended, \'createdAt\', m.created_at, \'updatedAt\', m.updated_at, \'endedAt\', m.ended_at, \'scores\', COALESCE((SELECT json_group_array(json_object(\'id\', s.id, \'matchId\', s.match_id, \'teamId\', s.team_id, \'reversed\', s.reversed, \'createdAt\', s.created_at, \'updatedAt\', s.updated_at)) FROM tb_match_scores AS s WHERE s.match_id = m.id ORDER BY s.id ASC), json(\'[]\')))) FROM tb_matches AS m WHERE m.event_id = e.id ORDER BY m.id ASC), json(\'[]\')) AS matches FROM tb_events AS e',
  };
  @override
  EventWithAllData get asDslTable => this;
  @override
  EventWithAllDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventWithAllDataData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      maxScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}maxScore'],
      )!,
      maxPlayerPerTeam: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}maxPlayerPerTeam'],
      )!,
      balancedByGender: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}balancedByGender'],
      )!,
      balancedByLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}balancedByLevel'],
      )!,
      maxWinsInARow: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}maxWinsInARow'],
      )!,
      halfScoreToEliminate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}halfScoreToEliminate'],
      )!,
      queue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}queue'],
      )!,
      ended: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ended'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}createdAt'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updatedAt'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}endedAt'],
      )!,
      teams: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}teams'],
      )!,
      matches: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}matches'],
      )!,
    );
  }

  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<int> maxScore = GeneratedColumn<int>(
    'maxScore',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<int> maxPlayerPerTeam = GeneratedColumn<int>(
    'maxPlayerPerTeam',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<bool> balancedByGender = GeneratedColumn<bool>(
    'balancedByGender',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("balancedByGender" IN (0, 1))',
    ),
  );
  late final GeneratedColumn<bool> balancedByLevel = GeneratedColumn<bool>(
    'balancedByLevel',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("balancedByLevel" IN (0, 1))',
    ),
  );
  late final GeneratedColumn<int> maxWinsInARow = GeneratedColumn<int>(
    'maxWinsInARow',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<bool> halfScoreToEliminate = GeneratedColumn<bool>(
    'halfScoreToEliminate',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("halfScoreToEliminate" IN (0, 1))',
    ),
  );
  late final GeneratedColumn<String> queue = GeneratedColumn<String>(
    'queue',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<bool> ended = GeneratedColumn<bool>(
    'ended',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ended" IN (0, 1))',
    ),
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'createdAt',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updatedAt',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<String> endedAt = GeneratedColumn<String>(
    'endedAt',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<String> teams = GeneratedColumn<String>(
    'teams',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<String> matches = GeneratedColumn<String>(
    'matches',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  @override
  EventWithAllData createAlias(String alias) {
    return EventWithAllData(attachedDatabase, alias);
  }

  @override
  Query? get query => null;
  @override
  Set<String> get readTables => const {};
}

class EventWithLastMatchData extends DataClass {
  final int id;
  final String name;
  final int maxScore;
  final int maxPlayerPerTeam;
  final bool balancedByGender;
  final bool balancedByLevel;
  final int maxWinsInARow;
  final bool halfScoreToEliminate;
  final String queue;
  final bool ended;
  final String createdAt;
  final String updatedAt;
  final String endedAt;
  final String matches;
  const EventWithLastMatchData({
    required this.id,
    required this.name,
    required this.maxScore,
    required this.maxPlayerPerTeam,
    required this.balancedByGender,
    required this.balancedByLevel,
    required this.maxWinsInARow,
    required this.halfScoreToEliminate,
    required this.queue,
    required this.ended,
    required this.createdAt,
    required this.updatedAt,
    required this.endedAt,
    required this.matches,
  });
  factory EventWithLastMatchData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventWithLastMatchData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      maxScore: serializer.fromJson<int>(json['maxScore']),
      maxPlayerPerTeam: serializer.fromJson<int>(json['maxPlayerPerTeam']),
      balancedByGender: serializer.fromJson<bool>(json['balancedByGender']),
      balancedByLevel: serializer.fromJson<bool>(json['balancedByLevel']),
      maxWinsInARow: serializer.fromJson<int>(json['maxWinsInARow']),
      halfScoreToEliminate: serializer.fromJson<bool>(
        json['halfScoreToEliminate'],
      ),
      queue: serializer.fromJson<String>(json['queue']),
      ended: serializer.fromJson<bool>(json['ended']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      endedAt: serializer.fromJson<String>(json['endedAt']),
      matches: serializer.fromJson<String>(json['matches']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'maxScore': serializer.toJson<int>(maxScore),
      'maxPlayerPerTeam': serializer.toJson<int>(maxPlayerPerTeam),
      'balancedByGender': serializer.toJson<bool>(balancedByGender),
      'balancedByLevel': serializer.toJson<bool>(balancedByLevel),
      'maxWinsInARow': serializer.toJson<int>(maxWinsInARow),
      'halfScoreToEliminate': serializer.toJson<bool>(halfScoreToEliminate),
      'queue': serializer.toJson<String>(queue),
      'ended': serializer.toJson<bool>(ended),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'endedAt': serializer.toJson<String>(endedAt),
      'matches': serializer.toJson<String>(matches),
    };
  }

  EventWithLastMatchData copyWith({
    int? id,
    String? name,
    int? maxScore,
    int? maxPlayerPerTeam,
    bool? balancedByGender,
    bool? balancedByLevel,
    int? maxWinsInARow,
    bool? halfScoreToEliminate,
    String? queue,
    bool? ended,
    String? createdAt,
    String? updatedAt,
    String? endedAt,
    String? matches,
  }) => EventWithLastMatchData(
    id: id ?? this.id,
    name: name ?? this.name,
    maxScore: maxScore ?? this.maxScore,
    maxPlayerPerTeam: maxPlayerPerTeam ?? this.maxPlayerPerTeam,
    balancedByGender: balancedByGender ?? this.balancedByGender,
    balancedByLevel: balancedByLevel ?? this.balancedByLevel,
    maxWinsInARow: maxWinsInARow ?? this.maxWinsInARow,
    halfScoreToEliminate: halfScoreToEliminate ?? this.halfScoreToEliminate,
    queue: queue ?? this.queue,
    ended: ended ?? this.ended,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    endedAt: endedAt ?? this.endedAt,
    matches: matches ?? this.matches,
  );
  @override
  String toString() {
    return (StringBuffer('EventWithLastMatchData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('maxScore: $maxScore, ')
          ..write('maxPlayerPerTeam: $maxPlayerPerTeam, ')
          ..write('balancedByGender: $balancedByGender, ')
          ..write('balancedByLevel: $balancedByLevel, ')
          ..write('maxWinsInARow: $maxWinsInARow, ')
          ..write('halfScoreToEliminate: $halfScoreToEliminate, ')
          ..write('queue: $queue, ')
          ..write('ended: $ended, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('matches: $matches')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    maxScore,
    maxPlayerPerTeam,
    balancedByGender,
    balancedByLevel,
    maxWinsInARow,
    halfScoreToEliminate,
    queue,
    ended,
    createdAt,
    updatedAt,
    endedAt,
    matches,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventWithLastMatchData &&
          other.id == this.id &&
          other.name == this.name &&
          other.maxScore == this.maxScore &&
          other.maxPlayerPerTeam == this.maxPlayerPerTeam &&
          other.balancedByGender == this.balancedByGender &&
          other.balancedByLevel == this.balancedByLevel &&
          other.maxWinsInARow == this.maxWinsInARow &&
          other.halfScoreToEliminate == this.halfScoreToEliminate &&
          other.queue == this.queue &&
          other.ended == this.ended &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.endedAt == this.endedAt &&
          other.matches == this.matches);
}

class EventWithLastMatch
    extends ViewInfo<EventWithLastMatch, EventWithLastMatchData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  EventWithLastMatch(this.attachedDatabase, [this._alias]);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    maxScore,
    maxPlayerPerTeam,
    balancedByGender,
    balancedByLevel,
    maxWinsInARow,
    halfScoreToEliminate,
    queue,
    ended,
    createdAt,
    updatedAt,
    endedAt,
    matches,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'event_with_last_match';
  @override
  Map<SqlDialect, String> get createViewStatements => {
    SqlDialect.sqlite:
        'CREATE VIEW IF NOT EXISTS event_with_last_match AS SELECT CAST(e.id AS INT) AS id, CAST(e.name AS TEXT) AS name, CAST(e.max_score AS INT) AS maxScore, CAST(e.max_player_per_team AS INT) AS maxPlayerPerTeam, CAST(e.balanced_by_gender AS INT) AS balancedByGender, CAST(e.balanced_by_level AS INT) AS balancedByLevel, CAST(e.max_wins_in_a_row AS INT) AS maxWinsInARow, CAST(e.half_score_to_eliminate AS INT) AS halfScoreToEliminate, CAST(e.queue AS TEXT) AS queue, CAST(e.ended AS INT) AS ended, CAST(e.created_at AS TEXT) AS createdAt, CAST(e.updated_at AS TEXT) AS updatedAt, COALESCE(CAST(e.ended_at AS TEXT), \'\') AS endedAt, COALESCE((SELECT json_group_array(json_object(\'id\', m.id, \'eventId\', m.event_id, \'name\', m.name, \'firstTeamId\', m.first_team_id, \'secondTeamId\', m.second_team_id, \'maxScore\', m.max_score, \'halfScoreToEliminate\', m.half_score_to_eliminate, \'ended\', m.ended, \'createdAt\', m.created_at, \'updatedAt\', m.updated_at, \'endedAt\', m.ended_at, \'firstTeam\', (SELECT json_object(\'id\', t.id, \'eventId\', t.event_id, \'name\', t.name, \'createdAt\', t.created_at, \'updatedAt\', t.updated_at, \'players\', COALESCE((SELECT json_group_array(json_object(\'id\', p.id, \'name\', p.name, \'gender\', p.gender, \'level\', p.level, \'createdAt\', p.created_at, \'updatedAt\', p.updated_at)) FROM tb_team_players AS tp JOIN tb_players AS p ON p.id = tp.player_id WHERE tp.team_id = t.id), json(\'[]\'))) FROM tb_teams AS t WHERE t.id = m.first_team_id), \'secondTeam\', (SELECT json_object(\'id\', t.id, \'eventId\', t.event_id, \'name\', t.name, \'createdAt\', t.created_at, \'updatedAt\', t.updated_at, \'players\', COALESCE((SELECT json_group_array(json_object(\'id\', p.id, \'name\', p.name, \'gender\', p.gender, \'level\', p.level, \'createdAt\', p.created_at, \'updatedAt\', p.updated_at)) FROM tb_team_players AS tp JOIN tb_players AS p ON p.id = tp.player_id WHERE tp.team_id = t.id), json(\'[]\'))) FROM tb_teams AS t WHERE t.id = m.second_team_id), \'scores\', COALESCE((SELECT json_group_array(json_object(\'id\', s.id, \'matchId\', s.match_id, \'teamId\', s.team_id, \'reversed\', s.reversed, \'createdAt\', s.created_at, \'updatedAt\', s.updated_at)) FROM tb_match_scores AS s WHERE s.match_id = m.id ORDER BY s.created_at DESC), json(\'[]\')))) FROM tb_matches AS m WHERE m.event_id = e.id AND m.ended = 0 AND m.id = (SELECT MAX(id) FROM tb_matches WHERE event_id = e.id AND ended = 0)), json(\'[]\')) AS matches FROM tb_events AS e',
  };
  @override
  EventWithLastMatch get asDslTable => this;
  @override
  EventWithLastMatchData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventWithLastMatchData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      maxScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}maxScore'],
      )!,
      maxPlayerPerTeam: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}maxPlayerPerTeam'],
      )!,
      balancedByGender: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}balancedByGender'],
      )!,
      balancedByLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}balancedByLevel'],
      )!,
      maxWinsInARow: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}maxWinsInARow'],
      )!,
      halfScoreToEliminate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}halfScoreToEliminate'],
      )!,
      queue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}queue'],
      )!,
      ended: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ended'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}createdAt'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updatedAt'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}endedAt'],
      )!,
      matches: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}matches'],
      )!,
    );
  }

  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<int> maxScore = GeneratedColumn<int>(
    'maxScore',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<int> maxPlayerPerTeam = GeneratedColumn<int>(
    'maxPlayerPerTeam',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<bool> balancedByGender = GeneratedColumn<bool>(
    'balancedByGender',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("balancedByGender" IN (0, 1))',
    ),
  );
  late final GeneratedColumn<bool> balancedByLevel = GeneratedColumn<bool>(
    'balancedByLevel',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("balancedByLevel" IN (0, 1))',
    ),
  );
  late final GeneratedColumn<int> maxWinsInARow = GeneratedColumn<int>(
    'maxWinsInARow',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<bool> halfScoreToEliminate = GeneratedColumn<bool>(
    'halfScoreToEliminate',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("halfScoreToEliminate" IN (0, 1))',
    ),
  );
  late final GeneratedColumn<String> queue = GeneratedColumn<String>(
    'queue',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<bool> ended = GeneratedColumn<bool>(
    'ended',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ended" IN (0, 1))',
    ),
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'createdAt',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updatedAt',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<String> endedAt = GeneratedColumn<String>(
    'endedAt',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<String> matches = GeneratedColumn<String>(
    'matches',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  @override
  EventWithLastMatch createAlias(String alias) {
    return EventWithLastMatch(attachedDatabase, alias);
  }

  @override
  Query? get query => null;
  @override
  Set<String> get readTables => const {};
}

class MatchWithAllDataData extends DataClass {
  final int id;
  final String name;
  final int eventId;
  final int firstTeamId;
  final int secondTeamId;
  final int maxScore;
  final bool halfScoreToEliminate;
  final bool ended;
  final String createdAt;
  final String updatedAt;
  final String endedAt;
  final String firstTeam;
  final String secondTeam;
  final String scores;
  const MatchWithAllDataData({
    required this.id,
    required this.name,
    required this.eventId,
    required this.firstTeamId,
    required this.secondTeamId,
    required this.maxScore,
    required this.halfScoreToEliminate,
    required this.ended,
    required this.createdAt,
    required this.updatedAt,
    required this.endedAt,
    required this.firstTeam,
    required this.secondTeam,
    required this.scores,
  });
  factory MatchWithAllDataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MatchWithAllDataData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      eventId: serializer.fromJson<int>(json['eventId']),
      firstTeamId: serializer.fromJson<int>(json['firstTeamId']),
      secondTeamId: serializer.fromJson<int>(json['secondTeamId']),
      maxScore: serializer.fromJson<int>(json['maxScore']),
      halfScoreToEliminate: serializer.fromJson<bool>(
        json['halfScoreToEliminate'],
      ),
      ended: serializer.fromJson<bool>(json['ended']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      endedAt: serializer.fromJson<String>(json['endedAt']),
      firstTeam: serializer.fromJson<String>(json['firstTeam']),
      secondTeam: serializer.fromJson<String>(json['secondTeam']),
      scores: serializer.fromJson<String>(json['scores']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'eventId': serializer.toJson<int>(eventId),
      'firstTeamId': serializer.toJson<int>(firstTeamId),
      'secondTeamId': serializer.toJson<int>(secondTeamId),
      'maxScore': serializer.toJson<int>(maxScore),
      'halfScoreToEliminate': serializer.toJson<bool>(halfScoreToEliminate),
      'ended': serializer.toJson<bool>(ended),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'endedAt': serializer.toJson<String>(endedAt),
      'firstTeam': serializer.toJson<String>(firstTeam),
      'secondTeam': serializer.toJson<String>(secondTeam),
      'scores': serializer.toJson<String>(scores),
    };
  }

  MatchWithAllDataData copyWith({
    int? id,
    String? name,
    int? eventId,
    int? firstTeamId,
    int? secondTeamId,
    int? maxScore,
    bool? halfScoreToEliminate,
    bool? ended,
    String? createdAt,
    String? updatedAt,
    String? endedAt,
    String? firstTeam,
    String? secondTeam,
    String? scores,
  }) => MatchWithAllDataData(
    id: id ?? this.id,
    name: name ?? this.name,
    eventId: eventId ?? this.eventId,
    firstTeamId: firstTeamId ?? this.firstTeamId,
    secondTeamId: secondTeamId ?? this.secondTeamId,
    maxScore: maxScore ?? this.maxScore,
    halfScoreToEliminate: halfScoreToEliminate ?? this.halfScoreToEliminate,
    ended: ended ?? this.ended,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    endedAt: endedAt ?? this.endedAt,
    firstTeam: firstTeam ?? this.firstTeam,
    secondTeam: secondTeam ?? this.secondTeam,
    scores: scores ?? this.scores,
  );
  @override
  String toString() {
    return (StringBuffer('MatchWithAllDataData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('eventId: $eventId, ')
          ..write('firstTeamId: $firstTeamId, ')
          ..write('secondTeamId: $secondTeamId, ')
          ..write('maxScore: $maxScore, ')
          ..write('halfScoreToEliminate: $halfScoreToEliminate, ')
          ..write('ended: $ended, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('firstTeam: $firstTeam, ')
          ..write('secondTeam: $secondTeam, ')
          ..write('scores: $scores')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    eventId,
    firstTeamId,
    secondTeamId,
    maxScore,
    halfScoreToEliminate,
    ended,
    createdAt,
    updatedAt,
    endedAt,
    firstTeam,
    secondTeam,
    scores,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchWithAllDataData &&
          other.id == this.id &&
          other.name == this.name &&
          other.eventId == this.eventId &&
          other.firstTeamId == this.firstTeamId &&
          other.secondTeamId == this.secondTeamId &&
          other.maxScore == this.maxScore &&
          other.halfScoreToEliminate == this.halfScoreToEliminate &&
          other.ended == this.ended &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.endedAt == this.endedAt &&
          other.firstTeam == this.firstTeam &&
          other.secondTeam == this.secondTeam &&
          other.scores == this.scores);
}

class MatchWithAllData extends ViewInfo<MatchWithAllData, MatchWithAllDataData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  MatchWithAllData(this.attachedDatabase, [this._alias]);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    eventId,
    firstTeamId,
    secondTeamId,
    maxScore,
    halfScoreToEliminate,
    ended,
    createdAt,
    updatedAt,
    endedAt,
    firstTeam,
    secondTeam,
    scores,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'match_with_all_data';
  @override
  Map<SqlDialect, String> get createViewStatements => {
    SqlDialect.sqlite:
        'CREATE VIEW IF NOT EXISTS match_with_all_data AS SELECT CAST(m.id AS INT) AS id, CAST(m.name AS TEXT) AS name, CAST(m.event_id AS INT) AS eventId, CAST(m.first_team_id AS INT) AS firstTeamId, CAST(m.second_team_id AS INT) AS secondTeamId, CAST(m.max_score AS INT) AS maxScore, CAST(m.half_score_to_eliminate AS INT) AS halfScoreToEliminate, CAST(m.ended AS INT) AS ended, CAST(m.created_at AS TEXT) AS createdAt, CAST(m.updated_at AS TEXT) AS updatedAt, COALESCE(CAST(m.ended_at AS TEXT), \'\') AS endedAt, json_object(\'id\', t1.id, \'eventId\', t1.event_id, \'name\', t1.name, \'createdAt\', t1.created_at, \'updatedAt\', t1.updated_at, \'players\', COALESCE((SELECT json_group_array(json_object(\'id\', p.id, \'name\', p.name, \'gender\', p.gender, \'level\', p.level, \'createdAt\', p.created_at, \'updatedAt\', p.updated_at)) FROM tb_team_players AS tp JOIN tb_players AS p ON p.id = tp.player_id WHERE tp.team_id = t1.id), json(\'[]\'))) AS firstTeam, json_object(\'id\', t2.id, \'eventId\', t2.event_id, \'name\', t2.name, \'createdAt\', t2.created_at, \'updatedAt\', t2.updated_at, \'players\', COALESCE((SELECT json_group_array(json_object(\'id\', p.id, \'name\', p.name, \'gender\', p.gender, \'level\', p.level, \'createdAt\', p.created_at, \'updatedAt\', p.updated_at)) FROM tb_team_players AS tp JOIN tb_players AS p ON p.id = tp.player_id WHERE tp.team_id = t2.id), json(\'[]\'))) AS secondTeam, COALESCE((SELECT json_group_array(json_object(\'id\', s.id, \'matchId\', s.match_id, \'teamId\', s.team_id, \'reversed\', s.reversed, \'createdAt\', s.created_at, \'updatedAt\', s.updated_at)) FROM tb_match_scores AS s WHERE s.match_id = m.id ORDER BY s.created_at DESC), json(\'[]\')) AS scores FROM tb_matches AS m JOIN tb_teams AS t1 ON t1.id = m.first_team_id JOIN tb_teams AS t2 ON t2.id = m.second_team_id',
  };
  @override
  MatchWithAllData get asDslTable => this;
  @override
  MatchWithAllDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MatchWithAllDataData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}eventId'],
      )!,
      firstTeamId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}firstTeamId'],
      )!,
      secondTeamId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}secondTeamId'],
      )!,
      maxScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}maxScore'],
      )!,
      halfScoreToEliminate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}halfScoreToEliminate'],
      )!,
      ended: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ended'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}createdAt'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updatedAt'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}endedAt'],
      )!,
      firstTeam: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}firstTeam'],
      )!,
      secondTeam: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secondTeam'],
      )!,
      scores: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scores'],
      )!,
    );
  }

  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<int> eventId = GeneratedColumn<int>(
    'eventId',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<int> firstTeamId = GeneratedColumn<int>(
    'firstTeamId',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<int> secondTeamId = GeneratedColumn<int>(
    'secondTeamId',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<int> maxScore = GeneratedColumn<int>(
    'maxScore',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<bool> halfScoreToEliminate = GeneratedColumn<bool>(
    'halfScoreToEliminate',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("halfScoreToEliminate" IN (0, 1))',
    ),
  );
  late final GeneratedColumn<bool> ended = GeneratedColumn<bool>(
    'ended',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ended" IN (0, 1))',
    ),
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'createdAt',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updatedAt',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<String> endedAt = GeneratedColumn<String>(
    'endedAt',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<String> firstTeam = GeneratedColumn<String>(
    'firstTeam',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<String> secondTeam = GeneratedColumn<String>(
    'secondTeam',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<String> scores = GeneratedColumn<String>(
    'scores',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  @override
  MatchWithAllData createAlias(String alias) {
    return MatchWithAllData(attachedDatabase, alias);
  }

  @override
  Query? get query => null;
  @override
  Set<String> get readTables => const {};
}

class TeamWithPlayer extends DataClass {
  final int id;
  final int eventId;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String players;
  const TeamWithPlayer({
    required this.id,
    required this.eventId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.players,
  });
  factory TeamWithPlayer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamWithPlayer(
      id: serializer.fromJson<int>(json['id']),
      eventId: serializer.fromJson<int>(json['eventId']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      players: serializer.fromJson<String>(json['players']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventId': serializer.toJson<int>(eventId),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'players': serializer.toJson<String>(players),
    };
  }

  TeamWithPlayer copyWith({
    int? id,
    int? eventId,
    String? name,
    String? createdAt,
    String? updatedAt,
    String? players,
  }) => TeamWithPlayer(
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    players: players ?? this.players,
  );
  @override
  String toString() {
    return (StringBuffer('TeamWithPlayer(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('players: $players')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, eventId, name, createdAt, updatedAt, players);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamWithPlayer &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.players == this.players);
}

class TeamWithPlayers extends ViewInfo<TeamWithPlayers, TeamWithPlayer>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  TeamWithPlayers(this.attachedDatabase, [this._alias]);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventId,
    name,
    createdAt,
    updatedAt,
    players,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'team_with_players';
  @override
  Map<SqlDialect, String> get createViewStatements => {
    SqlDialect.sqlite:
        'CREATE VIEW IF NOT EXISTS team_with_players AS SELECT CAST(t.id AS INT) AS id, CAST(t.event_id AS INT) AS eventId, CAST(t.name AS TEXT) AS name, CAST(t.created_at AS TEXT) AS createdAt, CAST(t.updated_at AS TEXT) AS updatedAt, COALESCE((SELECT json_group_array(json_object(\'id\', p.id, \'name\', p.name, \'gender\', p.gender, \'level\', p.level, \'createdAt\', p.created_at, \'updatedAt\', p.updated_at)) FROM tb_team_players AS tp JOIN tb_players AS p ON p.id = tp.player_id WHERE tp.team_id = t.id), json(\'[]\')) AS players FROM tb_teams AS t',
  };
  @override
  TeamWithPlayers get asDslTable => this;
  @override
  TeamWithPlayer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeamWithPlayer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}eventId'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}createdAt'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updatedAt'],
      )!,
      players: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}players'],
      )!,
    );
  }

  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<int> eventId = GeneratedColumn<int>(
    'eventId',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'createdAt',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updatedAt',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<String> players = GeneratedColumn<String>(
    'players',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  @override
  TeamWithPlayers createAlias(String alias) {
    return TeamWithPlayers(attachedDatabase, alias);
  }

  @override
  Query? get query => null;
  @override
  Set<String> get readTables => const {};
}

class $EventTable extends Event with TableInfo<$EventTable, EventData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxScoreMeta = const VerificationMeta(
    'maxScore',
  );
  @override
  late final GeneratedColumn<int> maxScore = GeneratedColumn<int>(
    'max_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: () => 12,
  );
  static const VerificationMeta _maxPlayerPerTeamMeta = const VerificationMeta(
    'maxPlayerPerTeam',
  );
  @override
  late final GeneratedColumn<int> maxPlayerPerTeam = GeneratedColumn<int>(
    'max_player_per_team',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: () => 4,
  );
  static const VerificationMeta _balancedByGenderMeta = const VerificationMeta(
    'balancedByGender',
  );
  @override
  late final GeneratedColumn<bool> balancedByGender = GeneratedColumn<bool>(
    'balanced_by_gender',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("balanced_by_gender" IN (0, 1))',
    ),
    clientDefault: () => true,
  );
  static const VerificationMeta _balancedByLevelMeta = const VerificationMeta(
    'balancedByLevel',
  );
  @override
  late final GeneratedColumn<bool> balancedByLevel = GeneratedColumn<bool>(
    'balanced_by_level',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("balanced_by_level" IN (0, 1))',
    ),
    clientDefault: () => false,
  );
  static const VerificationMeta _maxWinsInARowMeta = const VerificationMeta(
    'maxWinsInARow',
  );
  @override
  late final GeneratedColumn<int> maxWinsInARow = GeneratedColumn<int>(
    'max_wins_in_a_row',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: () => 0,
  );
  static const VerificationMeta _halfScoreToEliminateMeta =
      const VerificationMeta('halfScoreToEliminate');
  @override
  late final GeneratedColumn<bool> halfScoreToEliminate = GeneratedColumn<bool>(
    'half_score_to_eliminate',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("half_score_to_eliminate" IN (0, 1))',
    ),
    clientDefault: () => false,
  );
  static const VerificationMeta _queueMeta = const VerificationMeta('queue');
  @override
  late final GeneratedColumn<String> queue = GeneratedColumn<String>(
    'queue',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => '',
  );
  static const VerificationMeta _endedMeta = const VerificationMeta('ended');
  @override
  late final GeneratedColumn<bool> ended = GeneratedColumn<bool>(
    'ended',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ended" IN (0, 1))',
    ),
    clientDefault: () => false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    maxScore,
    maxPlayerPerTeam,
    balancedByGender,
    balancedByLevel,
    maxWinsInARow,
    halfScoreToEliminate,
    queue,
    ended,
    createdAt,
    updatedAt,
    endedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('max_score')) {
      context.handle(
        _maxScoreMeta,
        maxScore.isAcceptableOrUnknown(data['max_score']!, _maxScoreMeta),
      );
    }
    if (data.containsKey('max_player_per_team')) {
      context.handle(
        _maxPlayerPerTeamMeta,
        maxPlayerPerTeam.isAcceptableOrUnknown(
          data['max_player_per_team']!,
          _maxPlayerPerTeamMeta,
        ),
      );
    }
    if (data.containsKey('balanced_by_gender')) {
      context.handle(
        _balancedByGenderMeta,
        balancedByGender.isAcceptableOrUnknown(
          data['balanced_by_gender']!,
          _balancedByGenderMeta,
        ),
      );
    }
    if (data.containsKey('balanced_by_level')) {
      context.handle(
        _balancedByLevelMeta,
        balancedByLevel.isAcceptableOrUnknown(
          data['balanced_by_level']!,
          _balancedByLevelMeta,
        ),
      );
    }
    if (data.containsKey('max_wins_in_a_row')) {
      context.handle(
        _maxWinsInARowMeta,
        maxWinsInARow.isAcceptableOrUnknown(
          data['max_wins_in_a_row']!,
          _maxWinsInARowMeta,
        ),
      );
    }
    if (data.containsKey('half_score_to_eliminate')) {
      context.handle(
        _halfScoreToEliminateMeta,
        halfScoreToEliminate.isAcceptableOrUnknown(
          data['half_score_to_eliminate']!,
          _halfScoreToEliminateMeta,
        ),
      );
    }
    if (data.containsKey('queue')) {
      context.handle(
        _queueMeta,
        queue.isAcceptableOrUnknown(data['queue']!, _queueMeta),
      );
    }
    if (data.containsKey('ended')) {
      context.handle(
        _endedMeta,
        ended.isAcceptableOrUnknown(data['ended']!, _endedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      maxScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_score'],
      )!,
      maxPlayerPerTeam: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_player_per_team'],
      )!,
      balancedByGender: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}balanced_by_gender'],
      )!,
      balancedByLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}balanced_by_level'],
      )!,
      maxWinsInARow: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_wins_in_a_row'],
      )!,
      halfScoreToEliminate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}half_score_to_eliminate'],
      )!,
      queue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}queue'],
      )!,
      ended: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ended'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
    );
  }

  @override
  $EventTable createAlias(String alias) {
    return $EventTable(attachedDatabase, alias);
  }
}

class EventData extends DataClass implements Insertable<EventData> {
  final int id;
  final String name;
  final int maxScore;
  final int maxPlayerPerTeam;
  final bool balancedByGender;
  final bool balancedByLevel;
  final int maxWinsInARow;
  final bool halfScoreToEliminate;
  final String queue;
  final bool ended;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? endedAt;
  const EventData({
    required this.id,
    required this.name,
    required this.maxScore,
    required this.maxPlayerPerTeam,
    required this.balancedByGender,
    required this.balancedByLevel,
    required this.maxWinsInARow,
    required this.halfScoreToEliminate,
    required this.queue,
    required this.ended,
    required this.createdAt,
    required this.updatedAt,
    this.endedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['max_score'] = Variable<int>(maxScore);
    map['max_player_per_team'] = Variable<int>(maxPlayerPerTeam);
    map['balanced_by_gender'] = Variable<bool>(balancedByGender);
    map['balanced_by_level'] = Variable<bool>(balancedByLevel);
    map['max_wins_in_a_row'] = Variable<int>(maxWinsInARow);
    map['half_score_to_eliminate'] = Variable<bool>(halfScoreToEliminate);
    map['queue'] = Variable<String>(queue);
    map['ended'] = Variable<bool>(ended);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    return map;
  }

  EventCompanion toCompanion(bool nullToAbsent) {
    return EventCompanion(
      id: Value(id),
      name: Value(name),
      maxScore: Value(maxScore),
      maxPlayerPerTeam: Value(maxPlayerPerTeam),
      balancedByGender: Value(balancedByGender),
      balancedByLevel: Value(balancedByLevel),
      maxWinsInARow: Value(maxWinsInARow),
      halfScoreToEliminate: Value(halfScoreToEliminate),
      queue: Value(queue),
      ended: Value(ended),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
    );
  }

  factory EventData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      maxScore: serializer.fromJson<int>(json['maxScore']),
      maxPlayerPerTeam: serializer.fromJson<int>(json['maxPlayerPerTeam']),
      balancedByGender: serializer.fromJson<bool>(json['balancedByGender']),
      balancedByLevel: serializer.fromJson<bool>(json['balancedByLevel']),
      maxWinsInARow: serializer.fromJson<int>(json['maxWinsInARow']),
      halfScoreToEliminate: serializer.fromJson<bool>(
        json['halfScoreToEliminate'],
      ),
      queue: serializer.fromJson<String>(json['queue']),
      ended: serializer.fromJson<bool>(json['ended']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'maxScore': serializer.toJson<int>(maxScore),
      'maxPlayerPerTeam': serializer.toJson<int>(maxPlayerPerTeam),
      'balancedByGender': serializer.toJson<bool>(balancedByGender),
      'balancedByLevel': serializer.toJson<bool>(balancedByLevel),
      'maxWinsInARow': serializer.toJson<int>(maxWinsInARow),
      'halfScoreToEliminate': serializer.toJson<bool>(halfScoreToEliminate),
      'queue': serializer.toJson<String>(queue),
      'ended': serializer.toJson<bool>(ended),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
    };
  }

  EventData copyWith({
    int? id,
    String? name,
    int? maxScore,
    int? maxPlayerPerTeam,
    bool? balancedByGender,
    bool? balancedByLevel,
    int? maxWinsInARow,
    bool? halfScoreToEliminate,
    String? queue,
    bool? ended,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> endedAt = const Value.absent(),
  }) => EventData(
    id: id ?? this.id,
    name: name ?? this.name,
    maxScore: maxScore ?? this.maxScore,
    maxPlayerPerTeam: maxPlayerPerTeam ?? this.maxPlayerPerTeam,
    balancedByGender: balancedByGender ?? this.balancedByGender,
    balancedByLevel: balancedByLevel ?? this.balancedByLevel,
    maxWinsInARow: maxWinsInARow ?? this.maxWinsInARow,
    halfScoreToEliminate: halfScoreToEliminate ?? this.halfScoreToEliminate,
    queue: queue ?? this.queue,
    ended: ended ?? this.ended,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
  );
  EventData copyWithCompanion(EventCompanion data) {
    return EventData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      maxScore: data.maxScore.present ? data.maxScore.value : this.maxScore,
      maxPlayerPerTeam: data.maxPlayerPerTeam.present
          ? data.maxPlayerPerTeam.value
          : this.maxPlayerPerTeam,
      balancedByGender: data.balancedByGender.present
          ? data.balancedByGender.value
          : this.balancedByGender,
      balancedByLevel: data.balancedByLevel.present
          ? data.balancedByLevel.value
          : this.balancedByLevel,
      maxWinsInARow: data.maxWinsInARow.present
          ? data.maxWinsInARow.value
          : this.maxWinsInARow,
      halfScoreToEliminate: data.halfScoreToEliminate.present
          ? data.halfScoreToEliminate.value
          : this.halfScoreToEliminate,
      queue: data.queue.present ? data.queue.value : this.queue,
      ended: data.ended.present ? data.ended.value : this.ended,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('maxScore: $maxScore, ')
          ..write('maxPlayerPerTeam: $maxPlayerPerTeam, ')
          ..write('balancedByGender: $balancedByGender, ')
          ..write('balancedByLevel: $balancedByLevel, ')
          ..write('maxWinsInARow: $maxWinsInARow, ')
          ..write('halfScoreToEliminate: $halfScoreToEliminate, ')
          ..write('queue: $queue, ')
          ..write('ended: $ended, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    maxScore,
    maxPlayerPerTeam,
    balancedByGender,
    balancedByLevel,
    maxWinsInARow,
    halfScoreToEliminate,
    queue,
    ended,
    createdAt,
    updatedAt,
    endedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventData &&
          other.id == this.id &&
          other.name == this.name &&
          other.maxScore == this.maxScore &&
          other.maxPlayerPerTeam == this.maxPlayerPerTeam &&
          other.balancedByGender == this.balancedByGender &&
          other.balancedByLevel == this.balancedByLevel &&
          other.maxWinsInARow == this.maxWinsInARow &&
          other.halfScoreToEliminate == this.halfScoreToEliminate &&
          other.queue == this.queue &&
          other.ended == this.ended &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.endedAt == this.endedAt);
}

class EventCompanion extends UpdateCompanion<EventData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> maxScore;
  final Value<int> maxPlayerPerTeam;
  final Value<bool> balancedByGender;
  final Value<bool> balancedByLevel;
  final Value<int> maxWinsInARow;
  final Value<bool> halfScoreToEliminate;
  final Value<String> queue;
  final Value<bool> ended;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> endedAt;
  const EventCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.maxScore = const Value.absent(),
    this.maxPlayerPerTeam = const Value.absent(),
    this.balancedByGender = const Value.absent(),
    this.balancedByLevel = const Value.absent(),
    this.maxWinsInARow = const Value.absent(),
    this.halfScoreToEliminate = const Value.absent(),
    this.queue = const Value.absent(),
    this.ended = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
  });
  EventCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.maxScore = const Value.absent(),
    this.maxPlayerPerTeam = const Value.absent(),
    this.balancedByGender = const Value.absent(),
    this.balancedByLevel = const Value.absent(),
    this.maxWinsInARow = const Value.absent(),
    this.halfScoreToEliminate = const Value.absent(),
    this.queue = const Value.absent(),
    this.ended = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<EventData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? maxScore,
    Expression<int>? maxPlayerPerTeam,
    Expression<bool>? balancedByGender,
    Expression<bool>? balancedByLevel,
    Expression<int>? maxWinsInARow,
    Expression<bool>? halfScoreToEliminate,
    Expression<String>? queue,
    Expression<bool>? ended,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? endedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (maxScore != null) 'max_score': maxScore,
      if (maxPlayerPerTeam != null) 'max_player_per_team': maxPlayerPerTeam,
      if (balancedByGender != null) 'balanced_by_gender': balancedByGender,
      if (balancedByLevel != null) 'balanced_by_level': balancedByLevel,
      if (maxWinsInARow != null) 'max_wins_in_a_row': maxWinsInARow,
      if (halfScoreToEliminate != null)
        'half_score_to_eliminate': halfScoreToEliminate,
      if (queue != null) 'queue': queue,
      if (ended != null) 'ended': ended,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (endedAt != null) 'ended_at': endedAt,
    });
  }

  EventCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? maxScore,
    Value<int>? maxPlayerPerTeam,
    Value<bool>? balancedByGender,
    Value<bool>? balancedByLevel,
    Value<int>? maxWinsInARow,
    Value<bool>? halfScoreToEliminate,
    Value<String>? queue,
    Value<bool>? ended,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? endedAt,
  }) {
    return EventCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      maxScore: maxScore ?? this.maxScore,
      maxPlayerPerTeam: maxPlayerPerTeam ?? this.maxPlayerPerTeam,
      balancedByGender: balancedByGender ?? this.balancedByGender,
      balancedByLevel: balancedByLevel ?? this.balancedByLevel,
      maxWinsInARow: maxWinsInARow ?? this.maxWinsInARow,
      halfScoreToEliminate: halfScoreToEliminate ?? this.halfScoreToEliminate,
      queue: queue ?? this.queue,
      ended: ended ?? this.ended,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      endedAt: endedAt ?? this.endedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (maxScore.present) {
      map['max_score'] = Variable<int>(maxScore.value);
    }
    if (maxPlayerPerTeam.present) {
      map['max_player_per_team'] = Variable<int>(maxPlayerPerTeam.value);
    }
    if (balancedByGender.present) {
      map['balanced_by_gender'] = Variable<bool>(balancedByGender.value);
    }
    if (balancedByLevel.present) {
      map['balanced_by_level'] = Variable<bool>(balancedByLevel.value);
    }
    if (maxWinsInARow.present) {
      map['max_wins_in_a_row'] = Variable<int>(maxWinsInARow.value);
    }
    if (halfScoreToEliminate.present) {
      map['half_score_to_eliminate'] = Variable<bool>(
        halfScoreToEliminate.value,
      );
    }
    if (queue.present) {
      map['queue'] = Variable<String>(queue.value);
    }
    if (ended.present) {
      map['ended'] = Variable<bool>(ended.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('maxScore: $maxScore, ')
          ..write('maxPlayerPerTeam: $maxPlayerPerTeam, ')
          ..write('balancedByGender: $balancedByGender, ')
          ..write('balancedByLevel: $balancedByLevel, ')
          ..write('maxWinsInARow: $maxWinsInARow, ')
          ..write('halfScoreToEliminate: $halfScoreToEliminate, ')
          ..write('queue: $queue, ')
          ..write('ended: $ended, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }
}

class $PlayerTable extends Player with TableInfo<$PlayerTable, PlayerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    false,
    check: () => gender.isIn(['male', 'female', 'unknown']),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => 'unknown',
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
    'level',
    aliasedName,
    false,
    check: () => level.isIn(['basic', 'intermediate', 'advanced']),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => 'basic',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    gender,
    level,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_players';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlayerData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {name, gender},
  ];
  @override
  PlayerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayerData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}level'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PlayerTable createAlias(String alias) {
    return $PlayerTable(attachedDatabase, alias);
  }
}

class PlayerData extends DataClass implements Insertable<PlayerData> {
  final int id;
  final String name;
  final String gender;
  final String level;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PlayerData({
    required this.id,
    required this.name,
    required this.gender,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['gender'] = Variable<String>(gender);
    map['level'] = Variable<String>(level);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PlayerCompanion toCompanion(bool nullToAbsent) {
    return PlayerCompanion(
      id: Value(id),
      name: Value(name),
      gender: Value(gender),
      level: Value(level),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PlayerData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayerData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      gender: serializer.fromJson<String>(json['gender']),
      level: serializer.fromJson<String>(json['level']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'gender': serializer.toJson<String>(gender),
      'level': serializer.toJson<String>(level),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PlayerData copyWith({
    int? id,
    String? name,
    String? gender,
    String? level,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PlayerData(
    id: id ?? this.id,
    name: name ?? this.name,
    gender: gender ?? this.gender,
    level: level ?? this.level,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PlayerData copyWithCompanion(PlayerCompanion data) {
    return PlayerData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      gender: data.gender.present ? data.gender.value : this.gender,
      level: data.level.present ? data.level.value : this.level,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayerData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('level: $level, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, gender, level, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerData &&
          other.id == this.id &&
          other.name == this.name &&
          other.gender == this.gender &&
          other.level == this.level &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PlayerCompanion extends UpdateCompanion<PlayerData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> gender;
  final Value<String> level;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PlayerCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.gender = const Value.absent(),
    this.level = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PlayerCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.gender = const Value.absent(),
    this.level = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<PlayerData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? gender,
    Expression<String>? level,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      if (level != null) 'level': level,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PlayerCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? gender,
    Value<String>? level,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return PlayerCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      level: level ?? this.level,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayerCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('level: $level, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TeamTable extends Team with TableInfo<$TeamTable, TeamData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<int> eventId = GeneratedColumn<int>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tb_events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventId,
    name,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_teams';
  @override
  VerificationContext validateIntegrity(
    Insertable<TeamData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TeamData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeamData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TeamTable createAlias(String alias) {
    return $TeamTable(attachedDatabase, alias);
  }
}

class TeamData extends DataClass implements Insertable<TeamData> {
  final int id;
  final int eventId;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TeamData({
    required this.id,
    required this.eventId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_id'] = Variable<int>(eventId);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TeamCompanion toCompanion(bool nullToAbsent) {
    return TeamCompanion(
      id: Value(id),
      eventId: Value(eventId),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TeamData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamData(
      id: serializer.fromJson<int>(json['id']),
      eventId: serializer.fromJson<int>(json['eventId']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventId': serializer.toJson<int>(eventId),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TeamData copyWith({
    int? id,
    int? eventId,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TeamData(
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TeamData copyWithCompanion(TeamCompanion data) {
    return TeamData(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeamData(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventId, name, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamData &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TeamCompanion extends UpdateCompanion<TeamData> {
  final Value<int> id;
  final Value<int> eventId;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TeamCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TeamCompanion.insert({
    this.id = const Value.absent(),
    required int eventId,
    required String name,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : eventId = Value(eventId),
       name = Value(name);
  static Insertable<TeamData> custom({
    Expression<int>? id,
    Expression<int>? eventId,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TeamCompanion copyWith({
    Value<int>? id,
    Value<int>? eventId,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return TeamCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<int>(eventId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TeamPlayerTable extends TeamPlayer
    with TableInfo<$TeamPlayerTable, TeamPlayerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamPlayerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<int> teamId = GeneratedColumn<int>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tb_teams (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<int> playerId = GeneratedColumn<int>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tb_players (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    teamId,
    playerId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_team_players';
  @override
  VerificationContext validateIntegrity(
    Insertable<TeamPlayerData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {teamId, playerId};
  @override
  TeamPlayerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeamPlayerData(
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}player_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TeamPlayerTable createAlias(String alias) {
    return $TeamPlayerTable(attachedDatabase, alias);
  }
}

class TeamPlayerData extends DataClass implements Insertable<TeamPlayerData> {
  final int teamId;
  final int playerId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TeamPlayerData({
    required this.teamId,
    required this.playerId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['team_id'] = Variable<int>(teamId);
    map['player_id'] = Variable<int>(playerId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TeamPlayerCompanion toCompanion(bool nullToAbsent) {
    return TeamPlayerCompanion(
      teamId: Value(teamId),
      playerId: Value(playerId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TeamPlayerData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamPlayerData(
      teamId: serializer.fromJson<int>(json['teamId']),
      playerId: serializer.fromJson<int>(json['playerId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'teamId': serializer.toJson<int>(teamId),
      'playerId': serializer.toJson<int>(playerId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TeamPlayerData copyWith({
    int? teamId,
    int? playerId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TeamPlayerData(
    teamId: teamId ?? this.teamId,
    playerId: playerId ?? this.playerId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TeamPlayerData copyWithCompanion(TeamPlayerCompanion data) {
    return TeamPlayerData(
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeamPlayerData(')
          ..write('teamId: $teamId, ')
          ..write('playerId: $playerId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(teamId, playerId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamPlayerData &&
          other.teamId == this.teamId &&
          other.playerId == this.playerId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TeamPlayerCompanion extends UpdateCompanion<TeamPlayerData> {
  final Value<int> teamId;
  final Value<int> playerId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TeamPlayerCompanion({
    this.teamId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TeamPlayerCompanion.insert({
    required int teamId,
    required int playerId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : teamId = Value(teamId),
       playerId = Value(playerId);
  static Insertable<TeamPlayerData> custom({
    Expression<int>? teamId,
    Expression<int>? playerId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (teamId != null) 'team_id': teamId,
      if (playerId != null) 'player_id': playerId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TeamPlayerCompanion copyWith({
    Value<int>? teamId,
    Value<int>? playerId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TeamPlayerCompanion(
      teamId: teamId ?? this.teamId,
      playerId: playerId ?? this.playerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (teamId.present) {
      map['team_id'] = Variable<int>(teamId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<int>(playerId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamPlayerCompanion(')
          ..write('teamId: $teamId, ')
          ..write('playerId: $playerId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MatchTable extends Match with TableInfo<$MatchTable, MatchData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<int> eventId = GeneratedColumn<int>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tb_events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _firstTeamIdMeta = const VerificationMeta(
    'firstTeamId',
  );
  @override
  late final GeneratedColumn<int> firstTeamId = GeneratedColumn<int>(
    'first_team_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tb_teams (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _secondTeamIdMeta = const VerificationMeta(
    'secondTeamId',
  );
  @override
  late final GeneratedColumn<int> secondTeamId = GeneratedColumn<int>(
    'second_team_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tb_teams (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxScoreMeta = const VerificationMeta(
    'maxScore',
  );
  @override
  late final GeneratedColumn<int> maxScore = GeneratedColumn<int>(
    'max_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _halfScoreToEliminateMeta =
      const VerificationMeta('halfScoreToEliminate');
  @override
  late final GeneratedColumn<bool> halfScoreToEliminate = GeneratedColumn<bool>(
    'half_score_to_eliminate',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("half_score_to_eliminate" IN (0, 1))',
    ),
  );
  static const VerificationMeta _endedMeta = const VerificationMeta('ended');
  @override
  late final GeneratedColumn<bool> ended = GeneratedColumn<bool>(
    'ended',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ended" IN (0, 1))',
    ),
    clientDefault: () => false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventId,
    firstTeamId,
    secondTeamId,
    name,
    maxScore,
    halfScoreToEliminate,
    ended,
    createdAt,
    updatedAt,
    endedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_matches';
  @override
  VerificationContext validateIntegrity(
    Insertable<MatchData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('first_team_id')) {
      context.handle(
        _firstTeamIdMeta,
        firstTeamId.isAcceptableOrUnknown(
          data['first_team_id']!,
          _firstTeamIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstTeamIdMeta);
    }
    if (data.containsKey('second_team_id')) {
      context.handle(
        _secondTeamIdMeta,
        secondTeamId.isAcceptableOrUnknown(
          data['second_team_id']!,
          _secondTeamIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_secondTeamIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('max_score')) {
      context.handle(
        _maxScoreMeta,
        maxScore.isAcceptableOrUnknown(data['max_score']!, _maxScoreMeta),
      );
    } else if (isInserting) {
      context.missing(_maxScoreMeta);
    }
    if (data.containsKey('half_score_to_eliminate')) {
      context.handle(
        _halfScoreToEliminateMeta,
        halfScoreToEliminate.isAcceptableOrUnknown(
          data['half_score_to_eliminate']!,
          _halfScoreToEliminateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_halfScoreToEliminateMeta);
    }
    if (data.containsKey('ended')) {
      context.handle(
        _endedMeta,
        ended.isAcceptableOrUnknown(data['ended']!, _endedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MatchData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MatchData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_id'],
      )!,
      firstTeamId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}first_team_id'],
      )!,
      secondTeamId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}second_team_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      maxScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_score'],
      )!,
      halfScoreToEliminate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}half_score_to_eliminate'],
      )!,
      ended: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ended'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
    );
  }

  @override
  $MatchTable createAlias(String alias) {
    return $MatchTable(attachedDatabase, alias);
  }
}

class MatchData extends DataClass implements Insertable<MatchData> {
  final int id;
  final int eventId;
  final int firstTeamId;
  final int secondTeamId;
  final String name;
  final int maxScore;
  final bool halfScoreToEliminate;
  final bool ended;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? endedAt;
  const MatchData({
    required this.id,
    required this.eventId,
    required this.firstTeamId,
    required this.secondTeamId,
    required this.name,
    required this.maxScore,
    required this.halfScoreToEliminate,
    required this.ended,
    required this.createdAt,
    required this.updatedAt,
    this.endedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_id'] = Variable<int>(eventId);
    map['first_team_id'] = Variable<int>(firstTeamId);
    map['second_team_id'] = Variable<int>(secondTeamId);
    map['name'] = Variable<String>(name);
    map['max_score'] = Variable<int>(maxScore);
    map['half_score_to_eliminate'] = Variable<bool>(halfScoreToEliminate);
    map['ended'] = Variable<bool>(ended);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    return map;
  }

  MatchCompanion toCompanion(bool nullToAbsent) {
    return MatchCompanion(
      id: Value(id),
      eventId: Value(eventId),
      firstTeamId: Value(firstTeamId),
      secondTeamId: Value(secondTeamId),
      name: Value(name),
      maxScore: Value(maxScore),
      halfScoreToEliminate: Value(halfScoreToEliminate),
      ended: Value(ended),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
    );
  }

  factory MatchData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MatchData(
      id: serializer.fromJson<int>(json['id']),
      eventId: serializer.fromJson<int>(json['eventId']),
      firstTeamId: serializer.fromJson<int>(json['firstTeamId']),
      secondTeamId: serializer.fromJson<int>(json['secondTeamId']),
      name: serializer.fromJson<String>(json['name']),
      maxScore: serializer.fromJson<int>(json['maxScore']),
      halfScoreToEliminate: serializer.fromJson<bool>(
        json['halfScoreToEliminate'],
      ),
      ended: serializer.fromJson<bool>(json['ended']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventId': serializer.toJson<int>(eventId),
      'firstTeamId': serializer.toJson<int>(firstTeamId),
      'secondTeamId': serializer.toJson<int>(secondTeamId),
      'name': serializer.toJson<String>(name),
      'maxScore': serializer.toJson<int>(maxScore),
      'halfScoreToEliminate': serializer.toJson<bool>(halfScoreToEliminate),
      'ended': serializer.toJson<bool>(ended),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
    };
  }

  MatchData copyWith({
    int? id,
    int? eventId,
    int? firstTeamId,
    int? secondTeamId,
    String? name,
    int? maxScore,
    bool? halfScoreToEliminate,
    bool? ended,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> endedAt = const Value.absent(),
  }) => MatchData(
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    firstTeamId: firstTeamId ?? this.firstTeamId,
    secondTeamId: secondTeamId ?? this.secondTeamId,
    name: name ?? this.name,
    maxScore: maxScore ?? this.maxScore,
    halfScoreToEliminate: halfScoreToEliminate ?? this.halfScoreToEliminate,
    ended: ended ?? this.ended,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
  );
  MatchData copyWithCompanion(MatchCompanion data) {
    return MatchData(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      firstTeamId: data.firstTeamId.present
          ? data.firstTeamId.value
          : this.firstTeamId,
      secondTeamId: data.secondTeamId.present
          ? data.secondTeamId.value
          : this.secondTeamId,
      name: data.name.present ? data.name.value : this.name,
      maxScore: data.maxScore.present ? data.maxScore.value : this.maxScore,
      halfScoreToEliminate: data.halfScoreToEliminate.present
          ? data.halfScoreToEliminate.value
          : this.halfScoreToEliminate,
      ended: data.ended.present ? data.ended.value : this.ended,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MatchData(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('firstTeamId: $firstTeamId, ')
          ..write('secondTeamId: $secondTeamId, ')
          ..write('name: $name, ')
          ..write('maxScore: $maxScore, ')
          ..write('halfScoreToEliminate: $halfScoreToEliminate, ')
          ..write('ended: $ended, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    eventId,
    firstTeamId,
    secondTeamId,
    name,
    maxScore,
    halfScoreToEliminate,
    ended,
    createdAt,
    updatedAt,
    endedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchData &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.firstTeamId == this.firstTeamId &&
          other.secondTeamId == this.secondTeamId &&
          other.name == this.name &&
          other.maxScore == this.maxScore &&
          other.halfScoreToEliminate == this.halfScoreToEliminate &&
          other.ended == this.ended &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.endedAt == this.endedAt);
}

class MatchCompanion extends UpdateCompanion<MatchData> {
  final Value<int> id;
  final Value<int> eventId;
  final Value<int> firstTeamId;
  final Value<int> secondTeamId;
  final Value<String> name;
  final Value<int> maxScore;
  final Value<bool> halfScoreToEliminate;
  final Value<bool> ended;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> endedAt;
  const MatchCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.firstTeamId = const Value.absent(),
    this.secondTeamId = const Value.absent(),
    this.name = const Value.absent(),
    this.maxScore = const Value.absent(),
    this.halfScoreToEliminate = const Value.absent(),
    this.ended = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
  });
  MatchCompanion.insert({
    this.id = const Value.absent(),
    required int eventId,
    required int firstTeamId,
    required int secondTeamId,
    required String name,
    required int maxScore,
    required bool halfScoreToEliminate,
    this.ended = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
  }) : eventId = Value(eventId),
       firstTeamId = Value(firstTeamId),
       secondTeamId = Value(secondTeamId),
       name = Value(name),
       maxScore = Value(maxScore),
       halfScoreToEliminate = Value(halfScoreToEliminate);
  static Insertable<MatchData> custom({
    Expression<int>? id,
    Expression<int>? eventId,
    Expression<int>? firstTeamId,
    Expression<int>? secondTeamId,
    Expression<String>? name,
    Expression<int>? maxScore,
    Expression<bool>? halfScoreToEliminate,
    Expression<bool>? ended,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? endedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (firstTeamId != null) 'first_team_id': firstTeamId,
      if (secondTeamId != null) 'second_team_id': secondTeamId,
      if (name != null) 'name': name,
      if (maxScore != null) 'max_score': maxScore,
      if (halfScoreToEliminate != null)
        'half_score_to_eliminate': halfScoreToEliminate,
      if (ended != null) 'ended': ended,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (endedAt != null) 'ended_at': endedAt,
    });
  }

  MatchCompanion copyWith({
    Value<int>? id,
    Value<int>? eventId,
    Value<int>? firstTeamId,
    Value<int>? secondTeamId,
    Value<String>? name,
    Value<int>? maxScore,
    Value<bool>? halfScoreToEliminate,
    Value<bool>? ended,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? endedAt,
  }) {
    return MatchCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      firstTeamId: firstTeamId ?? this.firstTeamId,
      secondTeamId: secondTeamId ?? this.secondTeamId,
      name: name ?? this.name,
      maxScore: maxScore ?? this.maxScore,
      halfScoreToEliminate: halfScoreToEliminate ?? this.halfScoreToEliminate,
      ended: ended ?? this.ended,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      endedAt: endedAt ?? this.endedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<int>(eventId.value);
    }
    if (firstTeamId.present) {
      map['first_team_id'] = Variable<int>(firstTeamId.value);
    }
    if (secondTeamId.present) {
      map['second_team_id'] = Variable<int>(secondTeamId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (maxScore.present) {
      map['max_score'] = Variable<int>(maxScore.value);
    }
    if (halfScoreToEliminate.present) {
      map['half_score_to_eliminate'] = Variable<bool>(
        halfScoreToEliminate.value,
      );
    }
    if (ended.present) {
      map['ended'] = Variable<bool>(ended.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('firstTeamId: $firstTeamId, ')
          ..write('secondTeamId: $secondTeamId, ')
          ..write('name: $name, ')
          ..write('maxScore: $maxScore, ')
          ..write('halfScoreToEliminate: $halfScoreToEliminate, ')
          ..write('ended: $ended, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }
}

class $ScoreTable extends Score with TableInfo<$ScoreTable, ScoreData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScoreTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _matchIdMeta = const VerificationMeta(
    'matchId',
  );
  @override
  late final GeneratedColumn<int> matchId = GeneratedColumn<int>(
    'match_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tb_matches (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<int> teamId = GeneratedColumn<int>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tb_teams (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _reversedMeta = const VerificationMeta(
    'reversed',
  );
  @override
  late final GeneratedColumn<bool> reversed = GeneratedColumn<bool>(
    'reversed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reversed" IN (0, 1))',
    ),
    clientDefault: () => false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    matchId,
    teamId,
    reversed,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_match_scores';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScoreData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('match_id')) {
      context.handle(
        _matchIdMeta,
        matchId.isAcceptableOrUnknown(data['match_id']!, _matchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_matchIdMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('reversed')) {
      context.handle(
        _reversedMeta,
        reversed.isAcceptableOrUnknown(data['reversed']!, _reversedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScoreData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScoreData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      matchId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}match_id'],
      )!,
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}team_id'],
      )!,
      reversed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reversed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ScoreTable createAlias(String alias) {
    return $ScoreTable(attachedDatabase, alias);
  }
}

class ScoreData extends DataClass implements Insertable<ScoreData> {
  final int id;
  final int matchId;
  final int teamId;
  final bool reversed;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ScoreData({
    required this.id,
    required this.matchId,
    required this.teamId,
    required this.reversed,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['match_id'] = Variable<int>(matchId);
    map['team_id'] = Variable<int>(teamId);
    map['reversed'] = Variable<bool>(reversed);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ScoreCompanion toCompanion(bool nullToAbsent) {
    return ScoreCompanion(
      id: Value(id),
      matchId: Value(matchId),
      teamId: Value(teamId),
      reversed: Value(reversed),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ScoreData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScoreData(
      id: serializer.fromJson<int>(json['id']),
      matchId: serializer.fromJson<int>(json['matchId']),
      teamId: serializer.fromJson<int>(json['teamId']),
      reversed: serializer.fromJson<bool>(json['reversed']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'matchId': serializer.toJson<int>(matchId),
      'teamId': serializer.toJson<int>(teamId),
      'reversed': serializer.toJson<bool>(reversed),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ScoreData copyWith({
    int? id,
    int? matchId,
    int? teamId,
    bool? reversed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ScoreData(
    id: id ?? this.id,
    matchId: matchId ?? this.matchId,
    teamId: teamId ?? this.teamId,
    reversed: reversed ?? this.reversed,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ScoreData copyWithCompanion(ScoreCompanion data) {
    return ScoreData(
      id: data.id.present ? data.id.value : this.id,
      matchId: data.matchId.present ? data.matchId.value : this.matchId,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      reversed: data.reversed.present ? data.reversed.value : this.reversed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScoreData(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('teamId: $teamId, ')
          ..write('reversed: $reversed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, matchId, teamId, reversed, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScoreData &&
          other.id == this.id &&
          other.matchId == this.matchId &&
          other.teamId == this.teamId &&
          other.reversed == this.reversed &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ScoreCompanion extends UpdateCompanion<ScoreData> {
  final Value<int> id;
  final Value<int> matchId;
  final Value<int> teamId;
  final Value<bool> reversed;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ScoreCompanion({
    this.id = const Value.absent(),
    this.matchId = const Value.absent(),
    this.teamId = const Value.absent(),
    this.reversed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ScoreCompanion.insert({
    this.id = const Value.absent(),
    required int matchId,
    required int teamId,
    this.reversed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : matchId = Value(matchId),
       teamId = Value(teamId);
  static Insertable<ScoreData> custom({
    Expression<int>? id,
    Expression<int>? matchId,
    Expression<int>? teamId,
    Expression<bool>? reversed,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (matchId != null) 'match_id': matchId,
      if (teamId != null) 'team_id': teamId,
      if (reversed != null) 'reversed': reversed,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ScoreCompanion copyWith({
    Value<int>? id,
    Value<int>? matchId,
    Value<int>? teamId,
    Value<bool>? reversed,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ScoreCompanion(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      teamId: teamId ?? this.teamId,
      reversed: reversed ?? this.reversed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (matchId.present) {
      map['match_id'] = Variable<int>(matchId.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<int>(teamId.value);
    }
    if (reversed.present) {
      map['reversed'] = Variable<bool>(reversed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScoreCompanion(')
          ..write('id: $id, ')
          ..write('matchId: $matchId, ')
          ..write('teamId: $teamId, ')
          ..write('reversed: $reversed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final EventWithAllData eventWithAllData = EventWithAllData(this);
  late final EventWithLastMatch eventWithLastMatch = EventWithLastMatch(this);
  late final MatchWithAllData matchWithAllData = MatchWithAllData(this);
  late final TeamWithPlayers teamWithPlayers = TeamWithPlayers(this);
  late final $EventTable event = $EventTable(this);
  late final $PlayerTable player = $PlayerTable(this);
  late final $TeamTable team = $TeamTable(this);
  late final $TeamPlayerTable teamPlayer = $TeamPlayerTable(this);
  late final $MatchTable match = $MatchTable(this);
  late final $ScoreTable score = $ScoreTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    eventWithAllData,
    eventWithLastMatch,
    matchWithAllData,
    teamWithPlayers,
    event,
    player,
    team,
    teamPlayer,
    match,
    score,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tb_events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tb_teams', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tb_teams',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tb_team_players', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tb_players',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tb_team_players', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tb_events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tb_matches', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tb_teams',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tb_matches', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tb_teams',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tb_matches', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tb_matches',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tb_match_scores', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tb_teams',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tb_match_scores', kind: UpdateKind.delete)],
    ),
  ]);
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$EventTableCreateCompanionBuilder =
    EventCompanion Function({
      Value<int> id,
      required String name,
      Value<int> maxScore,
      Value<int> maxPlayerPerTeam,
      Value<bool> balancedByGender,
      Value<bool> balancedByLevel,
      Value<int> maxWinsInARow,
      Value<bool> halfScoreToEliminate,
      Value<String> queue,
      Value<bool> ended,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> endedAt,
    });
typedef $$EventTableUpdateCompanionBuilder =
    EventCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> maxScore,
      Value<int> maxPlayerPerTeam,
      Value<bool> balancedByGender,
      Value<bool> balancedByLevel,
      Value<int> maxWinsInARow,
      Value<bool> halfScoreToEliminate,
      Value<String> queue,
      Value<bool> ended,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> endedAt,
    });

final class $$EventTableReferences
    extends BaseReferences<_$AppDatabase, $EventTable, EventData> {
  $$EventTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TeamTable, List<TeamData>> _teamRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.team,
    aliasName: $_aliasNameGenerator(db.event.id, db.team.eventId),
  );

  $$TeamTableProcessedTableManager get teamRefs {
    final manager = $$TeamTableTableManager(
      $_db,
      $_db.team,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_teamRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MatchTable, List<MatchData>> _matchRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.match,
    aliasName: $_aliasNameGenerator(db.event.id, db.match.eventId),
  );

  $$MatchTableProcessedTableManager get matchRefs {
    final manager = $$MatchTableTableManager(
      $_db,
      $_db.match,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_matchRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EventTableFilterComposer extends Composer<_$AppDatabase, $EventTable> {
  $$EventTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxScore => $composableBuilder(
    column: $table.maxScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxPlayerPerTeam => $composableBuilder(
    column: $table.maxPlayerPerTeam,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get balancedByGender => $composableBuilder(
    column: $table.balancedByGender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get balancedByLevel => $composableBuilder(
    column: $table.balancedByLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxWinsInARow => $composableBuilder(
    column: $table.maxWinsInARow,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get halfScoreToEliminate => $composableBuilder(
    column: $table.halfScoreToEliminate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get queue => $composableBuilder(
    column: $table.queue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get ended => $composableBuilder(
    column: $table.ended,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> teamRefs(
    Expression<bool> Function($$TeamTableFilterComposer f) f,
  ) {
    final $$TeamTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.team,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamTableFilterComposer(
            $db: $db,
            $table: $db.team,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> matchRefs(
    Expression<bool> Function($$MatchTableFilterComposer f) f,
  ) {
    final $$MatchTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.match,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchTableFilterComposer(
            $db: $db,
            $table: $db.match,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EventTableOrderingComposer
    extends Composer<_$AppDatabase, $EventTable> {
  $$EventTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxScore => $composableBuilder(
    column: $table.maxScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxPlayerPerTeam => $composableBuilder(
    column: $table.maxPlayerPerTeam,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get balancedByGender => $composableBuilder(
    column: $table.balancedByGender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get balancedByLevel => $composableBuilder(
    column: $table.balancedByLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxWinsInARow => $composableBuilder(
    column: $table.maxWinsInARow,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get halfScoreToEliminate => $composableBuilder(
    column: $table.halfScoreToEliminate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get queue => $composableBuilder(
    column: $table.queue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get ended => $composableBuilder(
    column: $table.ended,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EventTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventTable> {
  $$EventTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get maxScore =>
      $composableBuilder(column: $table.maxScore, builder: (column) => column);

  GeneratedColumn<int> get maxPlayerPerTeam => $composableBuilder(
    column: $table.maxPlayerPerTeam,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get balancedByGender => $composableBuilder(
    column: $table.balancedByGender,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get balancedByLevel => $composableBuilder(
    column: $table.balancedByLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxWinsInARow => $composableBuilder(
    column: $table.maxWinsInARow,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get halfScoreToEliminate => $composableBuilder(
    column: $table.halfScoreToEliminate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get queue =>
      $composableBuilder(column: $table.queue, builder: (column) => column);

  GeneratedColumn<bool> get ended =>
      $composableBuilder(column: $table.ended, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  Expression<T> teamRefs<T extends Object>(
    Expression<T> Function($$TeamTableAnnotationComposer a) f,
  ) {
    final $$TeamTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.team,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamTableAnnotationComposer(
            $db: $db,
            $table: $db.team,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> matchRefs<T extends Object>(
    Expression<T> Function($$MatchTableAnnotationComposer a) f,
  ) {
    final $$MatchTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.match,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchTableAnnotationComposer(
            $db: $db,
            $table: $db.match,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EventTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventTable,
          EventData,
          $$EventTableFilterComposer,
          $$EventTableOrderingComposer,
          $$EventTableAnnotationComposer,
          $$EventTableCreateCompanionBuilder,
          $$EventTableUpdateCompanionBuilder,
          (EventData, $$EventTableReferences),
          EventData,
          PrefetchHooks Function({bool teamRefs, bool matchRefs})
        > {
  $$EventTableTableManager(_$AppDatabase db, $EventTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> maxScore = const Value.absent(),
                Value<int> maxPlayerPerTeam = const Value.absent(),
                Value<bool> balancedByGender = const Value.absent(),
                Value<bool> balancedByLevel = const Value.absent(),
                Value<int> maxWinsInARow = const Value.absent(),
                Value<bool> halfScoreToEliminate = const Value.absent(),
                Value<String> queue = const Value.absent(),
                Value<bool> ended = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
              }) => EventCompanion(
                id: id,
                name: name,
                maxScore: maxScore,
                maxPlayerPerTeam: maxPlayerPerTeam,
                balancedByGender: balancedByGender,
                balancedByLevel: balancedByLevel,
                maxWinsInARow: maxWinsInARow,
                halfScoreToEliminate: halfScoreToEliminate,
                queue: queue,
                ended: ended,
                createdAt: createdAt,
                updatedAt: updatedAt,
                endedAt: endedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<int> maxScore = const Value.absent(),
                Value<int> maxPlayerPerTeam = const Value.absent(),
                Value<bool> balancedByGender = const Value.absent(),
                Value<bool> balancedByLevel = const Value.absent(),
                Value<int> maxWinsInARow = const Value.absent(),
                Value<bool> halfScoreToEliminate = const Value.absent(),
                Value<String> queue = const Value.absent(),
                Value<bool> ended = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
              }) => EventCompanion.insert(
                id: id,
                name: name,
                maxScore: maxScore,
                maxPlayerPerTeam: maxPlayerPerTeam,
                balancedByGender: balancedByGender,
                balancedByLevel: balancedByLevel,
                maxWinsInARow: maxWinsInARow,
                halfScoreToEliminate: halfScoreToEliminate,
                queue: queue,
                ended: ended,
                createdAt: createdAt,
                updatedAt: updatedAt,
                endedAt: endedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$EventTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({teamRefs = false, matchRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (teamRefs) db.team,
                if (matchRefs) db.match,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (teamRefs)
                    await $_getPrefetchedData<EventData, $EventTable, TeamData>(
                      currentTable: table,
                      referencedTable: $$EventTableReferences._teamRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$EventTableReferences(db, table, p0).teamRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.eventId == item.id),
                      typedResults: items,
                    ),
                  if (matchRefs)
                    await $_getPrefetchedData<
                      EventData,
                      $EventTable,
                      MatchData
                    >(
                      currentTable: table,
                      referencedTable: $$EventTableReferences._matchRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$EventTableReferences(db, table, p0).matchRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.eventId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EventTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventTable,
      EventData,
      $$EventTableFilterComposer,
      $$EventTableOrderingComposer,
      $$EventTableAnnotationComposer,
      $$EventTableCreateCompanionBuilder,
      $$EventTableUpdateCompanionBuilder,
      (EventData, $$EventTableReferences),
      EventData,
      PrefetchHooks Function({bool teamRefs, bool matchRefs})
    >;
typedef $$PlayerTableCreateCompanionBuilder =
    PlayerCompanion Function({
      Value<int> id,
      required String name,
      Value<String> gender,
      Value<String> level,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$PlayerTableUpdateCompanionBuilder =
    PlayerCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> gender,
      Value<String> level,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$PlayerTableReferences
    extends BaseReferences<_$AppDatabase, $PlayerTable, PlayerData> {
  $$PlayerTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TeamPlayerTable, List<TeamPlayerData>>
  _teamPlayerRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.teamPlayer,
    aliasName: $_aliasNameGenerator(db.player.id, db.teamPlayer.playerId),
  );

  $$TeamPlayerTableProcessedTableManager get teamPlayerRefs {
    final manager = $$TeamPlayerTableTableManager(
      $_db,
      $_db.teamPlayer,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_teamPlayerRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlayerTableFilterComposer
    extends Composer<_$AppDatabase, $PlayerTable> {
  $$PlayerTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> teamPlayerRefs(
    Expression<bool> Function($$TeamPlayerTableFilterComposer f) f,
  ) {
    final $$TeamPlayerTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamPlayer,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamPlayerTableFilterComposer(
            $db: $db,
            $table: $db.teamPlayer,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayerTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayerTable> {
  $$PlayerTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlayerTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayerTable> {
  $$PlayerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> teamPlayerRefs<T extends Object>(
    Expression<T> Function($$TeamPlayerTableAnnotationComposer a) f,
  ) {
    final $$TeamPlayerTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamPlayer,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamPlayerTableAnnotationComposer(
            $db: $db,
            $table: $db.teamPlayer,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayerTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayerTable,
          PlayerData,
          $$PlayerTableFilterComposer,
          $$PlayerTableOrderingComposer,
          $$PlayerTableAnnotationComposer,
          $$PlayerTableCreateCompanionBuilder,
          $$PlayerTableUpdateCompanionBuilder,
          (PlayerData, $$PlayerTableReferences),
          PlayerData,
          PrefetchHooks Function({bool teamPlayerRefs})
        > {
  $$PlayerTableTableManager(_$AppDatabase db, $PlayerTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> gender = const Value.absent(),
                Value<String> level = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PlayerCompanion(
                id: id,
                name: name,
                gender: gender,
                level: level,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> gender = const Value.absent(),
                Value<String> level = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PlayerCompanion.insert(
                id: id,
                name: name,
                gender: gender,
                level: level,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PlayerTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({teamPlayerRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (teamPlayerRefs) db.teamPlayer],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (teamPlayerRefs)
                    await $_getPrefetchedData<
                      PlayerData,
                      $PlayerTable,
                      TeamPlayerData
                    >(
                      currentTable: table,
                      referencedTable: $$PlayerTableReferences
                          ._teamPlayerRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PlayerTableReferences(db, table, p0).teamPlayerRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.playerId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PlayerTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayerTable,
      PlayerData,
      $$PlayerTableFilterComposer,
      $$PlayerTableOrderingComposer,
      $$PlayerTableAnnotationComposer,
      $$PlayerTableCreateCompanionBuilder,
      $$PlayerTableUpdateCompanionBuilder,
      (PlayerData, $$PlayerTableReferences),
      PlayerData,
      PrefetchHooks Function({bool teamPlayerRefs})
    >;
typedef $$TeamTableCreateCompanionBuilder =
    TeamCompanion Function({
      Value<int> id,
      required int eventId,
      required String name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$TeamTableUpdateCompanionBuilder =
    TeamCompanion Function({
      Value<int> id,
      Value<int> eventId,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$TeamTableReferences
    extends BaseReferences<_$AppDatabase, $TeamTable, TeamData> {
  $$TeamTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EventTable _eventIdTable(_$AppDatabase db) =>
      db.event.createAlias($_aliasNameGenerator(db.team.eventId, db.event.id));

  $$EventTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<int>('event_id')!;

    final manager = $$EventTableTableManager(
      $_db,
      $_db.event,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TeamPlayerTable, List<TeamPlayerData>>
  _teamPlayerRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.teamPlayer,
    aliasName: $_aliasNameGenerator(db.team.id, db.teamPlayer.teamId),
  );

  $$TeamPlayerTableProcessedTableManager get teamPlayerRefs {
    final manager = $$TeamPlayerTableTableManager(
      $_db,
      $_db.teamPlayer,
    ).filter((f) => f.teamId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_teamPlayerRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ScoreTable, List<ScoreData>> _scoreRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.score,
    aliasName: $_aliasNameGenerator(db.team.id, db.score.teamId),
  );

  $$ScoreTableProcessedTableManager get scoreRefs {
    final manager = $$ScoreTableTableManager(
      $_db,
      $_db.score,
    ).filter((f) => f.teamId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_scoreRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TeamTableFilterComposer extends Composer<_$AppDatabase, $TeamTable> {
  $$TeamTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EventTableFilterComposer get eventId {
    final $$EventTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.event,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventTableFilterComposer(
            $db: $db,
            $table: $db.event,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> teamPlayerRefs(
    Expression<bool> Function($$TeamPlayerTableFilterComposer f) f,
  ) {
    final $$TeamPlayerTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamPlayer,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamPlayerTableFilterComposer(
            $db: $db,
            $table: $db.teamPlayer,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scoreRefs(
    Expression<bool> Function($$ScoreTableFilterComposer f) f,
  ) {
    final $$ScoreTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.score,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScoreTableFilterComposer(
            $db: $db,
            $table: $db.score,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TeamTableOrderingComposer extends Composer<_$AppDatabase, $TeamTable> {
  $$TeamTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventTableOrderingComposer get eventId {
    final $$EventTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.event,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventTableOrderingComposer(
            $db: $db,
            $table: $db.event,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TeamTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamTable> {
  $$TeamTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$EventTableAnnotationComposer get eventId {
    final $$EventTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.event,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventTableAnnotationComposer(
            $db: $db,
            $table: $db.event,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> teamPlayerRefs<T extends Object>(
    Expression<T> Function($$TeamPlayerTableAnnotationComposer a) f,
  ) {
    final $$TeamPlayerTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.teamPlayer,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamPlayerTableAnnotationComposer(
            $db: $db,
            $table: $db.teamPlayer,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> scoreRefs<T extends Object>(
    Expression<T> Function($$ScoreTableAnnotationComposer a) f,
  ) {
    final $$ScoreTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.score,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScoreTableAnnotationComposer(
            $db: $db,
            $table: $db.score,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TeamTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeamTable,
          TeamData,
          $$TeamTableFilterComposer,
          $$TeamTableOrderingComposer,
          $$TeamTableAnnotationComposer,
          $$TeamTableCreateCompanionBuilder,
          $$TeamTableUpdateCompanionBuilder,
          (TeamData, $$TeamTableReferences),
          TeamData,
          PrefetchHooks Function({
            bool eventId,
            bool teamPlayerRefs,
            bool scoreRefs,
          })
        > {
  $$TeamTableTableManager(_$AppDatabase db, $TeamTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> eventId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TeamCompanion(
                id: id,
                eventId: eventId,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int eventId,
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TeamCompanion.insert(
                id: id,
                eventId: eventId,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TeamTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({eventId = false, teamPlayerRefs = false, scoreRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (teamPlayerRefs) db.teamPlayer,
                    if (scoreRefs) db.score,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (eventId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.eventId,
                                    referencedTable: $$TeamTableReferences
                                        ._eventIdTable(db),
                                    referencedColumn: $$TeamTableReferences
                                        ._eventIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (teamPlayerRefs)
                        await $_getPrefetchedData<
                          TeamData,
                          $TeamTable,
                          TeamPlayerData
                        >(
                          currentTable: table,
                          referencedTable: $$TeamTableReferences
                              ._teamPlayerRefsTable(db),
                          managerFromTypedResult: (p0) => $$TeamTableReferences(
                            db,
                            table,
                            p0,
                          ).teamPlayerRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.teamId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (scoreRefs)
                        await $_getPrefetchedData<
                          TeamData,
                          $TeamTable,
                          ScoreData
                        >(
                          currentTable: table,
                          referencedTable: $$TeamTableReferences
                              ._scoreRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TeamTableReferences(db, table, p0).scoreRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.teamId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TeamTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeamTable,
      TeamData,
      $$TeamTableFilterComposer,
      $$TeamTableOrderingComposer,
      $$TeamTableAnnotationComposer,
      $$TeamTableCreateCompanionBuilder,
      $$TeamTableUpdateCompanionBuilder,
      (TeamData, $$TeamTableReferences),
      TeamData,
      PrefetchHooks Function({
        bool eventId,
        bool teamPlayerRefs,
        bool scoreRefs,
      })
    >;
typedef $$TeamPlayerTableCreateCompanionBuilder =
    TeamPlayerCompanion Function({
      required int teamId,
      required int playerId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$TeamPlayerTableUpdateCompanionBuilder =
    TeamPlayerCompanion Function({
      Value<int> teamId,
      Value<int> playerId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$TeamPlayerTableReferences
    extends BaseReferences<_$AppDatabase, $TeamPlayerTable, TeamPlayerData> {
  $$TeamPlayerTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TeamTable _teamIdTable(_$AppDatabase db) => db.team.createAlias(
    $_aliasNameGenerator(db.teamPlayer.teamId, db.team.id),
  );

  $$TeamTableProcessedTableManager get teamId {
    final $_column = $_itemColumn<int>('team_id')!;

    final manager = $$TeamTableTableManager(
      $_db,
      $_db.team,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PlayerTable _playerIdTable(_$AppDatabase db) => db.player.createAlias(
    $_aliasNameGenerator(db.teamPlayer.playerId, db.player.id),
  );

  $$PlayerTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<int>('player_id')!;

    final manager = $$PlayerTableTableManager(
      $_db,
      $_db.player,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TeamPlayerTableFilterComposer
    extends Composer<_$AppDatabase, $TeamPlayerTable> {
  $$TeamPlayerTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TeamTableFilterComposer get teamId {
    final $$TeamTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.team,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamTableFilterComposer(
            $db: $db,
            $table: $db.team,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayerTableFilterComposer get playerId {
    final $$PlayerTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.player,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableFilterComposer(
            $db: $db,
            $table: $db.player,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TeamPlayerTableOrderingComposer
    extends Composer<_$AppDatabase, $TeamPlayerTable> {
  $$TeamPlayerTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TeamTableOrderingComposer get teamId {
    final $$TeamTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.team,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamTableOrderingComposer(
            $db: $db,
            $table: $db.team,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayerTableOrderingComposer get playerId {
    final $$PlayerTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.player,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableOrderingComposer(
            $db: $db,
            $table: $db.player,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TeamPlayerTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamPlayerTable> {
  $$TeamPlayerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TeamTableAnnotationComposer get teamId {
    final $$TeamTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.team,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamTableAnnotationComposer(
            $db: $db,
            $table: $db.team,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayerTableAnnotationComposer get playerId {
    final $$PlayerTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.player,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerTableAnnotationComposer(
            $db: $db,
            $table: $db.player,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TeamPlayerTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeamPlayerTable,
          TeamPlayerData,
          $$TeamPlayerTableFilterComposer,
          $$TeamPlayerTableOrderingComposer,
          $$TeamPlayerTableAnnotationComposer,
          $$TeamPlayerTableCreateCompanionBuilder,
          $$TeamPlayerTableUpdateCompanionBuilder,
          (TeamPlayerData, $$TeamPlayerTableReferences),
          TeamPlayerData,
          PrefetchHooks Function({bool teamId, bool playerId})
        > {
  $$TeamPlayerTableTableManager(_$AppDatabase db, $TeamPlayerTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamPlayerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamPlayerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamPlayerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> teamId = const Value.absent(),
                Value<int> playerId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TeamPlayerCompanion(
                teamId: teamId,
                playerId: playerId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int teamId,
                required int playerId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TeamPlayerCompanion.insert(
                teamId: teamId,
                playerId: playerId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TeamPlayerTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({teamId = false, playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (teamId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.teamId,
                                referencedTable: $$TeamPlayerTableReferences
                                    ._teamIdTable(db),
                                referencedColumn: $$TeamPlayerTableReferences
                                    ._teamIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (playerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.playerId,
                                referencedTable: $$TeamPlayerTableReferences
                                    ._playerIdTable(db),
                                referencedColumn: $$TeamPlayerTableReferences
                                    ._playerIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TeamPlayerTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeamPlayerTable,
      TeamPlayerData,
      $$TeamPlayerTableFilterComposer,
      $$TeamPlayerTableOrderingComposer,
      $$TeamPlayerTableAnnotationComposer,
      $$TeamPlayerTableCreateCompanionBuilder,
      $$TeamPlayerTableUpdateCompanionBuilder,
      (TeamPlayerData, $$TeamPlayerTableReferences),
      TeamPlayerData,
      PrefetchHooks Function({bool teamId, bool playerId})
    >;
typedef $$MatchTableCreateCompanionBuilder =
    MatchCompanion Function({
      Value<int> id,
      required int eventId,
      required int firstTeamId,
      required int secondTeamId,
      required String name,
      required int maxScore,
      required bool halfScoreToEliminate,
      Value<bool> ended,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> endedAt,
    });
typedef $$MatchTableUpdateCompanionBuilder =
    MatchCompanion Function({
      Value<int> id,
      Value<int> eventId,
      Value<int> firstTeamId,
      Value<int> secondTeamId,
      Value<String> name,
      Value<int> maxScore,
      Value<bool> halfScoreToEliminate,
      Value<bool> ended,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> endedAt,
    });

final class $$MatchTableReferences
    extends BaseReferences<_$AppDatabase, $MatchTable, MatchData> {
  $$MatchTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EventTable _eventIdTable(_$AppDatabase db) =>
      db.event.createAlias($_aliasNameGenerator(db.match.eventId, db.event.id));

  $$EventTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<int>('event_id')!;

    final manager = $$EventTableTableManager(
      $_db,
      $_db.event,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TeamTable _firstTeamIdTable(_$AppDatabase db) => db.team.createAlias(
    $_aliasNameGenerator(db.match.firstTeamId, db.team.id),
  );

  $$TeamTableProcessedTableManager get firstTeamId {
    final $_column = $_itemColumn<int>('first_team_id')!;

    final manager = $$TeamTableTableManager(
      $_db,
      $_db.team,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_firstTeamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TeamTable _secondTeamIdTable(_$AppDatabase db) => db.team.createAlias(
    $_aliasNameGenerator(db.match.secondTeamId, db.team.id),
  );

  $$TeamTableProcessedTableManager get secondTeamId {
    final $_column = $_itemColumn<int>('second_team_id')!;

    final manager = $$TeamTableTableManager(
      $_db,
      $_db.team,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_secondTeamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ScoreTable, List<ScoreData>> _scoreRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.score,
    aliasName: $_aliasNameGenerator(db.match.id, db.score.matchId),
  );

  $$ScoreTableProcessedTableManager get scoreRefs {
    final manager = $$ScoreTableTableManager(
      $_db,
      $_db.score,
    ).filter((f) => f.matchId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_scoreRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MatchTableFilterComposer extends Composer<_$AppDatabase, $MatchTable> {
  $$MatchTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxScore => $composableBuilder(
    column: $table.maxScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get halfScoreToEliminate => $composableBuilder(
    column: $table.halfScoreToEliminate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get ended => $composableBuilder(
    column: $table.ended,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EventTableFilterComposer get eventId {
    final $$EventTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.event,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventTableFilterComposer(
            $db: $db,
            $table: $db.event,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamTableFilterComposer get firstTeamId {
    final $$TeamTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.firstTeamId,
      referencedTable: $db.team,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamTableFilterComposer(
            $db: $db,
            $table: $db.team,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamTableFilterComposer get secondTeamId {
    final $$TeamTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.secondTeamId,
      referencedTable: $db.team,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamTableFilterComposer(
            $db: $db,
            $table: $db.team,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> scoreRefs(
    Expression<bool> Function($$ScoreTableFilterComposer f) f,
  ) {
    final $$ScoreTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.score,
      getReferencedColumn: (t) => t.matchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScoreTableFilterComposer(
            $db: $db,
            $table: $db.score,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MatchTableOrderingComposer
    extends Composer<_$AppDatabase, $MatchTable> {
  $$MatchTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxScore => $composableBuilder(
    column: $table.maxScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get halfScoreToEliminate => $composableBuilder(
    column: $table.halfScoreToEliminate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get ended => $composableBuilder(
    column: $table.ended,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventTableOrderingComposer get eventId {
    final $$EventTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.event,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventTableOrderingComposer(
            $db: $db,
            $table: $db.event,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamTableOrderingComposer get firstTeamId {
    final $$TeamTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.firstTeamId,
      referencedTable: $db.team,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamTableOrderingComposer(
            $db: $db,
            $table: $db.team,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamTableOrderingComposer get secondTeamId {
    final $$TeamTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.secondTeamId,
      referencedTable: $db.team,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamTableOrderingComposer(
            $db: $db,
            $table: $db.team,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MatchTableAnnotationComposer
    extends Composer<_$AppDatabase, $MatchTable> {
  $$MatchTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get maxScore =>
      $composableBuilder(column: $table.maxScore, builder: (column) => column);

  GeneratedColumn<bool> get halfScoreToEliminate => $composableBuilder(
    column: $table.halfScoreToEliminate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get ended =>
      $composableBuilder(column: $table.ended, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  $$EventTableAnnotationComposer get eventId {
    final $$EventTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.event,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventTableAnnotationComposer(
            $db: $db,
            $table: $db.event,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamTableAnnotationComposer get firstTeamId {
    final $$TeamTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.firstTeamId,
      referencedTable: $db.team,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamTableAnnotationComposer(
            $db: $db,
            $table: $db.team,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamTableAnnotationComposer get secondTeamId {
    final $$TeamTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.secondTeamId,
      referencedTable: $db.team,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamTableAnnotationComposer(
            $db: $db,
            $table: $db.team,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> scoreRefs<T extends Object>(
    Expression<T> Function($$ScoreTableAnnotationComposer a) f,
  ) {
    final $$ScoreTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.score,
      getReferencedColumn: (t) => t.matchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScoreTableAnnotationComposer(
            $db: $db,
            $table: $db.score,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MatchTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MatchTable,
          MatchData,
          $$MatchTableFilterComposer,
          $$MatchTableOrderingComposer,
          $$MatchTableAnnotationComposer,
          $$MatchTableCreateCompanionBuilder,
          $$MatchTableUpdateCompanionBuilder,
          (MatchData, $$MatchTableReferences),
          MatchData,
          PrefetchHooks Function({
            bool eventId,
            bool firstTeamId,
            bool secondTeamId,
            bool scoreRefs,
          })
        > {
  $$MatchTableTableManager(_$AppDatabase db, $MatchTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatchTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> eventId = const Value.absent(),
                Value<int> firstTeamId = const Value.absent(),
                Value<int> secondTeamId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> maxScore = const Value.absent(),
                Value<bool> halfScoreToEliminate = const Value.absent(),
                Value<bool> ended = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
              }) => MatchCompanion(
                id: id,
                eventId: eventId,
                firstTeamId: firstTeamId,
                secondTeamId: secondTeamId,
                name: name,
                maxScore: maxScore,
                halfScoreToEliminate: halfScoreToEliminate,
                ended: ended,
                createdAt: createdAt,
                updatedAt: updatedAt,
                endedAt: endedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int eventId,
                required int firstTeamId,
                required int secondTeamId,
                required String name,
                required int maxScore,
                required bool halfScoreToEliminate,
                Value<bool> ended = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
              }) => MatchCompanion.insert(
                id: id,
                eventId: eventId,
                firstTeamId: firstTeamId,
                secondTeamId: secondTeamId,
                name: name,
                maxScore: maxScore,
                halfScoreToEliminate: halfScoreToEliminate,
                ended: ended,
                createdAt: createdAt,
                updatedAt: updatedAt,
                endedAt: endedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$MatchTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                eventId = false,
                firstTeamId = false,
                secondTeamId = false,
                scoreRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (scoreRefs) db.score],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (eventId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.eventId,
                                    referencedTable: $$MatchTableReferences
                                        ._eventIdTable(db),
                                    referencedColumn: $$MatchTableReferences
                                        ._eventIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (firstTeamId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.firstTeamId,
                                    referencedTable: $$MatchTableReferences
                                        ._firstTeamIdTable(db),
                                    referencedColumn: $$MatchTableReferences
                                        ._firstTeamIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (secondTeamId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.secondTeamId,
                                    referencedTable: $$MatchTableReferences
                                        ._secondTeamIdTable(db),
                                    referencedColumn: $$MatchTableReferences
                                        ._secondTeamIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (scoreRefs)
                        await $_getPrefetchedData<
                          MatchData,
                          $MatchTable,
                          ScoreData
                        >(
                          currentTable: table,
                          referencedTable: $$MatchTableReferences
                              ._scoreRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MatchTableReferences(db, table, p0).scoreRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.matchId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MatchTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MatchTable,
      MatchData,
      $$MatchTableFilterComposer,
      $$MatchTableOrderingComposer,
      $$MatchTableAnnotationComposer,
      $$MatchTableCreateCompanionBuilder,
      $$MatchTableUpdateCompanionBuilder,
      (MatchData, $$MatchTableReferences),
      MatchData,
      PrefetchHooks Function({
        bool eventId,
        bool firstTeamId,
        bool secondTeamId,
        bool scoreRefs,
      })
    >;
typedef $$ScoreTableCreateCompanionBuilder =
    ScoreCompanion Function({
      Value<int> id,
      required int matchId,
      required int teamId,
      Value<bool> reversed,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ScoreTableUpdateCompanionBuilder =
    ScoreCompanion Function({
      Value<int> id,
      Value<int> matchId,
      Value<int> teamId,
      Value<bool> reversed,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ScoreTableReferences
    extends BaseReferences<_$AppDatabase, $ScoreTable, ScoreData> {
  $$ScoreTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MatchTable _matchIdTable(_$AppDatabase db) =>
      db.match.createAlias($_aliasNameGenerator(db.score.matchId, db.match.id));

  $$MatchTableProcessedTableManager get matchId {
    final $_column = $_itemColumn<int>('match_id')!;

    final manager = $$MatchTableTableManager(
      $_db,
      $_db.match,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_matchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TeamTable _teamIdTable(_$AppDatabase db) =>
      db.team.createAlias($_aliasNameGenerator(db.score.teamId, db.team.id));

  $$TeamTableProcessedTableManager get teamId {
    final $_column = $_itemColumn<int>('team_id')!;

    final manager = $$TeamTableTableManager(
      $_db,
      $_db.team,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ScoreTableFilterComposer extends Composer<_$AppDatabase, $ScoreTable> {
  $$ScoreTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reversed => $composableBuilder(
    column: $table.reversed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MatchTableFilterComposer get matchId {
    final $$MatchTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matchId,
      referencedTable: $db.match,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchTableFilterComposer(
            $db: $db,
            $table: $db.match,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamTableFilterComposer get teamId {
    final $$TeamTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.team,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamTableFilterComposer(
            $db: $db,
            $table: $db.team,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScoreTableOrderingComposer
    extends Composer<_$AppDatabase, $ScoreTable> {
  $$ScoreTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reversed => $composableBuilder(
    column: $table.reversed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MatchTableOrderingComposer get matchId {
    final $$MatchTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matchId,
      referencedTable: $db.match,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchTableOrderingComposer(
            $db: $db,
            $table: $db.match,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamTableOrderingComposer get teamId {
    final $$TeamTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.team,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamTableOrderingComposer(
            $db: $db,
            $table: $db.team,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScoreTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScoreTable> {
  $$ScoreTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get reversed =>
      $composableBuilder(column: $table.reversed, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$MatchTableAnnotationComposer get matchId {
    final $$MatchTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matchId,
      referencedTable: $db.match,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchTableAnnotationComposer(
            $db: $db,
            $table: $db.match,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TeamTableAnnotationComposer get teamId {
    final $$TeamTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.team,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamTableAnnotationComposer(
            $db: $db,
            $table: $db.team,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScoreTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScoreTable,
          ScoreData,
          $$ScoreTableFilterComposer,
          $$ScoreTableOrderingComposer,
          $$ScoreTableAnnotationComposer,
          $$ScoreTableCreateCompanionBuilder,
          $$ScoreTableUpdateCompanionBuilder,
          (ScoreData, $$ScoreTableReferences),
          ScoreData,
          PrefetchHooks Function({bool matchId, bool teamId})
        > {
  $$ScoreTableTableManager(_$AppDatabase db, $ScoreTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScoreTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScoreTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScoreTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> matchId = const Value.absent(),
                Value<int> teamId = const Value.absent(),
                Value<bool> reversed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ScoreCompanion(
                id: id,
                matchId: matchId,
                teamId: teamId,
                reversed: reversed,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int matchId,
                required int teamId,
                Value<bool> reversed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ScoreCompanion.insert(
                id: id,
                matchId: matchId,
                teamId: teamId,
                reversed: reversed,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ScoreTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({matchId = false, teamId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (matchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.matchId,
                                referencedTable: $$ScoreTableReferences
                                    ._matchIdTable(db),
                                referencedColumn: $$ScoreTableReferences
                                    ._matchIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (teamId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.teamId,
                                referencedTable: $$ScoreTableReferences
                                    ._teamIdTable(db),
                                referencedColumn: $$ScoreTableReferences
                                    ._teamIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ScoreTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScoreTable,
      ScoreData,
      $$ScoreTableFilterComposer,
      $$ScoreTableOrderingComposer,
      $$ScoreTableAnnotationComposer,
      $$ScoreTableCreateCompanionBuilder,
      $$ScoreTableUpdateCompanionBuilder,
      (ScoreData, $$ScoreTableReferences),
      ScoreData,
      PrefetchHooks Function({bool matchId, bool teamId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$EventTableTableManager get event =>
      $$EventTableTableManager(_db, _db.event);
  $$PlayerTableTableManager get player =>
      $$PlayerTableTableManager(_db, _db.player);
  $$TeamTableTableManager get team => $$TeamTableTableManager(_db, _db.team);
  $$TeamPlayerTableTableManager get teamPlayer =>
      $$TeamPlayerTableTableManager(_db, _db.teamPlayer);
  $$MatchTableTableManager get match =>
      $$MatchTableTableManager(_db, _db.match);
  $$ScoreTableTableManager get score =>
      $$ScoreTableTableManager(_db, _db.score);
}

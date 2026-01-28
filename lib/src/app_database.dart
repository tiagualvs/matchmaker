import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppDatabase {
  static final _instance = AppDatabase._();

  bool _initialized = false;

  SupabaseClient? _remote;

  SupabaseClient get remote {
    if (_initialized == false) {
      throw Exception('AppDatabase not initialized');
    }

    return _remote!;
  }

  Database? _local;

  Database get local {
    if (_initialized == false) {
      throw Exception('AppDatabase not initialized');
    }

    return _local!;
  }

  AppDatabase._();

  static AppDatabase get instance => _instance;

  static Future<void> init() async {
    final dir = await getApplicationSupportDirectory();

    final database = File(p.join(dir.path, 'database.db'));

    final db = sqlite3.open(database.path);

    await database.copy('/storage/emulated/0/Download/database.db');

    db.execute('''CREATE TABLE IF NOT EXISTS tb_players (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE NOT NULL,
  gender TEXT NOT NULL CHECK (gender IN ('male', 'female', 'unknown')) DEFAULT 'unknown',
  level TEXT NOT NULL CHECK (level IN ('basic', 'intermediate', 'advanced')) DEFAULT 'basic',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS tb_events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  max_score INTEGER NOT NULL DEFAULT 12,
  max_player_per_team INTEGER NOT NULL DEFAULT 4,
  ended BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ended_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS tb_event_teams (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  event_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (event_id) REFERENCES tb_events(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tb_event_team_players (
  team_id INTEGER NOT NULL,
  player_id INTEGER NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (team_id) REFERENCES tb_event_teams(id) ON DELETE CASCADE,
  FOREIGN KEY (player_id) REFERENCES tb_players(id) ON DELETE CASCADE,
  PRIMARY KEY (team_id, player_id)
);

CREATE TABLE IF NOT EXISTS tb_event_matches (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  event_id INTEGER NOT NULL,
  first_team_id INTEGER NOT NULL,
  second_team_id INTEGER NOT NULL, 
  max_score INTEGER NOT NULL DEFAULT 12,
  ended BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ended_at TIMESTAMP,
  FOREIGN KEY (event_id) REFERENCES tb_events(id) ON DELETE CASCADE,
  FOREIGN KEY (first_team_id) REFERENCES tb_event_teams(id) ON DELETE CASCADE,
  FOREIGN KEY (second_team_id) REFERENCES tb_event_teams(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tb_match_scores (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  match_id INTEGER NOT NULL,
  team_id INTEGER NOT NULL,
  reversed BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (match_id) REFERENCES tb_event_matches(id) ON DELETE CASCADE,
  FOREIGN KEY (team_id) REFERENCES tb_event_teams(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tb_event_queue (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  event_id INTEGER NOT NULL,
  team_id INTEGER NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (event_id) REFERENCES tb_events(id) ON DELETE CASCADE,
  FOREIGN KEY (team_id) REFERENCES tb_event_teams(id) ON DELETE CASCADE
);

CREATE VIEW IF NOT EXISTS vw_events_full AS
SELECT
  e.id,
  e.name,
  e.max_score,
  e.max_player_per_team,
  e.ended,
  e.created_at,
  e.updated_at,
  e.ended_at,

  /* TIMES COM PLAYERS */
  COALESCE(
    (
      SELECT json_group_array(
        json_object(
          'id', t.id,
          'event_id', t.event_id,
          'name', t.name,
          'created_at', t.created_at,
          'updated_at', t.updated_at,
          'players', COALESCE(
            (
              SELECT json_group_array(
                json_object(
                  'id', p.id,
                  'name', p.name,
                  'gender', p.gender,
                  'level', p.level,
                  'created_at', p.created_at,
                  'updated_at', p.updated_at
                )
              )
              FROM tb_event_team_players tp
              JOIN tb_players p ON p.id = tp.player_id
              WHERE tp.team_id = t.id
            ),
            json('[]')
          )
        )
      )
      FROM tb_event_teams t
      WHERE t.event_id = e.id
    ),
    json('[]')
  ) AS teams,

  /* PARTIDAS COM SCORES */
  COALESCE(
    (
      SELECT json_group_array(
        json_object(
          'id', m.id,
          'event_id', m.event_id,
          'name', m.name,
          'first_team_id', m.first_team_id,
          'second_team_id', m.second_team_id,
          'max_score', m.max_score,
          'ended', m.ended,
          'created_at', m.created_at,
          'updated_at', m.updated_at,
          'ended_at', m.ended_at,
          'scores', COALESCE(
            (
              SELECT json_group_array(
                json_object(
                  'id', s.id,
                  'match_id', s.match_id,
                  'team_id', s.team_id,
                  'reversed', s.reversed,
                  'created_at', s.created_at,
                  'updated_at', s.updated_at
                )
              )
              FROM tb_match_scores s
              WHERE s.match_id = m.id
            ),
            json('[]')
          )
        )
      )
      FROM tb_event_matches m
      WHERE m.event_id = e.id
    ),
    json('[]')
  ) AS matches,

  /* FILA DE PRÓXIMOS TIMES (LISTA DE STRINGS) */
  COALESCE(
    (
      SELECT json_group_array(
        CAST(q.team_id AS TEXT)
      )
      FROM tb_event_queue q
      WHERE q.event_id = e.id
      ORDER BY q.id ASC
    ),
    json('[]')
  ) AS queue

FROM tb_events e;

CREATE VIEW IF NOT EXISTS vw_event_match_full AS
SELECT
  m.id,
  m.name,
  m.event_id,
  m.first_team_id,
  m.second_team_id,
  m.max_score,
  m.ended,
  m.created_at,
  m.updated_at,
  m.ended_at,

  /* FIRST TEAM */
  json_object(
    'id', t1.id,
    'event_id', t1.event_id,
    'name', t1.name,
    'created_at', t1.created_at,
    'updated_at', t1.updated_at,
    'players', COALESCE(
      (
        SELECT json_group_array(
          json_object(
            'id', p.id,
            'name', p.name,
            'gender', p.gender,
            'level', p.level,
            'created_at', p.created_at,
            'updated_at', p.updated_at
          )
        )
        FROM tb_event_team_players tp
        JOIN tb_players p ON p.id = tp.player_id
        WHERE tp.team_id = t1.id
      ),
      json('[]')
    )
  ) AS first_team,

  /* SECOND TEAM */
  json_object(
    'id', t2.id,
    'event_id', t2.event_id,
    'name', t2.name,
    'created_at', t2.created_at,
    'updated_at', t2.updated_at,
    'players', COALESCE(
      (
        SELECT json_group_array(
          json_object(
            'id', p.id,
            'name', p.name,
            'gender', p.gender,
            'level', p.level,
            'created_at', p.created_at,
            'updated_at', p.updated_at
          )
        )
        FROM tb_event_team_players tp
        JOIN tb_players p ON p.id = tp.player_id
        WHERE tp.team_id = t2.id
      ),
      json('[]')
    )
  ) AS second_team,

  /* SCORES */
  COALESCE(
    (
      SELECT json_group_array(
        json_object(
          'id', s.id,
          'match_id', s.match_id,
          'team_id', s.team_id,
          'reversed', s.reversed,
          'created_at', s.created_at,
          'updated_at', s.updated_at
        )
      )
      FROM tb_match_scores s
      WHERE s.match_id = m.id
      ORDER BY s.id DESC
    ),
    json('[]')
  ) AS scores

FROM tb_event_matches m
JOIN tb_event_teams t1 ON t1.id = m.first_team_id
JOIN tb_event_teams t2 ON t2.id = m.second_team_id;

CREATE INDEX IF NOT EXISTS idx_event_teams_event_id ON tb_event_teams(event_id);
CREATE INDEX IF NOT EXISTS idx_event_matches_event_id ON tb_event_matches(event_id);
CREATE INDEX IF NOT EXISTS idx_team_players_team_id ON tb_event_team_players(team_id);
CREATE INDEX IF NOT EXISTS idx_match_scores_match_id ON tb_match_scores(match_id);''');

    _instance._local = db;

    await Supabase.initialize(
      url: const String.fromEnvironment('SUPABASE_URL'),
      anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
    );

    _instance._remote = Supabase.instance.client;

    _instance._initialized = true;
  }
}

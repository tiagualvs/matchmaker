import 'dart:io';

import 'package:flutter/material.dart';
import 'package:matchmaker/src/data/repositories/events_repository.dart';
import 'package:matchmaker/src/data/repositories/matches_repository.dart';
import 'package:matchmaker/src/data/repositories/scores_repository.dart';
import 'package:matchmaker/src/presentation/controllers/create_event_controller.dart';
import 'package:matchmaker/src/presentation/controllers/event_controller.dart';
import 'package:matchmaker/src/presentation/controllers/home_controller.dart';
import 'package:matchmaker/src/presentation/controllers/match_controller.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlite3/sqlite3.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: () async {
        final prefs = await SharedPreferences.getInstance();
        final db = await createDatabase();
        return (prefs: prefs, db: db);
      }(),
      builder: (context, snapshot) {
        final data = snapshot.data;

        if (data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return MultiProvider(
          providers: [
            Provider<SharedPreferences>.value(value: data.prefs),
            Provider<Database>.value(value: data.db),
            Provider<EventsRepository>(
              create: (ctx) => EventsRepository(ctx.read()),
            ),
            Provider<MatchesRepository>(
              create: (ctx) => MatchesRepository(ctx.read()),
            ),
            Provider<ScoresRepository>(
              create: (ctx) => ScoresRepository(ctx.read()),
            ),
            InheritedProvider<HomeController>(
              create: (ctx) => HomeController(ctx.read()),
            ),
            InheritedProvider<EventController>(
              create: (ctx) => EventController(ctx.read()),
            ),
            InheritedProvider<CreateEventController>(
              create: (ctx) => CreateEventController(ctx.read(), ctx.read()),
            ),
            InheritedProvider<MatchController>(
              create: (ctx) => MatchController(ctx.read(), ctx.read()),
            ),
          ],
          child: child,
        );
      },
    );
  }
}

Future<Database> createDatabase() async {
  try {
    final dir = await getApplicationSupportDirectory();

    final file = File(p.join(dir.path, 'database.sqlite3'));

    final db = sqlite3.open(p.join(dir.path, 'database.sqlite3'));

    await file.copy('/storage/emulated/0/Download/database.sqlite3');

    db.execute('''CREATE TABLE IF NOT EXISTS players (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  gender TEXT NOT NULL CHECK (gender IN ('male', 'female', 'unknown')) DEFAULT 'unknown',
  level TEXT NOT NULL CHECK (level IN ('basic', 'intermediate', 'advanced')) DEFAULT 'basic',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);''');

    db.execute('''CREATE TABLE IF NOT EXISTS events (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  max_score INTEGER NOT NULL DEFAULT 12,
  max_player_per_team INTEGER NOT NULL DEFAULT 4,
  ended BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ended_at TIMESTAMP
);''');

    db.execute('''CREATE TABLE IF NOT EXISTS event_teams (
  id TEXT PRIMARY KEY,
  event_id TEXT NOT NULL,
  name TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE
);''');

    db.execute('''CREATE TABLE IF NOT EXISTS team_players (
  id TEXT PRIMARY KEY,
  team_id TEXT NOT NULL,
  player_id TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (team_id) REFERENCES event_teams(id) ON DELETE CASCADE,
  FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE
);''');

    db.execute('''CREATE TABLE IF NOT EXISTS event_matches (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  event_id TEXT NOT NULL,
  first_team_id TEXT NOT NULL,
  second_team_id TEXT NOT NULL, 
  max_score INTEGER NOT NULL,
  ended BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ended_at TIMESTAMP,
  FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
  FOREIGN KEY (first_team_id) REFERENCES teams(id) ON DELETE CASCADE,
  FOREIGN KEY (second_team_id) REFERENCES teams(id) ON DELETE CASCADE
);''');

    db.execute('''CREATE TABLE IF NOT EXISTS match_scores (
  id TEXT PRIMARY KEY,
  match_id TEXT NOT NULL,
  team_id TEXT NOT NULL,
  reversed BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (match_id) REFERENCES event_matches(id) ON DELETE CASCADE,
  FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE
);''');

    return db;
  } on Exception catch (e) {
    print(e);
    rethrow;
  }
}

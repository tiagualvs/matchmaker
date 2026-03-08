import 'package:flutter/material.dart';
import 'package:matchmaker/src/app_widget.dart';
import 'package:matchmaker/src/common/shared/injector.dart';
import 'package:matchmaker/src/data/repositories/events/events_local_repository.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';
import 'package:matchmaker/src/data/repositories/matches/matches_local_repository.dart';
import 'package:matchmaker/src/data/repositories/matches/matches_repository.dart';
import 'package:matchmaker/src/data/repositories/players/players_local_repository.dart';
import 'package:matchmaker/src/data/repositories/players/players_repository.dart';
import 'package:matchmaker/src/data/repositories/scores/scores_local_repository.dart';
import 'package:matchmaker/src/data/repositories/scores/scores_repository.dart';
import 'package:matchmaker/src/data/repositories/teams/teams_local_repository.dart';
import 'package:matchmaker/src/data/repositories/teams/teams_repository.dart';
import 'package:matchmaker/src/data/services/database/app_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Injector.instance.batch(injectorInit);

  runApp(const AppWidget());
}

void injectorInit(Injector i) => i
  ..set<AppDatabase>(AppDatabase())
  ..set<EventsRepository>(EventsLocalRepository(i.get()))
  ..set<MatchesRepository>(MatchesLocalRepository(i.get()))
  ..set<PlayersRepository>(PlayersLocalRepository(i.get()))
  ..set<ScoresRepository>(ScoresLocalRepository(i.get()))
  ..set<TeamsRepository>(TeamsLocalRepository(i.get()));

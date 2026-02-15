import 'package:get_it/get_it.dart';
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

abstract class Injector {
  static void init() {
    final getIt = GetIt.instance;

    getIt.registerSingleton<AppDatabase>(AppDatabase());

    getIt.registerFactory<EventsRepository>(
      () => EventsLocalRepository(getIt()),
    );

    getIt.registerFactory<PlayersRepository>(
      () => PlayersLocalRepository(getIt()),
    );

    getIt.registerFactory<MatchesRepository>(
      () => MatchesLocalRepository(getIt()),
    );

    getIt.registerFactory<ScoresRepository>(
      () => ScoresLocalRepository(getIt()),
    );

    getIt.registerFactory<TeamsRepository>(
      () => TeamsLocalRepository(getIt()),
    );
  }

  static void test() {
    final getIt = GetIt.instance;

    getIt.registerSingleton<AppDatabase>(AppDatabase.testing());

    getIt.registerFactory<EventsRepository>(
      () => EventsLocalRepository(getIt()),
    );

    getIt.registerFactory<PlayersRepository>(
      () => PlayersLocalRepository(getIt()),
    );

    getIt.registerFactory<MatchesRepository>(
      () => MatchesLocalRepository(getIt()),
    );

    getIt.registerFactory<ScoresRepository>(
      () => ScoresLocalRepository(getIt()),
    );

    getIt.registerFactory<TeamsRepository>(
      () => TeamsLocalRepository(getIt()),
    );
  }
}

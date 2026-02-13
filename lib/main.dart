import 'package:flutter/material.dart';
import 'package:matchmaker/src/app_widget.dart';
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

  Injector.instance
    ..set<AppDatabase>(AppDatabase())
    ..set<EventsRepository>(EventsLocalRepository(Injector.instance.get()))
    ..set<PlayersRepository>(PlayersLocalRepository(Injector.instance.get()))
    ..set<MatchesRepository>(MatchesLocalRepository(Injector.instance.get()))
    ..set<ScoresRepository>(ScoresLocalRepository(Injector.instance.get()))
    ..set<TeamsRepository>(TeamsLocalRepository(Injector.instance.get()));

  runApp(const AppWidget());
}

class InjectorInstance<T> {
  final Type type;
  final T instance;

  const InjectorInstance(this.type, this.instance);
}

class Injector {
  static final _instance = Injector._();

  final List<InjectorInstance> _instances = [];

  Injector._();

  static Injector get instance => _instance;

  void set<T>(T instance) {
    _instances.add(InjectorInstance(T, instance));
  }

  T get<T>() {
    final index = _instances.indexWhere((e) => e.type == T);
    if (index == -1) throw Exception('Instance of type $T not found');
    return _instances[index].instance;
  }
}

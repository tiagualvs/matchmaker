import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:result/result.dart';

class InsertOneEventParams {
  final String name;
  final int maxScore;
  final int maxPlayerPerTeam;
  final List<TeamEntity> teams;

  const InsertOneEventParams({
    required this.name,
    required this.maxScore,
    required this.maxPlayerPerTeam,
    required this.teams,
  });
}

abstract interface class EventsRepository {
  AsyncResult<EventEntity> insertOne(InsertOneEventParams params);
  AsyncResult<List<EventEntity>> findMany();
  AsyncResult<EventEntity> findOne(int id);
}

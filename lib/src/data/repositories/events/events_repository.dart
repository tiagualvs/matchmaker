import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:result/result.dart';

class InsertOneEventParams {
  final String name;
  final int maxScore;
  final bool halfScoreToEliminate;
  final int maxPlayerPerTeam;
  final bool balancedByGender;
  final bool balancedByLevel;
  final int maxWinsInARow;
  final List<TeamEntity> teams;

  const InsertOneEventParams({
    required this.name,
    required this.maxScore,
    required this.halfScoreToEliminate,
    required this.maxPlayerPerTeam,
    required this.balancedByGender,
    required this.balancedByLevel,
    required this.maxWinsInARow,
    required this.teams,
  });
}

class UpdateOneEventParams {
  final String? name;
  final int? maxScore;
  final bool? halfScoreToEliminate;
  final int? maxPlayerPerTeam;
  final bool? balancedByGender;
  final bool? balancedByLevel;
  final int? maxWinsInARow;

  const UpdateOneEventParams({
    this.name,
    this.maxScore,
    this.halfScoreToEliminate,
    this.maxPlayerPerTeam,
    this.balancedByGender,
    this.balancedByLevel,
    this.maxWinsInARow,
  });
}

abstract interface class EventsRepository {
  AsyncResult<EventEntity> insertOne(InsertOneEventParams params);
  AsyncResult<List<EventEntity>> findMany();
  AsyncResult<EventEntity> findOne(int id);
  AsyncResult<EventEntity> updateOne(int id, UpdateOneEventParams params);
}

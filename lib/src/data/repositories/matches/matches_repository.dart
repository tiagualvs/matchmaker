import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:result/result.dart';

class InsertOneMatchParams {
  final int eventId;
  final String name;
  final int firstTeamId;
  final int secondTeamId;
  final int maxScore;
  final int enqueue;
  final int dequeue;

  const InsertOneMatchParams({
    required this.eventId,
    required this.name,
    required this.firstTeamId,
    required this.secondTeamId,
    required this.maxScore,
    required this.enqueue,
    required this.dequeue,
  });
}

class UpdateOneMatchParams {
  final String? name;
  final int? maxScore;
  final bool? ended;
  final DateTime? endedAt;

  const UpdateOneMatchParams({
    this.name,
    this.maxScore,
    this.ended,
    this.endedAt,
  });
}

abstract interface class MatchesRepository {
  AsyncResult<MatchEntity> insertOne(InsertOneMatchParams params);
  AsyncResult<MatchEntity> findOne(int id);
  AsyncResult<MatchEntity> updateOne(int id, UpdateOneMatchParams params);
}

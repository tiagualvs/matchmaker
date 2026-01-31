import 'package:matchmaker/src/common/shared/result.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';

class InsertOneMatchParams {
  final int eventId;
  final String name;
  final int firstTeamId;
  final int secondTeamId;
  final int maxScore;
  final bool halfScoreToEliminate;
  final List<int> queue;

  const InsertOneMatchParams({
    required this.eventId,
    required this.name,
    required this.firstTeamId,
    required this.secondTeamId,
    required this.maxScore,
    required this.halfScoreToEliminate,
    required this.queue,
  });
}

class UpdateOneMatchParams {
  final String? name;
  final int? maxScore;
  final bool? halfScoreToEliminate;
  final bool? ended;

  const UpdateOneMatchParams({
    this.name,
    this.maxScore,
    this.halfScoreToEliminate,
    this.ended,
  });
}

abstract interface class MatchesRepository {
  AsyncResult<MatchEntity> insertOne(InsertOneMatchParams params);
  AsyncResult<MatchEntity> findOne(int id);
  AsyncResult<MatchEntity> updateOne(int id, UpdateOneMatchParams params);
  AsyncResult<void> updateManyByEventId(int eventId, UpdateOneMatchParams params);
  AsyncResult<void> deleteOne(int id);
  AsyncResult<void> deleteManyByEventId(int eventId);
}

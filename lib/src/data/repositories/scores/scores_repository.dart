import 'package:matchmaker/src/common/shared/result.dart';
import 'package:matchmaker/src/data/entities/score_entity.dart';

class InsertOneScoreParams {
  final int matchId;
  final int teamId;

  const InsertOneScoreParams({required this.matchId, required this.teamId});
}

abstract interface class ScoresRepository {
  AsyncResult<ScoreEntity> insertOne(InsertOneScoreParams params);
  AsyncResult<ScoreEntity> updateOne(int id, bool reversed);
  AsyncResult<ScoreEntity> deleteOne(int id);
}

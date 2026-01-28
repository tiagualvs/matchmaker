import 'package:matchmaker/src/data/entities/score_entity.dart';
import 'package:result/result.dart';

class InsertOneScoreParams {
  final int matchId;
  final int teamId;

  const InsertOneScoreParams({required this.matchId, required this.teamId});
}

abstract interface class ScoresRepository {
  AsyncResult<ScoreEntity> insertOne(InsertOneScoreParams params);
  AsyncResult<ScoreEntity> updateOne(int id, bool reversed);
}

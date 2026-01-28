import 'package:matchmaker/src/data/entities/score_entity.dart';
import 'package:result/result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'scores_repository.dart';

class ScoresRemoteRepository implements ScoresRepository {
  const ScoresRemoteRepository(this._client);

  final SupabaseClient _client;

  @override
  AsyncResult<ScoreEntity> insertOne(InsertOneScoreParams params) async {
    final result = await _client.from('tb_match_scores').insert({
      'match_id': params.matchId,
      'team_id': params.teamId,
    }).select();

    if (result.isEmpty) {
      return Result.error(Exception('Falha ao inserir novo score!'));
    }

    return Result.ok(ScoreEntity.fromSupabase(result[0]));
  }

  @override
  AsyncResult<ScoreEntity> updateOne(int id, bool reversed) async {
    final result = await _client
        .from('tb_match_scores')
        .update({
          'reversed': reversed,
        })
        .eq('id', id)
        .select();

    if (result.isEmpty) {
      return Result.error(Exception('Falha ao atualizar score!'));
    }

    return Result.ok(ScoreEntity.fromSupabase(result[0]));
  }
}

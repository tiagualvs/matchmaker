import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:result/result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'matches_repository.dart';

class MatchesRepositoryImp implements MatchesRepository {
  final SupabaseClient _client;

  const MatchesRepositoryImp(this._client);

  @override
  AsyncResult<MatchEntity> insertOne(InsertOneMatchParams params) async {
    final result = await _client.from('tb_event_matches').insert({
      'event_id': params.eventId,
      'name': params.name,
      'first_team_id': params.firstTeamId,
      'second_team_id': params.secondTeamId,
      'max_score': params.maxScore,
    }).select();

    if (result.isEmpty) {
      return Result.error(Exception('Match not found'));
    }

    return Result.ok(MatchEntity.fromSupabase(result[0]));
  }

  @override
  AsyncResult<MatchEntity> findOne(int id) async {
    final result = await _client.from('vw_event_match_full').select().eq('id', id);

    if (result.isEmpty) {
      return Result.error(Exception('Match not found'));
    }

    return Result.ok(MatchEntity.fromSupabase(result[0]));
  }

  @override
  AsyncResult<MatchEntity> updateOne(int id, UpdateOneMatchParams params) async {
    await _client
        .from('tb_event_matches')
        .update({
          if (params.name != null) 'name': params.name,
          if (params.maxScore != null) 'max_score': params.maxScore,
          if (params.ended != null) 'ended': params.ended,
          if (params.ended != null && params.ended == true) 'ended_at': DateTime.now().toIso8601String(),
        })
        .eq('id', id);

    return findOne(id);
  }

  @override
  AsyncResult<void> updateManyByEventId(int eventId, UpdateOneMatchParams params) {
    throw UnimplementedError();
  }

  @override
  AsyncResult<void> deleteManyByEventId(int eventId) {
    throw UnimplementedError();
  }

  @override
  AsyncResult<void> deleteOne(int id) {
    throw UnimplementedError();
  }
}

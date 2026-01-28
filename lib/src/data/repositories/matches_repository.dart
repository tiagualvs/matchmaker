// import 'package:matchmaker/src/data/entities/match_entity.dart';
// import 'package:result/result.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class InsertOneMatchParams {
//   final int eventId;
//   final String name;
//   final int firstTeamId;
//   final int secondTeamId;
//   final int maxScore;
//   final int enqueue;
//   final int dequeue;

//   const InsertOneMatchParams({
//     required this.eventId,
//     required this.name,
//     required this.firstTeamId,
//     required this.secondTeamId,
//     required this.maxScore,
//     required this.enqueue,
//     required this.dequeue,
//   });
// }

// class UpdateOneMatchParams {
//   final String? name;
//   final int? maxScore;
//   final bool? ended;
//   final DateTime? endedAt;

//   const UpdateOneMatchParams({
//     this.name,
//     this.maxScore,
//     this.ended,
//     this.endedAt,
//   });
// }

// abstract interface class MatchesRepository {
//   AsyncResult<MatchEntity> insertOne(InsertOneMatchParams params);
//   AsyncResult<MatchEntity> findOne(int id);
//   AsyncResult<MatchEntity> updateOne(int id, UpdateOneMatchParams params);
// }

// class MatchesRepositoryImp implements MatchesRepository {
//   final SupabaseClient _client;

//   const MatchesRepositoryImp(this._client);

//   @override
//   AsyncResult<MatchEntity> insertOne(InsertOneMatchParams params) async {
//     final result = await _client.from('tb_event_matches').insert({
//       'event_id': params.eventId,
//       'name': params.name,
//       'first_team_id': params.firstTeamId,
//       'second_team_id': params.secondTeamId,
//       'max_score': params.maxScore,
//     }).select();

//     if (result.isEmpty) {
//       return Result.error(Exception('Match not found'));
//     }

//     await _client.from('tb_event_queue').delete().eq('team_id', params.dequeue);

//     await _client.from('tb_event_queue').insert({'event_id': params.eventId, 'team_id': params.enqueue});

//     return Result.ok(MatchEntity.fromSupabase(result[0]));
//   }

//   @override
//   AsyncResult<MatchEntity> findOne(int id) async {
//     final result = await _client.from('vw_event_match_full').select().eq('id', id);

//     if (result.isEmpty) {
//       return Result.error(Exception('Match not found'));
//     }

//     return Result.ok(MatchEntity.fromSupabase(result[0]));
//   }

//   @override
//   AsyncResult<MatchEntity> updateOne(int id, UpdateOneMatchParams params) async {
//     await _client
//         .from('tb_event_matches')
//         .update({
//           if (params.name != null) 'name': params.name,
//           if (params.maxScore != null) 'max_score': params.maxScore,
//           if (params.ended != null) 'ended': params.ended,
//           if (params.endedAt != null) 'ended_at': params.endedAt?.toIso8601String(),
//         })
//         .eq('id', id);

//     return findOne(id);
//   }
// }

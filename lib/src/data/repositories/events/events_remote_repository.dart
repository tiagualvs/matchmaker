import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:result/result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'events_repository.dart';

class EventsRemoteRepository implements EventsRepository {
  final SupabaseClient _client;

  const EventsRemoteRepository(this._client);

  @override
  AsyncResult<List<EventEntity>> findMany() async {
    final result = await _client.from('vw_events_full').select();

    return Result.ok(result.map(EventEntity.fromSupabase).toList());
  }

  @override
  AsyncResult<EventEntity> findOne(int id) async {
    final result = await _client.from('vw_events_full').select().eq('id', id);

    if (result.isEmpty) {
      return Result.error(Exception('Event not found'));
    }

    return Result.ok(EventEntity.fromSupabase(result[0]));
  }

  @override
  AsyncResult<EventEntity> insertOne(InsertOneEventParams params) async {
    final result0 = await _client.from('tb_events').insert({
      'name': params.name,
      'max_score': params.maxScore,
      'max_player_per_team': params.maxPlayerPerTeam,
      'balanced_by_gender': params.balancedByGender,
      'balanced_by_level': params.balancedByLevel,
      'max_wins_in_a_row': params.maxWinsInARow,
    }).select();

    final event = EventEntity.fromJson(result0[0]);

    final teams = <TeamEntity>[];

    for (final t in params.teams) {
      final result1 = await _client.from('tb_event_teams').insert({
        'event_id': event.id,
        'name': t.name,
      }).select();

      final team = TeamEntity.fromSupabase(result1[0]);

      final players = <PlayerEntity>[];

      for (final p in t.players) {
        final result2 = await _client
            .from('tb_players')
            .upsert(
              {
                'name': p.name,
                'gender': p.gender.value,
                'level': p.level.value,
              },
              onConflict: 'name',
              ignoreDuplicates: false,
            )
            .select();

        final player = PlayerEntity.fromJson(result2[0]);

        await _client.from('tb_event_team_players').insert({
          'team_id': team.id,
          'player_id': player.id,
        });

        players.add(player);
      }

      teams.add(team.copyWith(players: players));
    }

    final starterTeams = teams.take(2).toList();

    final result3 = await _client.from('tb_event_matches').insert({
      'name': 'Partida #1',
      'event_id': event.id,
      'first_team_id': starterTeams.first.id,
      'second_team_id': starterTeams.last.id,
      'max_score': event.maxScore,
    }).select();

    final match = MatchEntity.fromSupabase(result3[0]).copyWith(
      firstTeam: starterTeams[0],
      secondTeam: starterTeams[1],
    );

    final queue = teams.skip(2).map((team) => team.id).toList();

    await _client
        .from('tb_event_queue')
        .insert(
          List.from(
            queue.map(
              (id) => {
                'event_id': event.id,
                'team_id': id,
              },
            ),
          ),
        );

    return Result.ok(
      event.copyWith(
        teams: teams,
        matches: [match],
        queue: queue,
      ),
    );
  }

  @override
  AsyncResult<EventEntity> updateOne(int id, UpdateOneEventParams params) async {
    throw UnimplementedError();
  }
}

import 'package:matchmaker/src/common/shared/result.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';

class InsertOneTeamParams {
  final int eventId;
  final String name;
  final List<PlayerEntity> players;

  const InsertOneTeamParams({
    required this.eventId,
    required this.name,
    required this.players,
  });
}

class UpdateOneTeamParams {
  final String name;

  const UpdateOneTeamParams({required this.name});
}

abstract interface class TeamsRepository {
  AsyncResult<List<TeamEntity>> findMany(int eventId);
  AsyncResult<TeamEntity> findOne(int id);
  AsyncResult<TeamEntity> insertOne(InsertOneTeamParams params);
  AsyncResult<TeamEntity> updateOne(int id, UpdateOneTeamParams params);
  AsyncResult<void> deleteOne(int id);
  AsyncResult<void> insertPlayer(int teamId, int playerId);
  AsyncResult<void> deletePlayer(int teamId, int playerId);
}

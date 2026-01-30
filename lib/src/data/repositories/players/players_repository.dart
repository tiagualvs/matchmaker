import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:result/result.dart';

class InsertOnePlayerParams {
  final String name;
  final String gender;
  final String level;

  const InsertOnePlayerParams({required this.name, required this.gender, required this.level});
}

class UpdateOnePlayerParams {
  final String? name;
  final String? gender;
  final String? level;

  const UpdateOnePlayerParams({this.name, this.gender, this.level});

  bool get hasChanges => name != null || gender != null || level != null;
}

abstract interface class PlayersRepository {
  AsyncResult<PlayerEntity> insertOne(InsertOnePlayerParams params);
  AsyncResult<PlayerEntity> findOneById(int id);
  AsyncResult<PlayerEntity> findOneByName(String name);
  AsyncResult<PlayerEntity> updateOne(int id, UpdateOnePlayerParams params);
}

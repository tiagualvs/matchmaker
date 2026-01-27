import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/repositories/events_repository.dart';

class EventController extends ChangeNotifier {
  EventController(this._eventsRepository);

  final EventsRepository _eventsRepository;

  EventEntity _event = EventEntity.create();

  EventEntity get event => _event;

  MatchEntity get currentMatch {
    if (event.matches.isEmpty) return MatchEntity.empty();

    return event.matches.last;
  }

  Future<void> loadDependencies(
    String eventId, {
    void Function(String error)? onError,
  }) async {
    final result = await _eventsRepository.findOne(eventId);
    return result.fold(
      (event) {
        _event = event;
        notifyListeners();
      },
      (error) {
        return onError?.call(error.toString());
      },
    );
  }

  Future<void> copyFromClipboard({
    void Function(List<PlayerEntity> players)? onSuccess,
    void Function(String error)? onError,
  }) async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text;
    if (text == null) {
      return onError?.call('Falha ao carregar lista de jogadores!');
    }
    final regex = RegExp(r'^(\d+)\s+-\s+(.*)');
    final names =
        text
            .split('\n')
            .where((line) => line.isNotEmpty)
            .where(regex.hasMatch)
            .map((line) => line.split(' - ').last.trim())
            .toList()
          ..sort((a, b) => a.compareTo(b));
    if (names.isEmpty) {
      return onError?.call('Nenhum jogador encontrado!');
    }
    return onSuccess?.call(names.map((name) => PlayerEntity.create(name)).toList());
  }
}

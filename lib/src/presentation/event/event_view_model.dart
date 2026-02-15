import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/match_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';
import 'package:matchmaker/src/data/repositories/matches/matches_repository.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import 'event.dart';

abstract class EventViewModel extends State<Event> {
  final EventsRepository _eventsRepository = GetIt.instance.get();
  final MatchesRepository _matchesRepository = GetIt.instance.get();

  final WidgetsToImageController widgetsToImageController =
      WidgetsToImageController();

  bool _loading = false;

  bool get loading => _loading;

  bool _sharing = false;

  bool get sharing => _sharing;

  final bool _hasTeamWithMaxWinsInARow = false;

  bool get hasTeamWithMaxWinsInARow => _hasTeamWithMaxWinsInARow;

  late EventEntity _event = widget.event;

  EventEntity get event => _event;

  MatchEntity? get currentMatch => _event.currentMatch;

  Future<void> reloadEvent({
    Future<void> Function(String message)? onMaxWinsInARow,
    Future<void> Function(String message)? onNeedJokers,
    void Function(String error)? onError,
  }) async {
    setState(() {
      _loading = true;
      _sharing = false;
    });

    final result0 = await _eventsRepository.findOne(_event.id);

    return result0.fold(
      (event) async {
        final nextMatchData = event.nextMatchData();

        if (nextMatchData != null) {
          final (first, second, queue) = nextMatchData;

          final teamWithMaxWinsInARow = event.teamWithMaxWinsInARow();

          if (teamWithMaxWinsInARow != null) {
            await onMaxWinsInARow?.call(
              'O time [b]${teamWithMaxWinsInARow.name}[/b] alcançou o número máximo de vitórias em sequência [b](${event.maxWinsInARow})[/b].\n\nAgora dará lugar ao próximo time e voltará para a fila com prioridade para jogar a próxima partida!\n\nPróximo jogo:\n[b]${first.name}[/b] vs. [b]${second.name}[/b]!',
            );
          }

          if (first.players.length < event.maxPlayerPerTeam) {
            await onNeedJokers?.call(
              'O time [b]${first.name}[/b] está incompleto e precisa de [b]${event.maxPlayerPerTeam - first.players.length}[/b] jogadores para jogar a próxima partida!',
            );
          }

          if (second.players.length < event.maxPlayerPerTeam) {
            await onNeedJokers?.call(
              'O time [b]${second.name}[/b] está incompleto e precisa de [b]${event.maxPlayerPerTeam - second.players.length}[/b] jogadores para jogar a próxima partida!',
            );
          }

          final result1 = await _matchesRepository.insertOne(
            InsertOneMatchParams(
              eventId: event.id,
              name: '#${event.matches.length + 1}',
              firstTeamId: first.id,
              secondTeamId: second.id,
              maxScore: event.maxScore,
              halfScoreToEliminate: event.halfScoreToEliminate,
              queue: queue.map((team) => team.id).toList(),
            ),
          );

          if (result1.hasError) {
            return setState(() {
              _loading = false;

              return onError?.call(result1.error.toString());
            });
          }

          return setState(() {
            _loading = false;

            _event = event.copyWith(
              matches: [result1.value, ...event.matches],
              queue: queue.map((team) => team.id).toList(),
            );
          });
        }

        return setState(() {
          _loading = false;
          _event = event;
        });
      },
      (error) {
        return setState(() {
          _loading = false;
          _sharing = false;
        });
      },
    );
  }

  Future<void> endEvent({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    setState(() {
      _loading = true;
    });

    if (event.endedMatches.isEmpty) {
      final result0 = await _eventsRepository.deleteOne(event.id);

      return result0.fold(
        (_) async {
          return onSuccess?.call();
        },
        (error) {
          return setState(() {
            _loading = false;

            return onError?.call(error.toString());
          });
        },
      );
    }

    final result0 = await _eventsRepository.updateOne(
      event.id,
      const UpdateOneEventParams(ended: true),
    );

    return result0.fold(
      (event) async {
        for (final match in event.notEndedMatches) {
          final result1 = await _matchesRepository.deleteOne(match.id);

          if (result1.hasError) {
            return setState(() {
              _loading = false;

              return onError?.call(result1.error.toString());
            });
          }
        }

        return onSuccess?.call();
      },
      (error) {
        return setState(() {
          _loading = false;

          return onError?.call(error.toString());
        });
      },
    );
  }

  Future<void> shareEvent({
    void Function()? onSuccess,
    void Function(String error)? onError,
  }) async {
    setState(() {
      _sharing = true;
    });

    final bytes = await widgetsToImageController.capturePng(
      waitForAnimations: true,
      delayMs: 100,
    );

    if (bytes == null) {
      return onError?.call('Erro ao compartilhar evento!');
    }

    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile.fromData(
            bytes,
            name: '${event.name}.png',
            mimeType: 'image/png',
          ),
        ],
      ),
    );

    return setState(() {
      _sharing = false;

      return onSuccess?.call();
    });
  }
}

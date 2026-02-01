import 'package:matchmaker/src/common/shared/controller.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/data/repositories/events/events_repository.dart';
import 'package:matchmaker/src/data/repositories/matches/matches_repository.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class EventController extends Controller {
  EventController(this._eventsRepository, this._matchesRepository);

  final EventsRepository _eventsRepository;

  final MatchesRepository _matchesRepository;

  final WidgetsToImageController widgetsToImageController = WidgetsToImageController();

  bool _loading = true;

  bool get loading => _loading;

  bool _sharing = false;

  bool get sharing => _sharing;

  EventEntity _event = EventEntity.empty();

  EventEntity get event => _event;

  Future<void> loadDependencies(
    int eventId, {
    required Future<void> Function(
      EventEntity event,
      TeamEntity winner,
      TeamEntity firstTeam,
      TeamEntity secondTeam,
    )
    onMaxWinsInARow,
    required Future<void> Function(EventEntity event, TeamEntity team) onNeedsJoker,
    void Function(String error)? onError,
  }) async {
    setState(() {
      _loading = true;
      _sharing = false;
    });

    final result0 = await _eventsRepository.findOne(eventId);

    return result0.fold(
      (event) async {
        final currentMatch = event.currentMatch;
        final lastEndedMatch = event.lastEndedMatch;
        if (!event.ended && currentMatch == null && lastEndedMatch != null) {
          final winner = lastEndedMatch.firstTeamWon ? lastEndedMatch.firstTeam : lastEndedMatch.secondTeam;
          final loser = lastEndedMatch.firstTeamWon ? lastEndedMatch.secondTeam : lastEndedMatch.firstTeam;
          if (event.teamHasMaxWinsInARow(winner.id)) {
            final nextIds = event.queue.take(2).toList();

            await onMaxWinsInARow(
              event,
              winner,
              event.teams.firstWhere((team) => team.id == nextIds.first),
              event.teams.firstWhere((team) => team.id == nextIds.last),
            );

            final queue = [winner.id, ...event.queue.skip(2), loser.id];

            final result1 = await _matchesRepository.insertOne(
              InsertOneMatchParams(
                eventId: eventId,
                name: 'Partida #${event.matches.length + 1}',
                firstTeamId: nextIds.first,
                secondTeamId: nextIds.last,
                maxScore: event.maxScore,
                halfScoreToEliminate: event.halfScoreToEliminate,
                queue: queue,
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
                matches: [
                  ...event.matches,
                  result1.value.copyWith(
                    firstTeam: event.teams.firstWhere(
                      (team) => team.id == nextIds.first,
                    ),
                    secondTeam: event.teams.firstWhere(
                      (team) => team.id == nextIds.last,
                    ),
                  ),
                ],
                queue: queue,
              );
            });
          } else {
            final nextId = event.queue.first;

            final queue = [...event.queue.skip(1), loser.id];

            final firstTeam = lastEndedMatch.firstTeam.id == winner.id
                ? winner
                : event.teams.firstWhere((team) => team.id == nextId);
            final secondTeam = lastEndedMatch.secondTeam.id == winner.id
                ? winner
                : event.teams.firstWhere((team) => team.id == nextId);

            if (firstTeam.players.length != event.maxPlayerPerTeam) {
              await onNeedsJoker(event, firstTeam);
            }

            if (secondTeam.players.length != event.maxPlayerPerTeam) {
              await onNeedsJoker(event, secondTeam);
            }

            final result1 = await _matchesRepository.insertOne(
              InsertOneMatchParams(
                eventId: eventId,
                name: 'Partida #${event.matches.length + 1}',
                firstTeamId: firstTeam.id,
                secondTeamId: secondTeam.id,
                maxScore: event.maxScore,
                halfScoreToEliminate: event.halfScoreToEliminate,
                queue: queue,
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
                matches: [
                  ...event.matches,
                  result1.value.copyWith(
                    firstTeam: firstTeam,
                    secondTeam: secondTeam,
                  ),
                ],
                queue: queue,
              );
            });
          }
        } else {
          return setState(() {
            _loading = false;
            _event = event;
          });
        }
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

  void resetController() {
    _event = EventEntity.empty();
    _loading = true;
    _sharing = false;
  }
}

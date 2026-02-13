import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';

import 'match_history_view_model.dart';

class MatchHistoryView extends MatchHistoryViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text('Histórico de Partidas (${matches.length})'),
      ),
      body: switch (loading) {
        true => const Center(child: CircularProgressIndicator()),
        false when matches.isEmpty => Column(
          crossAxisAlignment: .stretch,
          mainAxisAlignment: .center,
          children: [
            const Icon(
              Icons.event,
              size: 92.0,
            ),
            Text(
              'Nenhuma partida encontrada',
              textAlign: .center,
              style: context.textTheme.titleMedium,
            ),
          ],
        ),
        false => ListView.separated(
          separatorBuilder: (_, _) => const SizedBox(height: 16.0),
          padding: const .all(16.0),
          itemCount: matches.length,
          itemBuilder: (context, index) {
            final match = matches[index];

            return ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
              childrenPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ).copyWith(bottom: 16.0),
              expandedCrossAxisAlignment: .stretch,
              backgroundColor: context.colorScheme.onPrimary,
              collapsedBackgroundColor: context.colorScheme.onPrimary,
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(
                  color: context.colorScheme.surfaceContainerHighest,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(
                  color: context.colorScheme.surfaceContainerHighest,
                ),
              ),
              title: Text(
                '${match.firstTeam.name} ${match.firstTeamScore} x ${match.secondTeamScore} ${match.secondTeam.name}',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: .normal,
                ),
              ),
              children: List.from(
                match.scores.map(
                  (score) {
                    String currentScore() {
                      final scores = match.scores
                          .where((s) => s.id <= score.id && !s.reversed)
                          .toList();

                      final firstTeamScore = scores
                          .where((s) => s.teamId == match.firstTeam.id)
                          .length;

                      final secondTeamScore = scores
                          .where((s) => s.teamId == match.secondTeam.id)
                          .length;

                      return '$firstTeamScore x $secondTeamScore';
                    }

                    Color currentColor() {
                      if (score.teamId == match.firstTeam.id &&
                          !score.reversed) {
                        return Colors.blue.shade100;
                      }

                      if (score.teamId == match.secondTeam.id &&
                          !score.reversed) {
                        return Colors.red.shade100;
                      }

                      return Colors.blueGrey.shade100;
                    }

                    return Container(
                      padding: const .all(8.0),
                      margin: const .only(bottom: 8.0),
                      color: currentColor(),
                      child: Row(
                        spacing: 8.0,
                        children: [
                          Expanded(
                            child: Text(
                              score.teamId == match.firstTeam.id
                                  ? match.firstTeam.name
                                  : match.secondTeam.name,
                              maxLines: 1,
                              overflow: .ellipsis,
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontWeight: .bold,
                              ),
                            ),
                          ),
                          Text(
                            switch (score.reversed) {
                              true => 'Ponto revertido',
                              false => currentScore(),
                            },
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: .bold,
                            ),
                          ),
                          Text(DateFormat('HH:mm').format(score.createdAt)),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      },
    );
  }
}

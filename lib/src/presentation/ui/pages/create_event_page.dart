import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/common/shared/controller.dart';
import 'package:matchmaker/src/common/widgets/floating_action_button_menu.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/presentation/controllers/create_event_controller.dart';
import 'package:matchmaker/src/presentation/ui/widgets/event_settings_dialog.dart';
import 'package:matchmaker/src/presentation/ui/widgets/player_input_widget.dart';
import 'package:matchmaker/src/presentation/ui/widgets/team_card_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key, required this.controller});

  final CreateEventController controller;

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> with ControllerMixin {
  CreateEventController get controller => widget.controller;

  bool get loading => controller.loading;

  EventEntity get event => controller.event;

  List<TeamEntity> get teams => event.teams;

  List<PlayerEntity> get players => controller.players;

  @override
  Controller get bind => controller;

  @override
  void dispose() {
    controller.resetController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButtonMenu(
      menus: [
        FloatingActionButtonMenuItem(
          icon: const Icon(Symbols.settings_rounded),
          label: const Text('Configurações do evento'),
          onPressed: () async {
            final changedEvent = await showGeneralDialog<EventEntity>(
              context: context,
              pageBuilder: (context, animation, _) {
                return FadeTransition(
                  opacity: animation,
                  child: EventSettingsDialog(event: event),
                );
              },
            );

            if (changedEvent != null) {
              controller.handleEventChanges(changedEvent);
            }
          },
        ),
        if (event.teams.isNotEmpty) ...[
          FloatingActionButtonMenuItem(
            icon: const Icon(Symbols.refresh_rounded),
            label: const Text('Desfazer times'),
            onPressed: () => controller.handleEventChanges(
              event.copyWith(teams: []),
            ),
          ),
          FloatingActionButtonMenuItem(
            icon: const Icon(Symbols.shuffle_rounded),
            label: const Text('Regerar times'),
            onPressed: () => controller.handleGenerateTeams(
              onError: SnackBars.error,
            ),
          ),
          FloatingActionButtonMenuItem(
            icon: const Icon(Symbols.save_rounded),
            label: const Text('Salvar evento'),
            onPressed: () => controller.handleSaveEvent(
              onSuccess: () {
                context.pop(true);

                return SnackBars.success('Evento salvo com sucesso!');
              },
              onError: (error) {
                return SnackBars.error(error);
              },
            ),
          ),
        ],
        if (event.teams.isEmpty) ...[
          FloatingActionButtonMenuItem(
            icon: const Icon(Symbols.groups_rounded),
            label: const Text('Importar jogadores de lista'),
            onPressed: () async {
              final importController = TextEditingController();

              final list = await showModalBottomSheet<String>(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      spacing: 16.0,
                      crossAxisAlignment: .stretch,
                      mainAxisSize: .min,
                      children: [
                        Text(
                          'Importar Jogadores',
                          style: context.textTheme.titleMedium,
                        ),
                        TextFormField(
                          minLines: 5,
                          maxLines: 7,
                          controller: importController,
                          decoration: const InputDecoration(
                            alignLabelWithHint: true,
                            hintText: '1 - Fulano de Tal - H\n2 - Sicrano de Tal\n3 - Elma Maria - M',
                            labelText: 'Lista de Jogadores',
                            floatingLabelBehavior: .always,
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: importController,
                          builder: (context, value, child) {
                            return FilledButton.icon(
                              onPressed: value.text.isEmpty ? null : () => context.pop(value.text),
                              icon: const Icon(Symbols.upload_file_rounded),
                              label: const Text('Importar'),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );

              if (list == null) {
                importController.dispose();
                return;
              }

              return await controller.importFromRawList(
                list,
                onSuccess: importController.dispose,
                onError: SnackBars.error,
              );
            },
          ),
          FloatingActionButtonMenuItem(
            icon: const Icon(Symbols.person_add_rounded),
            label: const Text('Adicionar jogador'),
            onPressed: () async {
              final player = await showModalBottomSheet<PlayerEntity>(
                context: context,
                builder: (context) {
                  return PlayerInputWidget(
                    onSave: context.pop,
                    withLevelSelect: false,
                  );
                },
              );

              if (player == null) return;

              return await controller.handleAddPlayer(
                player,
                onError: SnackBars.error,
              );
            },
          ),
          FloatingActionButtonMenuItem(
            icon: const Icon(Symbols.groups_rounded),
            label: const Text('Gerar times'),
            onPressed: () => controller.handleGenerateTeams(onError: SnackBars.error),
          ),
        ],
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Symbols.arrow_back_ios_rounded),
            onPressed: () {
              controller.resetController();
              return context.pop();
            },
          ),
          title: Text(controller.event.name),
        ),
        body: switch (loading) {
          true => const Center(child: CircularProgressIndicator()),
          false when teams.isEmpty && players.isEmpty => Column(
            crossAxisAlignment: .stretch,
            mainAxisSize: .max,
            mainAxisAlignment: .center,

            children: [
              Icon(
                Symbols.groups_rounded,
                size: 64.0,
                color: context.colorScheme.primary,
              ),
              const SizedBox(height: 16.0),
              Text(
                'Nenhum time cadastrado no evento',
                textAlign: .center,
                style: context.textTheme.titleMedium,
              ),
              Text(
                'Adicione jogadores para criar times',
                textAlign: .center,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          false when teams.isEmpty && players.isNotEmpty => SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              spacing: 16.0,
              crossAxisAlignment: .stretch,
              children: [
                Text(
                  'Jogadores (${players.length})',
                  style: context.textTheme.titleMedium,
                ),
                ListView.separated(
                  separatorBuilder: (_, _) => const SizedBox(height: 8.0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    final player = players[index];

                    return Material(
                      clipBehavior: .antiAlias,
                      color: context.colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        side: BorderSide(
                          width: 0.5,
                          color: context.colorScheme.primaryFixed,
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          final changedPlayed = await showModalBottomSheet<PlayerEntity>(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => PlayerInputWidget(
                              player: player,
                              onSave: context.pop,
                            ),
                          );

                          if (changedPlayed == null) return;

                          await controller.handlePlayerChanges(
                            index,
                            changedPlayed,
                            onError: SnackBars.error,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0).copyWith(
                            right: 0.0,
                          ),
                          child: Row(
                            spacing: 16.0,
                            children: [
                              Material(
                                shape: const CircleBorder(),
                                color: switch (player.gender) {
                                  PlayerGender.male => Colors.blue.withAlpha((255 * 0.1).toInt()),
                                  PlayerGender.female => Colors.pink.withAlpha((255 * 0.1).toInt()),
                                  _ => Colors.blueGrey.withAlpha((255 * 0.1).toInt()),
                                },
                                child: Padding(
                                  padding: const .all(4.0),
                                  child: switch (player.gender) {
                                    PlayerGender.male => const Icon(
                                      Symbols.male_rounded,
                                      color: Colors.blue,
                                      size: 22.0,
                                    ),
                                    PlayerGender.female => const Icon(
                                      Symbols.female_rounded,
                                      color: Colors.pink,
                                      size: 22.0,
                                    ),
                                    _ => const Icon(
                                      Symbols.agender_rounded,
                                      color: Colors.blueGrey,
                                      size: 22.0,
                                    ),
                                  },
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  player.name,
                                  style: context.textTheme.titleMedium,
                                ),
                              ),
                              IconButton(
                                onPressed: () => controller.handleRemovePlayer(index),
                                icon: const Icon(Symbols.delete_rounded),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          false when teams.isNotEmpty => SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              spacing: 16.0,
              crossAxisAlignment: .stretch,
              children: [
                Text(
                  'Times (${teams.length})',
                  style: context.textTheme.titleMedium,
                ),
                ListView.separated(
                  separatorBuilder: (_, _) => const SizedBox(height: 8.0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: teams.length,
                  itemBuilder: (context, index) {
                    final team = teams[index];

                    return TeamCardWidget(team: team, initiallyExpanded: true);
                  },
                ),
              ],
            ),
          ),
          _ => const SizedBox(),
        },
      ),
    );
  }
}

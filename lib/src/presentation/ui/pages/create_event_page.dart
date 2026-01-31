import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/common/widgets/floating_action_button_menu.dart';
import 'package:matchmaker/src/data/entities/event_entity.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/presentation/controllers/create_event_controller.dart';
import 'package:matchmaker/src/presentation/ui/widgets/event_settings_dialog.dart';
import 'package:matchmaker/src/presentation/ui/widgets/team_card_widget.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class CreateEventPage extends StatelessWidget {
  const CreateEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CreateEventController>().resetController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    });

    return Consumer<CreateEventController>(
      builder: (context, controller, _) {
        final loading = controller.loading;
        final event = controller.event;

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
                      child: EventSettingsDialog(event: controller.event),
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
              false => SingleChildScrollView(
                padding: const EdgeInsets.all(24.0).copyWith(bottom: 128.0),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  spacing: 16.0,
                  crossAxisAlignment: .stretch,
                  children: [
                    if (controller.event.teams.isNotEmpty) ...[
                      for (final team in controller.event.teams) ...[
                        TeamCardWidget(team: team, initiallyExpanded: true),
                      ],
                    ],
                    if (controller.event.teams.isEmpty) ...[
                      Text(
                        'Importar Jogadores',
                        style: context.textTheme.titleMedium,
                      ),
                      TextFormField(
                        minLines: 5,
                        maxLines: 7,
                        controller: controller.importer,
                        decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          hintText: '1 - Fulano de Tal - H\n2 - Sicrano de Tal\n3 - Elma Maria - M',
                          labelText: 'Lista de Jogadores',
                          floatingLabelBehavior: .always,
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: controller.importer,
                        builder: (context, value, child) {
                          return FilledButton.icon(
                            onPressed: value.text.isEmpty
                                ? null
                                : () async {
                                    FocusScope.of(context).unfocus();
                                    return await controller.importFromRawList(onError: SnackBars.error);
                                  },
                            icon: const Icon(Symbols.upload_file_rounded),
                            label: const Text('Importar'),
                          );
                        },
                      ),
                      Row(
                        spacing: 16.0,
                        crossAxisAlignment: .center,
                        children: [
                          const Expanded(child: Divider()),
                          Text(
                            'ou',
                            style: context.textTheme.bodyMedium,
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      Text(
                        'Adicione Manualmente',
                        style: context.textTheme.titleMedium,
                      ),
                      TextFormField(
                        controller: controller.playerName,
                        decoration: const InputDecoration(
                          hintText: 'Fulano de Tal',
                          labelText: 'Nome do Jogador',
                          floatingLabelBehavior: .always,
                        ),
                      ),
                      SegmentedButton<PlayerGender>(
                        emptySelectionAllowed: true,
                        selectedIcon: const SizedBox.shrink(),
                        segments: [
                          const ButtonSegment(value: PlayerGender.male, label: Text('Masculino')),
                          const ButtonSegment(value: PlayerGender.female, label: Text('Feminino')),
                        ],
                        onSelectionChanged: controller.handleGenderChange,
                        selected: controller.playerGender,
                      ),
                      ValueListenableBuilder(
                        valueListenable: controller.playerName,
                        builder: (context, value, child) {
                          return FilledButton.icon(
                            onPressed: value.text.isEmpty || controller.playerGender.isEmpty
                                ? null
                                : () async {
                                    FocusScope.of(context).unfocus();
                                    return await controller.handleAddPlayer(onError: SnackBars.error);
                                  },
                            icon: const Icon(Symbols.person_add_rounded),
                            label: const Text('Adicionar'),
                          );
                        },
                      ),
                      if (controller.players.isNotEmpty) ...[
                        Row(
                          spacing: 16.0,
                          crossAxisAlignment: .center,
                          children: [
                            const Expanded(child: Divider()),
                            Text(
                              'Lista de Jogadores (${controller.players.length}) / Times (${controller.numTeams})',
                              style: context.textTheme.bodyMedium,
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        ListView.separated(
                          separatorBuilder: (_, _) => const SizedBox(height: 8.0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.players.length,
                          itemBuilder: (context, index) {
                            final player = controller.players[index];

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
                                  FocusManager.instance.primaryFocus?.unfocus();

                                  String name = player.name;

                                  Set<PlayerGender> gender = {player.gender};

                                  Set<PlayerLevel> level = {player.level};

                                  final changedPlayed = await showModalBottomSheet<PlayerEntity>(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (context, setState) {
                                          return Padding(
                                            padding: const .all(24.0),
                                            child: Column(
                                              spacing: 16.0,
                                              mainAxisSize: .min,
                                              crossAxisAlignment: .stretch,
                                              children: [
                                                Text(
                                                  'Editar Jogador',
                                                  style: context.textTheme.titleMedium,
                                                ),
                                                TextFormField(
                                                  initialValue: name,
                                                  onChanged: (value) => setState(() => name = value),
                                                  decoration: const InputDecoration(
                                                    hintText: 'Fulano de Tal',
                                                    labelText: 'Nome do Jogador',
                                                    floatingLabelBehavior: .always,
                                                  ),
                                                ),
                                                SegmentedButton<PlayerGender>(
                                                  emptySelectionAllowed: true,
                                                  selectedIcon: const SizedBox.shrink(),
                                                  segments: [
                                                    const ButtonSegment(
                                                      value: PlayerGender.male,
                                                      label: Text('Masculino'),
                                                    ),
                                                    const ButtonSegment(
                                                      value: PlayerGender.female,
                                                      label: Text('Feminino'),
                                                    ),
                                                  ],
                                                  onSelectionChanged: (value) => setState(() {
                                                    gender = value;
                                                  }),
                                                  selected: gender,
                                                ),
                                                SegmentedButton<PlayerLevel>(
                                                  emptySelectionAllowed: true,
                                                  selectedIcon: const SizedBox.shrink(),
                                                  segments: [
                                                    const ButtonSegment(
                                                      value: PlayerLevel.basic,
                                                      label: Text('⭐'),
                                                    ),
                                                    const ButtonSegment(
                                                      value: PlayerLevel.intermediate,
                                                      label: Text('⭐⭐'),
                                                    ),
                                                    const ButtonSegment(
                                                      value: PlayerLevel.advanced,
                                                      label: Text('⭐⭐⭐'),
                                                    ),
                                                  ],
                                                  onSelectionChanged: (value) => setState(() {
                                                    level = value;
                                                  }),
                                                  selected: level,
                                                ),
                                                Row(
                                                  spacing: 16.0,
                                                  children: [
                                                    Expanded(
                                                      child: FilledButton.icon(
                                                        onPressed: () => context.pop(),
                                                        style: FilledButton.styleFrom(
                                                          backgroundColor: context.colorScheme.error,
                                                        ),
                                                        icon: const Icon(Symbols.cancel),
                                                        label: const Text('Cancelar'),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: FilledButton.icon(
                                                        onPressed: () => context.pop(
                                                          player.copyWith(
                                                            name: name,
                                                            gender: gender.first,
                                                            level: level.first,
                                                          ),
                                                        ),
                                                        icon: const Icon(Symbols.save),
                                                        label: const Text('Salvar'),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
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
                    ],
                  ],
                ),
              ),
            },
          ),
        );
      },
    );
  }
}

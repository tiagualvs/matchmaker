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

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key, required this.controller});

  final CreateEventController controller;

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  CreateEventController get controller => widget.controller;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    });
  }

  @override
  void dispose() {
    controller.resetController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        if (controller.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return FloatingActionButtonMenu(
          menus: [
            FloatingActionButtonMenuItem(
              icon: const Icon(Icons.settings_rounded),
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
            if (controller.event.teams.isNotEmpty) ...[
              FloatingActionButtonMenuItem(
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Desfazer times'),
                onPressed: () => controller.handleEventChanges(
                  controller.event.copyWith(teams: []),
                ),
              ),
              FloatingActionButtonMenuItem(
                icon: const Icon(Icons.save_rounded),
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
            if (controller.event.teams.isEmpty) ...[
              FloatingActionButtonMenuItem(
                icon: const Icon(Icons.groups_rounded),
                label: const Text('Gerar times'),
                onPressed: () => controller.handleGenerateTeams(onError: SnackBars.error),
              ),
            ],
          ],
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                onPressed: () {
                  controller.resetController();
                  return context.pop();
                },
              ),
              title: Text(controller.event.name),
            ),
            body: SingleChildScrollView(
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
                    TextField(
                      minLines: 5,
                      maxLines: 7,
                      controller: controller.importerController,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        hintText: '1 - Fulano de Tal - H\n2 - Sicrano de Tal\n3 - Elma Maria - M',
                        labelText: 'Lista de Jogadores',
                        floatingLabelBehavior: .always,
                      ),
                    ),
                    ListenableBuilder(
                      listenable: controller.importerController,
                      builder: (context, child) {
                        final disabled = controller.importerController.text.isEmpty;
                        return FilledButton.icon(
                          onPressed: disabled
                              ? null
                              : () async {
                                  FocusScope.of(context).unfocus();
                                  return await controller.importFromRawList(onError: SnackBars.error);
                                },
                          icon: const Icon(Icons.upload_file_rounded),
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
                      controller: controller.nameController,
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
                      selected: controller.selectedGender,
                    ),
                    ListenableBuilder(
                      listenable: controller.nameController,
                      builder: (context, child) {
                        final disabled = controller.nameController.text.isEmpty || controller.selectedGender.isEmpty;

                        return FilledButton.icon(
                          onPressed: disabled
                              ? null
                              : () {
                                  FocusScope.of(context).unfocus();
                                  return controller.handleAddPlayer();
                                },
                          icon: const Icon(Icons.person_add_rounded),
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
                            'Lista de Jogadores (${controller.players.length})',
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
                                                      icon: const Icon(Icons.cancel),
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
                                                      icon: const Icon(Icons.save),
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

                                controller.handlePlayerChanges(index, changedPlayed);
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
                                            Icons.male_rounded,
                                            color: Colors.blue,
                                            size: 22.0,
                                          ),
                                          PlayerGender.female => const Icon(
                                            Icons.female_rounded,
                                            color: Colors.pink,
                                            size: 22.0,
                                          ),
                                          _ => const Icon(
                                            Icons.person_rounded,
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
                                      icon: const Icon(Icons.delete_rounded),
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
          ),
        );
      },
    );
  }
}

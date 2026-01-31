import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/extensions/build_context_ext.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';
import 'package:matchmaker/src/data/entities/team_entity.dart';
import 'package:matchmaker/src/presentation/controllers/team_add_controller.dart';
import 'package:matchmaker/src/presentation/ui/widgets/player_tile_widget.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

class TeamAddPage extends StatelessWidget {
  const TeamAddPage({super.key, required this.eventId});

  final int eventId;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TeamAddController>()..resetController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.loadDependencies(eventId, onError: SnackBars.error);
    });

    return Consumer<TeamAddController>(
      builder: (context, _, _) {
        final event = controller.event;
        final team = controller.team;
        final players = team.players;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Adicionar time'),
            actions: switch (team.players.length != event.maxPlayerPerTeam) {
              true => [
                IconButton(
                  onPressed: () => controller.setState(() => controller.adding = true),
                  icon: const Icon(Symbols.person_add_rounded),
                ),
              ],
              false => [],
            },
          ),
          body: switch (controller.loading) {
            true => const Center(child: CircularProgressIndicator()),
            false => SingleChildScrollView(
              padding: const .all(24.0),
              child: Column(
                spacing: 16.0,
                mainAxisSize: .min,
                crossAxisAlignment: .stretch,
                children: [
                  Text(
                    'Cadastrar Time',
                    style: context.textTheme.titleMedium,
                  ),
                  DropdownMenuFormField<String>(
                    width: MediaQuery.sizeOf(context).width - 48.0,
                    dropdownMenuEntries: List.from(
                      TeamEntity.names
                          .where((name) => !event.teams.map((team) => team.name).contains(name))
                          .map((name) => DropdownMenuEntry(value: name, label: name)),
                    ),
                    onSelected: (value) {
                      if (value == null) return;

                      controller.setState(() {
                        controller.team = controller.team.copyWith(
                          name: value,
                        );
                      });
                    },
                    hintText: 'Selecione',
                    label: const Text('Nome do Time'),
                    inputDecorationTheme: context.theme.inputDecorationTheme.copyWith(
                      floatingLabelBehavior: .always,
                    ),
                  ),
                  if (players.isNotEmpty) ...[
                    Text(
                      'Jogadores',
                      style: context.textTheme.titleMedium,
                    ),
                    for (final player in players) ...[
                      PlayerTileWidget(player: player),
                    ],
                  ],
                  if (controller.adding) ...[
                    Text(
                      'Cadastrar Jogador',
                      style: context.textTheme.titleMedium,
                    ),
                    TextFormField(
                      initialValue: controller.playerName,
                      onChanged: (value) => controller.setState(() => controller.playerName = value),
                      decoration: const InputDecoration(
                        hintText: 'Fulano de Tal',
                        labelText: 'Nome do Jogador',
                        floatingLabelBehavior: .always,
                      ),
                    ),
                    SegmentedButton<PlayerGender>(
                      emptySelectionAllowed: true,
                      selected: controller.playerGender,
                      onSelectionChanged: (value) => controller.setState(
                        () => controller.playerGender = value,
                      ),
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
                      // selected: gender,
                    ),
                    FilledButton.icon(
                      onPressed: () async {
                        if (controller.playerName.isEmpty) {
                          return SnackBars.error('Nome do jogador é obrigatório!');
                        }

                        if (controller.playerGender.isEmpty) {
                          return SnackBars.error('Gênero do jogador é obrigatório!');
                        }

                        return await controller.addPlayer(onError: SnackBars.error);
                      },
                      icon: const Icon(Symbols.add_rounded),
                      label: const Text('Adicionar Jogador'),
                    ),
                  ],
                ],
              ),
            ),
          },
          bottomNavigationBar: Padding(
            padding: const .all(24.0),
            child: FilledButton.icon(
              onPressed: switch (team.players.isEmpty) {
                true => null,
                false => () => controller.save(
                  onSuccess: () {
                    SnackBars.success('Time cadastrado com sucesso!');
                    return context.pop();
                  },
                  onError: (err) {
                    return SnackBars.error(err);
                  },
                ),
              },
              icon: const Icon(Symbols.save_rounded),
              label: const Text('Salvar Time'),
            ),
          ),
        );
      },
    );
  }
}

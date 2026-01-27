import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matchmaker/src/common/others/snack_bars.dart';
import 'package:matchmaker/src/data/entities/player_entity.dart';

class PlayersDialog extends StatefulWidget {
  const PlayersDialog({super.key, required this.players});

  final List<PlayerEntity> players;

  @override
  State<PlayersDialog> createState() => _PlayersDialogState();
}

class _PlayersDialogState extends State<PlayersDialog> {
  late final players = widget.players;

  Timer? timer;

  void handleChangePlayerGender(int index, PlayerGender gender) {
    if (timer?.isActive ?? false) timer?.cancel();
    timer = Timer(
      const Duration(milliseconds: 150),
      () {
        setState(() {
          players[index] = players[index].copyWith(gender: gender);
        });
      },
    );
  }

  void handleChangePlayerName(int index, String name) {
    if (timer?.isActive ?? false) timer?.cancel();
    timer = Timer(
      const Duration(milliseconds: 500),
      () {
        setState(() {
          players[index] = players[index].copyWith(name: name);
        });
      },
    );
  }

  void handleAddPlayer() {
    setState(() {
      players.add(PlayerEntity.create(''));
    });
  }

  void handleDeletePlayer(int index) {
    setState(() {
      players.removeAt(index);
    });
  }

  void handleGenerate() {
    if (players.any((player) => player.name.isEmpty)) {
      return SnackBars.error('Todos os jogadores devem ter um nome');
    }

    if (players.any((player) => player.gender is PlayerGenderUnknown)) {
      return SnackBars.error('Todos os jogadores devem ter um gênero definido');
    }

    return context.pop<List<PlayerEntity>>(players);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogadores (${players.length})'),
        actionsPadding: const .only(right: 16.0),
        actions: [
          PopupMenuButton<int>(
            constraints: const BoxConstraints(minWidth: 196.0),
            onSelected: (value) async {
              return switch (value) {
                1 => handleGenerate(),
                2 => handleAddPlayer(),
                _ => null,
              };
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Gerar times'),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('Adicionar jogador'),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (_, _) => const Divider(),
        itemCount: widget.players.length,
        itemBuilder: (context, index) {
          final player = widget.players[index];

          return ListTile(
            title: TextFormField(
              initialValue: player.name,
              onChanged: (value) => handleChangePlayerName(index, value),
              decoration: InputDecoration(
                border: InputBorder.none,
                alignLabelWithHint: true,
                hintText: 'Nome do jogador',
                suffix: PopupMenuButton<PlayerGender>(
                  constraints: const BoxConstraints(minWidth: 192.0),
                  icon: switch (player.gender) {
                    PlayerGenderMale _ => const Icon(
                      Icons.male,
                      color: Colors.blue,
                    ),
                    PlayerGenderFemale _ => const Icon(
                      Icons.female,
                      color: Colors.pink,
                    ),
                    _ => const Icon(Icons.info_outline_rounded),
                  },
                  onSelected: (value) => handleChangePlayerGender(index, value),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: PlayerGender.male(),
                        child: Text('Masculino'),
                      ),
                      const PopupMenuItem(
                        value: PlayerGender.female(),
                        child: Text('Feminino'),
                      ),
                    ];
                  },
                ),
              ),
            ),
            trailing: IconButton(
              onPressed: () => handleDeletePlayer(index),
              icon: const Icon(
                Icons.delete_rounded,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}

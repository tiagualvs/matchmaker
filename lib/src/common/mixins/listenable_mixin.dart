import 'package:flutter/material.dart';

mixin ListenableMixin<T extends StatefulWidget> on State<T> {
  final _listenables = <Listenable>[];

  void bindListenables(List<Listenable> list);

  void _handleChanges() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    bindListenables(_listenables);

    for (final listenable in _listenables) {
      listenable.addListener(_handleChanges);
    }
  }

  @override
  void dispose() {
    for (final listenable in _listenables) {
      listenable.removeListener(_handleChanges);
    }

    super.dispose();
  }
}

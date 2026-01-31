import 'package:flutter/material.dart';

abstract class Controller extends Listenable {
  final List<VoidCallback> _liteners = [];

  @override
  void addListener(VoidCallback listener) {
    _liteners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _liteners.remove(listener);
  }

  void setState(void Function() func) {
    func();

    for (var listener in _liteners) {
      listener();
    }
  }
}

import 'package:flutter/material.dart';

abstract class Controller extends ChangeNotifier {
  void setState([void Function()? func]) {
    func?.call();
    return notifyListeners();
  }
}

mixin ControllerMixin<T extends StatefulWidget> on State<T> {
  void _handleChanges() => setState(() {});

  Controller get bind;

  @override
  void initState() {
    super.initState();
    bind.addListener(_handleChanges);
  }

  @override
  void dispose() {
    bind.removeListener(_handleChanges);
    super.dispose();
  }
}

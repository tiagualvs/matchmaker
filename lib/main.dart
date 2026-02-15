import 'package:flutter/material.dart';
import 'package:matchmaker/src/app_widget.dart';
import 'package:matchmaker/src/common/shared/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Injector.init();

  runApp(const AppWidget());
}

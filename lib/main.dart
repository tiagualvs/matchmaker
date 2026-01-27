import 'package:flutter/material.dart';
import 'package:matchmaker/src/app_provider.dart';
import 'package:matchmaker/src/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const AppProvider(child: AppWidget()));
}

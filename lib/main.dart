import 'package:flutter/material.dart';
import 'package:matchmaker/src/app_database.dart';
import 'package:matchmaker/src/app_provider.dart';
import 'package:matchmaker/src/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppDatabase.init();

  runApp(const AppProvider(child: AppWidget()));
}

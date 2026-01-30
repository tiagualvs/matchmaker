import 'dart:io';

import 'package:flutter/material.dart';
import 'package:matchmaker/src/app_provider.dart';
import 'package:matchmaker/src/app_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: const String.fromEnvironment('SUPABASE_URL'),
    anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
  );

  final session = Supabase.instance.client.auth.currentSession;

  if (session == null) {
    await Supabase.instance.client.auth.signInAnonymously();
  }

  final dir = await getApplicationSupportDirectory();

  await File('${dir.path}/database.sqlite').delete();

  runApp(const AppProvider(child: AppWidget()));
}

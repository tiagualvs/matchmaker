import 'package:flutter/material.dart';
import 'package:matchmaker/src/app_provider.dart';
import 'package:matchmaker/src/app_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: const String.fromEnvironment('SUPABASE_URL'),
    anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
  );

  runApp(const AppProvider(child: AppWidget()));
}

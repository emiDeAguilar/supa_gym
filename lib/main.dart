import 'package:flutter/material.dart';
import 'package:supa_routines/screens/features/auth/auth_gate.dart';

import 'package:supa_routines/secrets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: Secrets().url,
    anonKey: Secrets().anonKey,
  );
  runApp(MyApp());
}
// WARNING, NOT RECOMMENDED FOR PROD: USE THIS ONLY WHEN EMAIL CONFIRMATION IS DISABLED
final supabase = Supabase.instance.client;
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:AuthGate()
    );
  }
}
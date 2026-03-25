import 'package:flutter/material.dart';
import 'package:supa_routines/screens/features/auth/auth_gate.dart';

import 'package:supa_routines/secrets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: Secrets().url,
    anonKey: Secrets().anonKey,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserState()..loadProfile(),
      child: const MyApp()));
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

class UserState extends ChangeNotifier {
  Map<String, dynamic>? profile;

  Future<void> loadProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    profile = await Supabase.instance.client
        .from('users')
        .select()
        .eq('id', user!.id)
        .single();
    notifyListeners();
  }
}

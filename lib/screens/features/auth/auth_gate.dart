import 'package:flutter/material.dart';
import 'package:supa_routines/main_shell.dart';
import 'package:supa_routines/screens/features/auth/auth_service.dart';
import 'package:supa_routines/screens/features/auth/login_page.dart';
import 'package:supa_routines/screens/features/userForm/add_user_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        // final session = snapshot.hasData ? snapshot.data!.session : null;
        final session = snapshot.data?.session;

        if (session == null) {
          return LoginPage();
        }

        final authId = session.user.id;

        return FutureBuilder<PostgrestMap?>(
          future: AuthService().userSelect(authId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            final data = snapshot.data;

            if (data == null ||
                data['username'] == null ||
                data['gender'] == null ||
                data['birth_date'] == null) {
              return const AddUserPage();
            }

            return const MainShell();
          },
        );
      },
    );
  }
}

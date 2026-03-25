import 'package:flutter/material.dart';
import 'package:supa_routines/screens/features/auth/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authService = AuthService();
  void logOut() async {
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final currentEmail = authService.getCurrentUserEmail();
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
        actions: [IconButton(onPressed: logOut, icon: Icon(Icons.logout))],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Foto
            CircleAvatar(
              radius: 56,
              backgroundColor: colors.primaryContainer,
              child: Icon(
                Icons.person,
                size: 56,
                color: colors.onPrimaryContainer,
              ),
            ),

            const SizedBox(height: 24),

            // Nombre
            Text(
              'Alfonso Aguilar',
              style: text.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            // Rol
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Administrador',
                style: text.labelLarge?.copyWith(
                  color: colors.onPrimaryContainer,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Descripción
            const SizedBox(height: 12),

            // Email
          ],
        ),

        //Center(child: Text(currentEmail.toString()),)
      ),
    );
  }
}

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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
        actions: [IconButton(onPressed: logOut, icon: Icon(Icons.logout))],
      ),

      body: Center(child: Text(currentEmail.toString()),)
    );
  }
}

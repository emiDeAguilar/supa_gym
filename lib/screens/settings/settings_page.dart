import 'package:flutter/material.dart';
import 'package:supa_routines/screens/features/profile/profile_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes')),
      body: ListView(
        children: [
          const SizedBox(height: 10),

          // --- Cuenta ---
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              title: Text(
                'Cuenta',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ),

          const Divider(),

          // --- Preferencias ---
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Preferencias',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          const Divider(),

          // --- General ---
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'General',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:supa_routines/screens/settings/settings_page.dart';
import 'package:supa_routines/widgets/welcome_name.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        //"Go back arrow" deactivated
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [IconButton(
          icon: const Icon(Icons.settings),
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (conext)=>SettingsPage()));}, )],
        
      ),
      body: SafeArea(
        child: Center(
          
            child: WelcomeName(),
        ),
      ),
    );
  }
}

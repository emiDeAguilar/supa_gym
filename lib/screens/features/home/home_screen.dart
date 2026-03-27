import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supa_routines/data/user_provider.dart';
import 'package:supa_routines/screens/settings/settings_page.dart';
import 'package:supa_routines/data/userdata_provider.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
       automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [IconButton(
          icon: const Icon(Icons.settings),
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (conext)=>SettingsPage()));}, )],
        
      ),
      body: SafeArea(
        child: Center(
          child:UserdataProvider(dataBuilder:
             (user) => "Welcome back, ${user['username']}",
            )
        ),
      ),
    );
  }
}

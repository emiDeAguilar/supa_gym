import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //"Go back arrow" deactivated
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text('This is Canada!'),
      ),
      body: SafeArea(
        child: Center(
          
        ),
      ),
    );
  }
}

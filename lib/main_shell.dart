import 'package:flutter/material.dart';
import 'package:supa_routines/screens/exercises/exercises_page.dart';
import 'package:supa_routines/screens/features/home/home_screen.dart';


import 'package:supa_routines/widgets/w_bottom_menu.dart';

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const ExercisesPage(),
      // const ProductListPage(),
      // ProductSale(isActive: _currentIndex == 2),
      //const DashboardScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: BottomMenu(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  _MainShellState createState() => _MainShellState();
}

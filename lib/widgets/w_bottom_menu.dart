import 'package:flutter/material.dart';
import 'package:supa_routines/widgets/circular_button_widget.dart';

class BottomMenu extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomMenu({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircularButton(
              icon: Icons.home,
              label: 'Inicio',
              onPressed: () => onTap(0),
            ),
            CircularButton(
              icon: Icons.fitness_center,
              label: 'Ejercicios',
              onPressed: () => onTap(1),
            ),
            CircularButton(
              icon: Icons.sports_gymnastics,
              label: 'Rutinas',
              onPressed: () => onTap(2),
            ),
            
            // CircularButton(
            //   icon: Icons.verified_user_rounded,
            //   label: 'Dashboard',
            //   onPressed: () => onTap(3),
            // ),
          ],
        ),
      ),
    );
  }
}

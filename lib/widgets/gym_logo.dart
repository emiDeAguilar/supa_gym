import 'package:flutter/material.dart';

class GymLogo extends StatelessWidget {
  final bool isLightBg;
  final double logoSize;

  const GymLogo({super.key, required this.isLightBg, required this.logoSize});

  @override
  Widget build(BuildContext context) {
    Color lightText = Theme.of(context).colorScheme.onPrimaryContainer;
    Color darkText = Colors.white;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: logoSize*0.75,
          child: FittedBox(
            fit: BoxFit.contain,
            child: 
            isLightBg? 
            Image(image: AssetImage('assets/image s/isotipo.png'))
            :
            Image(image: AssetImage('assets/images/isotipo_blanco.png')),
          ),
        ),
        Text(
          'JOSS',
          style: TextStyle(
            color: isLightBg ? lightText : darkText,
            fontSize: logoSize,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'FITNESS',
          style: TextStyle(
            color: isLightBg ? lightText : darkText,
            fontSize: logoSize,
            fontWeight: FontWeight.w400,
            letterSpacing: 2.0,
          ),
        ),
      ],
    );
  }
}

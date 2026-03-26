import 'package:flutter/material.dart';

class GymLogo extends StatelessWidget {
  final bool isDarkBg;
  final double logoSize;

  const GymLogo({super.key, required this.isDarkBg, required this.logoSize});

  @override
  Widget build(BuildContext context) {
    Color lightText = Theme.of(context).colorScheme.onSurface;
    Color darkText = Colors.white;
    

bool isItDark = Theme.of(context).brightness == Brightness.dark;
    

final String asset = isItDark
    ? 'assets/images/isotipo_blanco.png'
    : 'assets/images/isotipo.png';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: logoSize*0.75,
          child: FittedBox(
            fit: BoxFit.contain,
            child: isDarkBg
                ? Image(
                          image: AssetImage('assets/images/isotipo_blanco.png'),)
                      : Image(image: AssetImage(asset))
                
          ),
        ),
        Text(
          'JOSS',
          style: TextStyle(
            color: isDarkBg ?   darkText: lightText,
            fontSize: logoSize,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'FITNESS',
          style: TextStyle(
            color: isDarkBg ?  darkText: lightText ,
            fontSize: logoSize,
            fontWeight: FontWeight.w400,
            letterSpacing: 2.0,
          ),
        ),
      ],
    );
  }
}

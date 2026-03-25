import 'package:flutter/material.dart';

class GymLogo extends StatelessWidget {
  const GymLogo({super.key});

  @override
  Widget build(BuildContext context) {
    Color ColorText = Theme.of(context).colorScheme.onPrimaryContainer;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
             FittedBox(
                          fit: BoxFit.contain,
                            child: Image(
                              image: AssetImage('assets/images/isotipo.png'),
                            ),
                          
                        ),
        Text(
          'JOS',
          style: TextStyle(
            color: ColorText, // Color del texto
            fontSize: 40.0, // Tamaño de fuente grande para destacar
            fontWeight: FontWeight.bold, // Fuente en negrita para impacto
            fontFamily: 'Montserrat', // Fuente moderna y deportiva (opcional, ajusta si tienes fuentes personalizadas)
          ),
        ),  
        SizedBox(height: 10.0), // Espaciado pequeño entre las palabras
        Text(
          'FITNESS',
          style: TextStyle(
            color: ColorText,
            fontSize: 40.0, // Tamaño de fuente más pequeño para el subtítulo
            fontWeight: FontWeight.w400, // Peso de fuente normal
            letterSpacing: 2.0, // Aumentar el espaciado entre letras para un aspecto más limpio
          ),
        ),
      ],
    );
  }
}
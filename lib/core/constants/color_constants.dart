import 'package:flutter/material.dart';

class ColorPalette {
  static const Color primaryColor = Color(0xFFFE9C5E);
  static const Color secondColor = Color.fromARGB(255, 219, 140, 91);
  static const Color yellowColor = Color(0xffFE9C5E);

  static const Color dividerColor = Color(0xFFE5E7EB);
  static const Color text1Color = Color(0xFF323B4B);
  static const Color subTitleColor = Color(0xFF838383);
  static const Color backgorundScaffoldColor = Color(0xFFF2F2F2);

}

class Gradients {
  static const Gradient defaultGradientBackground = LinearGradient(
    begin: Alignment.topLeft,
    end:Alignment.bottomLeft,
    colors: [
      ColorPalette.secondColor,
      ColorPalette.primaryColor,
    ],
  );
}
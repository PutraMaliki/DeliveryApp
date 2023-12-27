import 'package:flutter/material.dart';

class ColorsTheme {
  static const Color primary = Color(0xff3c3c3c);
  static const Color secondary = Color(0xff99D5EE);

  static const Color onPrimary = Color(0xfffcfcfc);
  static const Color onSecondary = Color(0xfffcfcfc);

  static const Color background = Color(0xfffcfcfc);
  static const Color surface = Color(0xfff2f3f8);
  static const Color disabled = Color(0xffa5a4a3);

  static const Color error = Color(0xffffa285);
  static const Color warning = Color(0xfffbd586);
  static const Color success = Color(0xff8ed5d4);

  static const Color button = Color(0xff99D5EE);

  static const Color back1 = Color.fromRGBO(154, 162, 229, 1);
  static const Color back2 = Color.fromRGBO(186, 13, 214, 0.22);

  MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }
}

import 'package:flutter/material.dart';

ThemeData mainTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.pink,
      primary: Colors.pink,
    ),
    textTheme: Theme.of(context).textTheme.apply(
          fontSizeDelta: 2.0,
        ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(primary: Colors.lightBlue),
    ),
  );
}

Color iconColor(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.light) {
    return Colors.lightBlue;
  }

  return Colors.red;
}
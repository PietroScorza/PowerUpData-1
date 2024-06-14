import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  focusColor: Colors.black,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    primaryFixed: Colors.black,
    secondary: Colors.grey.shade400,
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade800,
    onTertiary: Colors.orange,
    onSecondaryContainer: Colors.orange[200]
    ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Colors.grey[800],
    displayColor: Colors.black,
  ),
);
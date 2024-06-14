import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    primaryFixed: Colors.white,
    secondary: Colors.grey.shade700,
    tertiary: Colors.grey.shade200,
    inversePrimary: Colors.grey.shade300, 
    onTertiary: Colors.orange,

  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.grey[300],
    displayColor: Colors.white,
  ),
);
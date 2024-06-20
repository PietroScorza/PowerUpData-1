import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  focusColor: Colors.black,
  brightness: Brightness.light,
  primaryColor: Colors.black,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    primaryFixed: Colors.black,
    secondary: Colors.grey.shade400,
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade800,
    onTertiary: Colors.orange,
    onSecondaryContainer: Colors.orange[200],
    surfaceTint: Colors.black,
    onErrorContainer: Colors.red[400]
    ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Colors.grey[800],
    displayColor: Colors.black,
  
  ),
);
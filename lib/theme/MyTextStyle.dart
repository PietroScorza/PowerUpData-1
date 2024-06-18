import 'package:flutter/material.dart';

TextStyle MyTextStyle(BuildContext context, double size, {FontWeight fontWeight = FontWeight.normal, Color? color}){
  return TextStyle(color: color, fontSize: size, fontWeight: fontWeight);
}
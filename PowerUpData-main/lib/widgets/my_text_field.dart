 import 'package:flutter/material.dart';
 
 class MyTextField extends StatelessWidget {
   final String hintText;
   final bool obscureText;
   final TextEditingController controller;

   const MyTextField({
     required this.hintText,
     required this.obscureText,
     required this.controller,
   });

   @override 
    Widget build(BuildContext context) {
      return TextField(
        style: const TextStyle(
          color: Colors.white,
        ),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
            ),
          ),
        ),
      );
    }
 }
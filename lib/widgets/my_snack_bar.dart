import 'package:flutter/material.dart';

void messageAlert(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), elevation: 4, showCloseIcon: true, duration: const Duration(seconds: 2)),

  );
}

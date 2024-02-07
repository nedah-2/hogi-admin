import 'package:flutter/material.dart';

class MySnackBar {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showSnackBar(String message, {bool isError = true}) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      backgroundColor: isError ? Colors.deepOrange : Colors.green,
      content: Text(message),
      duration: const Duration(milliseconds: 1200),
    ));
  }
}

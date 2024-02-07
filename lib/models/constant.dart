import 'package:flutter/material.dart';
Color successColor = Colors.teal;
Color pendingColor = Colors.blue;
Color warningColor = Colors.orange;
Color dangerColor = Colors.red;
Color confirmColor = Colors.green;

void gotoScreen(BuildContext context,Widget screen){
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => screen)
  );
}

void showMessage(BuildContext context,String message){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message))
  );
}
import 'package:flutter/material.dart';

class CustomSnackBar {

  CustomSnackBar._();

  static successSnackBar(BuildContext context, String message) {
    var snackBar = SnackBar(
      elevation: 0.0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
      content: Text(message),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static errorSnackBar(BuildContext context, String message) {
    var snackBar = SnackBar(
      elevation: 0.0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      content: Text(message),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static infoSnackBar(BuildContext context, String message) {
    var snackBar = SnackBar(
      elevation: 0.0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.blue,
      content: Text(message),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static defaultSnackBar(BuildContext context, String message) {
    var snackBar = SnackBar(
      elevation: 0.0,
      behavior: SnackBarBehavior.floating,
      //backgroundColor: Colors.blue,
      content: Text(message),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

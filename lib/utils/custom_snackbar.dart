import 'package:flutter/material.dart';

// CUSTOM SNACKBAR FOR REUSABILITY
void customSnackBar(BuildContext context, Color color, Widget child) {
  var snackBar = SnackBar(
    backgroundColor: color,
    content: child,
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

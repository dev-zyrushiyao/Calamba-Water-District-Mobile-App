import 'package:flutter/material.dart';

class UserInterfaceService {
  //custom snackbar
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showCustomSnackbar(
    BuildContext context,
    String message,
  ) {
    return ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

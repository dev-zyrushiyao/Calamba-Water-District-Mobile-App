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

  //Adding a dash/hypen on the User Account Number
  String formatAccountNumber({required int accountNumber}) {
    String numberCharacter = accountNumber.toString();
    List<String> listOfCharacters = numberCharacter.split('');

    for (var i = 3; i < listOfCharacters.length; i += 4) {
      listOfCharacters.insert(i, '-');
    }

    return listOfCharacters.join('');
  }
}

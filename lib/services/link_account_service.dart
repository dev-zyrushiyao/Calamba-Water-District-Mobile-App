import 'dart:math';

import 'package:myapp/data-class/user_account.dart' show UserAccount;
import 'package:myapp/data-class/water_account.dart' show WaterAccount;

class LinkAccountService {
  //method to generate number using Generic Type
  T generateNumber<T extends num>({
    required int minValue,
    required int maxValue,
  }) {
    String decimalFormat;
    double rawNum;

    switch (T) {
      case == double:
        rawNum = Random().nextDouble() * (maxValue - minValue) + minValue;
        //convert the generated double to String as 00.00 format
        decimalFormat = rawNum.toStringAsFixed(2);
        //convert back the String into double as return
        return double.parse(decimalFormat) as T;

      case == int:
        return Random().nextInt(maxValue) + minValue as T;

      default:
        throw ArgumentError("Unsupported Type");
    }
  }

  String? validateAccountNumberTextField(String? value) {
    RegExp numberOnly = RegExp(r'^\d+$');
    if (value == null || value.isEmpty) {
      return 'Please enter account number';
    }

    if (value.length != 9) {
      return 'Field must be 9 digits long';
    }

    //only accept numbers 0-9
    if (!numberOnly.hasMatch(value)) {
      return 'Field must contain only numbers';
    }

    //validation pass
    return null;
  }

  String? validateAccountNameTextField(String? value) {
    RegExp letterAndSpaceOnly = RegExp(r'^[a-zA-Z\s]+$');
    if (value == null || value.isEmpty) {
      return 'Please enter account number';
    }

    if (value.length < 2) {
      return 'Field must accepts 2 or more characters';
    }

    //only accept letters and space
    if (!letterAndSpaceOnly.hasMatch(value)) {
      return 'Invalid Character';
    }

    //validation pass
    return null;
  }

  void createLinkAccount(
    UserAccount loggedUser,
    Map<String, dynamic> linkedAccountForm,
  ) {
    //store the map values to the UserObject water account to simulate database saving (one to many relationship)
    //add to the linkedaccount list of UserObject (Owner/Currently Logged in User)
    loggedUser.linkedAccounts.add(
      WaterAccount(
        accountNumber: linkedAccountForm['accountNumber'],
        accountName: linkedAccountForm['accountName'],
        isActive: true, //default value
        previousBill: generateNumber<double>(minValue: 150, maxValue: 700),
        lastReading: generateNumber<double>(minValue: 300, maxValue: 1500),
        dueDay: generateNumber<int>(minValue: 0, maxValue: 30),
        balance: generateNumber<double>(minValue: 150, maxValue: 900),
      ),
    );
  }
}

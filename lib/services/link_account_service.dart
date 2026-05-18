import 'dart:math';

import 'package:myapp/data-class/bill.dart';
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
      return 'Please enter account name';
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

  //generateBill for a year (12 items)
  List<Bill>? generateBill(
    UserAccount loggedUser,
    Map<String, dynamic> linkedAccountForm,
    double generatedAmount,
    double defaultFranchiseTax,
    double generatedArears,
    double calculatedTotalAmount,
    double calculatedDueAfter,
  ) {
    List<Bill> billList = [];
    int month = 12;

    for (var i = 0; i < month; i++) {
      billList.add(
        Bill(
          receiptNumber: generateNumber<int>(
            minValue: 0000001,
            maxValue: 9999999,
          ),
          monthName: 'March',
          accountNumber: linkedAccountForm['accountNumber'],
          dueDate: '03-01-2026',
          readingDate: '02-027-2026',
          meterNumber: generateNumber<int>(minValue: 100000, maxValue: 1000000),
          period: {'start': '04-11-2026', 'end': '05-11,2026'},
          presentReading: generateNumber<int>(minValue: 300, maxValue: 1600),
          previousReading: generateNumber<int>(minValue: 300, maxValue: 1600),
          usedCubicMeters: generateNumber<int>(minValue: 1, maxValue: 50),
          amount: generatedAmount,
          franchiseTax: defaultFranchiseTax,
          septageManagementFee: defaultFranchiseTax,
          arrears: generatedArears,
          totalAmount: calculatedTotalAmount,
          dueAfter: calculatedDueAfter,
        ),
      );
    }

    return billList;
  }

  void createLinkAccount(
    UserAccount loggedUser,
    Map<String, dynamic> linkedAccountForm,
  ) {
    int generatedDueDate = generateNumber<int>(minValue: 1, maxValue: 30);
    int totalDaysOfMonth = 30;
    double penaltyPercentage = 8.87;
    double defaultFranchiseTax = 0.0;
    double generatedArears = generateNumber<double>(minValue: -20, maxValue: 0);
    double generatedSeptageManagementFee = generateNumber<double>(
      minValue: 20,
      maxValue: 150,
    );
    double generatedPreviousReading = generateNumber<double>(
      minValue: 300,
      maxValue: 1500,
    );
    double generatedAmount = generateNumber<double>(
      minValue: 150,
      maxValue: 900,
    );
    double calculatedTotalAmount =
        generatedAmount +
        defaultFranchiseTax +
        generatedSeptageManagementFee +
        generatedArears;
    double calculatedDueAfter = generatedAmount * (penaltyPercentage / 100);
    //store the map values to the UserObject water account to simulate database saving (one to many relationship)
    //add to the linkedaccount list of UserObject (Owner/Currently Logged in User)
    loggedUser.linkedAccounts.add(
      WaterAccount(
        accountNumber: linkedAccountForm['accountNumber'],
        accountName: linkedAccountForm['accountName'],
        isActive: true, //default value
        previousBill: generateNumber<double>(minValue: 150, maxValue: 700),
        lastReading: generatedPreviousReading,
        dueDate: generatedDueDate,
        remainingDayDue: totalDaysOfMonth - generatedDueDate,
        balance: generateNumber<double>(minValue: 150, maxValue: 900),
        bill:
            generateBill(
              loggedUser,
              linkedAccountForm,
              generatedAmount,
              defaultFranchiseTax,
              generatedArears,
              calculatedTotalAmount,
              calculatedDueAfter,
            ) ??
            [], // if the generateBill method fails to fire it will produce an empty instance of a list and not a null value for the bill property
      ),
    );
  }
}

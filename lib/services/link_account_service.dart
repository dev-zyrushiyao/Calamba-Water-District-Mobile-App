import 'dart:math';

import 'package:myapp/data-class/bill.dart';
import 'package:myapp/data-class/constants/month_enum.dart';
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
    final RegExp numberOnly = RegExp(r'^\d+$');
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
    final RegExp letterAndSpaceOnly = RegExp(r'^[a-zA-Z\s]+$');
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

  List<String> getMonth() {
    final List<String> listOfMonth = [];

    //loop through the values of Month Enum
    for (var item in Month.values) {
      //transfer the Month values [jan, feb , mar ..] to a new list []
      //New list will add value that is capitalized already [Jan , Feb , Mar ..]
      listOfMonth.add(item.capitalize);
    }

    return listOfMonth;
  }

  List<String> generateDate({
    bool? isDueDate,
    bool? isReadingRate,
    int? generatedDueDay,
  }) {
    int year = 2026;
    int totalMonth = 12;
    List<String> dueDateList = [];

    if (isDueDate == true) {
      try {
        //generateDueDate
        if (generatedDueDay != null) {
          for (var i = 0; i < totalMonth; i++) {
            DateTime calculatedDate = DateTime(year, i + 1, generatedDueDay);
            String formattedDate =
                '${calculatedDate.month}-${calculatedDate.day}-${calculatedDate.year}';
            dueDateList.add(formattedDate);
          }
        }
      } catch (e) {
        throw ArgumentError(e);
      }
    }

    if (isReadingRate == true) {
      try {
        int startDate = 1;
        for (var i = 0; i < totalMonth; i++) {
          DateTime calculatedDate = DateTime(year, i + 1, startDate);
          String formattedDate =
              '${calculatedDate.month}-${calculatedDate.day}-${calculatedDate.year}';
          dueDateList.add(formattedDate);
        }
      } catch (e) {
        throw ArgumentError(e);
      }
    }

    return dueDateList;
  }

  //generateBill for a year (12 items)
  List<Bill>? generateBill(
    UserAccount loggedUser,
    Map<String, dynamic> linkedAccountForm,
    int generatedDueDay,
  ) {
    final List<Bill> billList = [];
    final int month = 12;

    //consistent value
    final double penaltyPercentage = 8.87;
    final double defaultFranchiseTax = 0.0;
    final int meterNumber = generateNumber<int>(
      minValue: 100000,
      maxValue: 1000000,
    );

    //get the month
    List<String> listOfMonth = getMonth();
    //get duedate
    List<String> listOfDueDate = generateDate(
      isDueDate: true,
      generatedDueDay: generatedDueDay,
    );
    //get reading date
    List<String> listOfReadingDate = generateDate(isReadingRate: true);

    for (var index = 0; index < month; index++) {
      //generate on each loop
      final double generatedArears = generateNumber<double>(
        minValue: -20,
        maxValue: 0,
      );
      final double generatedSeptageManagementFee = generateNumber<double>(
        minValue: 20,
        maxValue: 150,
      );

      final double generatedAmount = generateNumber<double>(
        minValue: 150,
        maxValue: 900,
      );
      final double calculatedTotalAmount =
          generatedAmount +
          defaultFranchiseTax +
          generatedSeptageManagementFee +
          generatedArears;
      final double calculatedDueAfter =
          generatedAmount * (penaltyPercentage / 100);

      billList.add(
        Bill(
          receiptNumber: generateNumber<int>(
            minValue: 0000001,
            maxValue: 9999999,
          ),
          monthName: listOfMonth[index],
          accountNumber: linkedAccountForm['accountNumber'],
          dueDate: listOfDueDate[index],
          readingRate: listOfReadingDate[index],
          meterNumber: meterNumber,
          period: {'start': '04-11-2026', 'end': '05-11-2026 (PLACEHOLDER)'},
          presentReading: generateNumber<int>(minValue: 300, maxValue: 1600),
          previousReading: generateNumber<int>(minValue: 300, maxValue: 1600),
          usedCubicMeters: generateNumber<int>(minValue: 1, maxValue: 50),
          amount: generatedAmount,
          franchiseTax: defaultFranchiseTax,
          septageManagementFee: generatedSeptageManagementFee,
          arrears: generatedArears,
          totalAmount:
              double.tryParse(calculatedTotalAmount.toStringAsFixed(2)) ?? 0.0,
          dueAfter:
              double.tryParse(
                (calculatedTotalAmount + calculatedDueAfter).toStringAsFixed(2),
              ) ??
              0.0,
        ),
      );
    }

    return billList;
  }

  void createLinkAccount(
    UserAccount loggedUser,
    Map<String, dynamic> linkedAccountForm,
  ) {
    int generatedDueDay = generateNumber<int>(minValue: 1, maxValue: 30);
    int totalDaysOfMonth = 30;
    double generatedPreviousReading = generateNumber<double>(
      minValue: 300,
      maxValue: 1500,
    );

    //store the map values to the UserObject water account to simulate database saving (one to many relationship)
    //add to the linkedaccount list of UserObject (Owner/Currently Logged in User)
    loggedUser.linkedAccounts.add(
      WaterAccount(
        accountNumber: linkedAccountForm['accountNumber'],
        accountName: linkedAccountForm['accountName'],
        isActive: true, //default value
        previousBill: generateNumber<double>(minValue: 150, maxValue: 700),
        lastReading: generatedPreviousReading,
        dueDay: generatedDueDay,
        remainingDayDue: totalDaysOfMonth - generatedDueDay,
        balance: generateNumber<double>(minValue: 150, maxValue: 900),
        bill:
            generateBill(loggedUser, linkedAccountForm, generatedDueDay) ??
            [], // if the generateBill method fails to fire it will produce an empty instance of a list and not a null value for the bill property
        receipt: [],
        ticket: [],
      ),
    );
  }
}

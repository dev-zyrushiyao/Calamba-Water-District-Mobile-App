import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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

  String convertReceiptDateFormat({
    required DateTime date,
    bool receiptListFormat = false,
  }) {
    String receiptTimestamp = DateFormat(
      receiptListFormat ? "MMM d, yyyy" : "E, MMM d, yyyy 'at' hh:mm a",
    ).format(date);

    return receiptTimestamp;
  }

  String convertToCalendarDateFormat(DateTime date, [bool? chatSupportFormat]) {
    if (chatSupportFormat == true) {
      //Sample Format: Sat, May 23, 2026
      String receiptTimestamp = DateFormat("E , MMM d, hh:mm a").format(date);

      return receiptTimestamp;
    }

    //Sample Format: Sat, May 23, 2026
    String receiptTimestamp = DateFormat("E , MMM d, yyyy").format(date);

    return receiptTimestamp;
  }

  //Account status color
  Color getAccountStatusColor(bool isActive) {
    if (isActive) {
      return Color(0xFFC8F2CF);
    } else {
      return Colors.grey[400]!;
    }
  }

  DateTime getManilaTimezone() {
    // from the import dependency timezone & latest
    // import 'package:timezone/data/latest.dart' as tz;
    // import 'package:timezone/timezone.dart' as tz;
    tz.initializeTimeZones();
    final manilaLocation = tz.getLocation('Asia/Manila');
    final manilaTime = tz.TZDateTime.now(manilaLocation);

    return manilaTime;
  }
}

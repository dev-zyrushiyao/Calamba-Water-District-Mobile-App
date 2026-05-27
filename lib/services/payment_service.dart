import 'dart:math';
import 'package:collection/collection.dart';

import 'package:myapp/data-bank/receipt.dart';
import 'package:myapp/data-class/constants/biller_enum.dart';
import 'package:myapp/data-class/constants/payment_method_enum.dart';
import 'package:myapp/data-class/water_account.dart';
import 'package:myapp/services/user_interface_service.dart';

class PaymentService {
  String generateTransactionNumber() {
    //generate 8 digit number
    var transactionNumber = Random().nextInt(80_000_000) + 10_000_000;

    //convert the generated number as List
    List<String> transactionNumberAsList = transactionNumber.toString().split(
      '',
    );
    //loop and add '-' the 5th index
    for (var i = 5; i < transactionNumberAsList.length; i += 6) {
      transactionNumberAsList.insert(5, '-');
    }

    //return the new value as string
    return transactionNumberAsList.join();
  }

  Future<void> saveAndCreateReceipt({
    required WaterAccount waterAccount,
    required String transactionNumber,
    required Biller billerName,
    required double inputAmount,
    required PaymentMethod paymentMethod,
  }) async {
    final UserInterfaceService userInterfaceService = UserInterfaceService();
    final manilaTime = userInterfaceService.getManilaTimezone();
    //add receipt object
    waterAccount.receipt.add(
      Receipt(
        transactionNumber: transactionNumber,
        billerName: billerName.value,
        amount: inputAmount,
        paymentMethod: paymentMethod.value,
        date: manilaTime,
      ),
    );

    //deduct balance
    waterAccount.balance = waterAccount.balance - inputAmount;
  }

  Future<Receipt?> searchReceiptToDisplay({
    required String searchTransactionNumber,
    required List<Receipt>? waterAccountReceipt,
  }) async {
    //search receipt then return it as object

    if (waterAccountReceipt != null) {
      return waterAccountReceipt.firstWhereOrNull(
        (item) => searchTransactionNumber == item.transactionNumber,
      );
    }

    return null;
  }
}

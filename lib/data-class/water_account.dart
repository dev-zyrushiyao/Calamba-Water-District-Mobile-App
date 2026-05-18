//WaterAccount -> LinkedAccountList -> HomeIndex -> DashBoardAccount

import 'package:myapp/data-class/bill.dart';

class WaterAccount {
  //Widget of Accounts

  String accountName; //removed the final to be editable
  final int accountNumber;
  final bool isActive;
  final double previousBill;
  final double lastReading;
  final int dueDate;
  final int remainingDayDue;
  final double balance;
  final List<Bill>? bill; //removed the final so it can be added later

  WaterAccount({
    required this.accountName,
    required this.accountNumber,
    this.isActive = true, //Added true as default value
    required this.previousBill,
    required this.lastReading,
    required this.dueDate,
    required this.remainingDayDue,
    required this.balance,
    required this.bill,
  });
}

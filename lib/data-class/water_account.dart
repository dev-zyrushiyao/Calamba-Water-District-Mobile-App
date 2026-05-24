//WaterAccount -> LinkedAccountList -> HomeIndex -> DashBoardAccount

import 'package:myapp/data-bank/receipt.dart';
import 'package:myapp/data-class/bill.dart';
import 'package:myapp/data-class/ticket.dart';

class WaterAccount {
  //Widget of Accounts

  String accountName; //removed the final to be editable
  final int accountNumber;
  final bool isActive;
  final double previousBill;
  final double lastReading;
  final int dueDay;
  final int remainingDayDue;
  double balance; //removed the final to be editable
  final List<Bill>? bill;
  final List<Receipt>? receipt;
  final List<Ticket>? ticket;

  WaterAccount({
    required this.accountName,
    required this.accountNumber,
    this.isActive = true, //Added true as default value
    required this.previousBill,
    required this.lastReading,
    required this.dueDay,
    required this.remainingDayDue,
    required this.balance,
    required this.bill,
    required this.receipt,
    required this.ticket,
  });
}

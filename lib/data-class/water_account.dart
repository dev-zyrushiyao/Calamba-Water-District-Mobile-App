//WaterAccount -> LinkedAccountList -> HomeIndex -> DashBoardAccount

import 'package:flutter/material.dart';
import 'package:myapp/data-bank/receipt.dart';
import 'package:myapp/data-class/bill.dart';
import 'package:myapp/data-class/constants/water_account_status_enum.dart';
import 'package:myapp/data-class/ticket.dart';

class WaterAccount {
  //Widget of Accounts

  String accountName; //removed the final to be editable
  final int accountNumber;
  final WaterAccountStatus isActive;
  final double previousBill;
  final double lastReading;
  final int dueDay;
  final int remainingDayDue;
  double balance; //removed the final to be editable
  final List<Bill> bill;
  final List<Receipt> receipt;
  final List<Ticket> ticket;

  WaterAccount({
    required this.accountName,
    required this.accountNumber,
    this.isActive = WaterAccountStatus.active, //Added active as default value
    required this.previousBill,
    required this.lastReading,
    required this.dueDay,
    required this.remainingDayDue,
    required this.balance,
    required this.bill,
    required this.receipt,
    required this.ticket,
  });

  Color get statusColor {
    if (isActive == WaterAccountStatus.active) {
      return Color(0xFFC8F2CF);
    } else {
      return Colors.grey[400]!;
    }
  }
}

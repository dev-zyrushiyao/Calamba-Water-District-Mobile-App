//WaterAccount -> LinkedAccountList -> HomeIndex -> DashBoardAccount

import 'package:flutter/material.dart';
import 'package:myapp/data-bank/receipt.dart';
import 'package:myapp/data-class/bill.dart';
import 'package:myapp/data-class/constants/water_account_status_enum.dart';
import 'package:myapp/data-class/ticket.dart';

class WaterAccount {
  final String accountName; //removed the final to be editable
  final int accountNumber;
  final WaterAccountStatus isActive;
  final double previousBill;
  final double lastReading;
  final int dueDay;
  final int remainingDayDue;
  final double balance; //removed the final to be editable
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

  WaterAccount copyWith({
    String? accountName,
    int? accountNumber,
    WaterAccountStatus? isActive,
    double? previousBill,
    double? lastReading,
    int? dueDay,
    int? remainingDayDue,
    double? balance,
    List<Bill>? bill,
    List<Receipt>? receipt,
    List<Ticket>? ticket,
  }) {
    return WaterAccount(
      accountName: accountName ?? this.accountName,
      accountNumber: accountNumber ?? this.accountNumber,
      isActive: isActive ?? this.isActive,
      previousBill: previousBill ?? this.previousBill,
      lastReading: lastReading ?? this.lastReading,
      dueDay: dueDay ?? this.dueDay,
      remainingDayDue: remainingDayDue ?? this.remainingDayDue,
      balance: balance ?? this.balance,
      bill: bill ?? this.bill,
      receipt: receipt ?? this.receipt,
      ticket: ticket ?? this.ticket,
    );
  }

  Color get statusColor {
    if (isActive == WaterAccountStatus.active) {
      return Color(0xFFC8F2CF);
    } else {
      return Colors.grey[400]!;
    }
  }
}

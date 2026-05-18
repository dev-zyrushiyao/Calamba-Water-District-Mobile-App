import 'package:myapp/data-class/water_account.dart';

class WaterAccountList {
  // Simulates database of accounts
  // unused assets for testing purposes
  final List<WaterAccount> accounts = [
    WaterAccount(
      accountName: 'Zyrus Hiyao',
      accountNumber: 591482637,
      isActive: true,
      previousBill: 373.25,
      lastReading: 124.0,
      dueDate: 25,
      remainingDayDue: 3,
      balance: 346.00,
      bill: null,
    ),

    WaterAccount(
      accountName: 'Paulo Nase',
      accountNumber: 591482637,
      isActive: true,
      previousBill: 373.25,
      lastReading: 124.0,
      dueDate: 21,
      remainingDayDue: 6,
      balance: 346.00,
      bill: null,
    ),

    WaterAccount(
      accountName: 'Felip Suson',
      accountNumber: 415882361,
      isActive: true,
      previousBill: 289.25,
      lastReading: 110.0,
      dueDate: 25,
      remainingDayDue: 3,
      balance: 235.00,
      bill: null,
    ),

    WaterAccount(
      accountName: 'Stell Ajero',
      accountNumber: 415882361,
      isActive: true,
      previousBill: 289.25,
      lastReading: 110.0,
      dueDate: 16,
      remainingDayDue: 7,
      balance: 235.00,
      bill: null,
    ),

    WaterAccount(
      accountName: 'Justin De Dios',
      accountNumber: 415882361,
      isActive: true,
      previousBill: 289.25,
      lastReading: 110.0,
      dueDate: 19,
      remainingDayDue: 4,
      balance: 235.00,
      bill: null,
    ),
  ];
}

import 'package:myapp/data-class/water_account.dart';

class WaterAccountList {
  // Simulates database of accounts
  // unused assets for testing purposes
  final List<WaterAccount> accounts = [
    WaterAccount(
      accountName: 'Zyrus Hiyao',
      accountNumber: '591-482-637',
      isActive: true,
      previousBill: 373.25,
      lastReading: 124.0,
      dueDay: 3,
      balance: 346.00,
    ),

    WaterAccount(
      accountName: 'Paulo Nase',
      accountNumber: '591-482-637',
      isActive: true,
      previousBill: 373.25,
      lastReading: 124.0,
      dueDay: 3,
      balance: 346.00,
    ),

    WaterAccount(
      accountName: 'Felip Suson',
      accountNumber: '415-882-361',
      isActive: true,
      previousBill: 289.25,
      lastReading: 110.0,
      dueDay: 12,
      balance: 235.00,
    ),

    WaterAccount(
      accountName: 'Stell Ajero',
      accountNumber: '415-882-361',
      isActive: true,
      previousBill: 289.25,
      lastReading: 110.0,
      dueDay: 12,
      balance: 235.00,
    ),

    WaterAccount(
      accountName: 'Justin De Dios',
      accountNumber: '415-882-361',
      isActive: true,
      previousBill: 289.25,
      lastReading: 110.0,
      dueDay: 12,
      balance: 235.00,
    ),
  ];
}

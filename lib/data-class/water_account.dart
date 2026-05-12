//WaterAccount -> LinkedAccountList -> HomeIndex -> DashBoardAccount

class WaterAccount {
  //Widget of Accounts

  final String accountName;
  final String accountNumber;
  final bool isActive;
  final double previousBill;
  final double lastReading;
  final int dueDay;
  final double balance;

  WaterAccount({
    required this.accountName,
    required this.accountNumber,
    this.isActive = true,
    required this.previousBill,
    required this.lastReading,
    required this.dueDay,
    required this.balance,
  });
}

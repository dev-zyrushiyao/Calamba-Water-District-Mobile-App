//LinkedWaterAccount -> LinkedAccountList -> HomeIndex -> DashBoardAccount

class LinkedWaterAccount {
  //Widget of Accounts

  final String accountName;
  final String accountNumber;
  final bool isActive;
  final double previousBill;
  final double lastReading;
  final int dueDay;
  final double balance;

  LinkedWaterAccount({
    required this.accountName,
    required this.accountNumber,
    required this.isActive,
    required this.previousBill,
    required this.lastReading,
    required this.dueDay,
    required this.balance,
  });
}

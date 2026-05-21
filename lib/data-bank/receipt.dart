class Receipt {
  final String transactionNumber;
  final String billerName;
  final int amount;
  final int currentBalance;
  final String paymentMethod;

  Receipt({
    required this.transactionNumber,
    this.billerName = 'Calamba Water District',
    required this.amount,
    required this.currentBalance,
    required this.paymentMethod,
  });

  DateTime get date => DateTime.now();
}

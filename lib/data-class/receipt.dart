class Receipt {
  final String transactionNumber;
  final String billerName;
  final double amount;
  final String paymentMethod;
  final DateTime date;

  Receipt({
    required this.transactionNumber,
    required this.billerName,
    required this.amount,
    required this.paymentMethod,
    required this.date,
  });
}

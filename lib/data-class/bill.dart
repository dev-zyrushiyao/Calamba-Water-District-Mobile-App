class Bill {
  Bill({
    required this.receiptNumber,
    required this.monthName,
    required this.accountNumber,
    required this.dueDate,
    required this.readingRate,
    required this.meterNumber,
    required this.period,
    required this.presentReading,
    required this.previousReading,
    required this.usedCubicMeters,
    required this.amount,
    required this.franchiseTax,
    required this.septageManagementFee,
    required this.arrears,
    required this.totalAmount,
    required this.dueAfter,
  });

  final int receiptNumber;
  final String monthName;
  final int accountNumber;
  final String dueDate;
  final String readingRate;
  final int meterNumber;
  final Map<String, String>
  period; //[key-{'start' , 'end'} , value-{'3123213 , '219024'}]
  final int presentReading;
  final int previousReading;
  final int usedCubicMeters;
  final double amount; //base bill
  final double franchiseTax;
  final double septageManagementFee;
  final double arrears;
  final double totalAmount;
  final double dueAfter;
}

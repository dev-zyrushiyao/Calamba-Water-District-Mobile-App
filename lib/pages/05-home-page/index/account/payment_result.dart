import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/receipt_container.dart';
import 'package:myapp/data-bank/receipt.dart';
import 'package:intl/intl.dart';

class PaymentResult extends StatelessWidget {
  const PaymentResult({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final data = ModalRoute.of(context)?.settings.arguments as Receipt?;

    if (data == null) {
      return DisplayNoData();
    }

    debugPrint(data.date.toString());
    debugPrint('Local Time ${DateTime.now().toLocal()}');

    //from the dependency intl
    String receiptTimestamp = DateFormat(
      "E, MMM d, yyyy 'at' hh:mm a",
    ).format(data.date);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            SizedBox(
              child: Column(
                spacing: 10,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: theme.colorScheme.primary,
                    size: 100,
                  ),
                  Headline(
                    headline: 'Payment Success!',
                    subHeadline:
                        'Your payment has been received and is currently being processed. A digital receipt has been sent to your email for your records.',
                    textAlign: TextAlign.center,
                    spacing: 20,
                    elementAlignment: CrossAxisAlignment.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            ReceiptContainer(
              actions: [
                {'Transaction No.': data.transactionNumber},
                {'Biller:': data.billerName},
                {'Amount:': data.amount.toString()},
                {'Date:': receiptTimestamp},
                {'Payment Method:': data.paymentMethod},
              ],
            ),
          ],
        ),
      ),
    );
  }
}

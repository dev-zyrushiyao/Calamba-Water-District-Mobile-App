import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/custom-widgets/receipt_container.dart';
import 'package:myapp/data-bank/receipt.dart';
import 'package:intl/intl.dart';
import 'package:myapp/services/payment_service.dart';
import 'package:myapp/services/user_interface_service.dart';

class PaymentResult extends StatelessWidget {
  const PaymentResult({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final data = ModalRoute.of(context)?.settings.arguments as Receipt?;

    final UserInterfaceService userInterfaceService = UserInterfaceService();

    if (data == null) {
      return DisplayNoData();
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
          children: [
            SizedBox(
              child: Column(
                spacing: 5,
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
                    spacing: 10,
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
                {'Amount:': data.amount.toStringAsFixed(2)},
                {
                  'Date:': userInterfaceService.convertReceiptDateFormat(
                    date: data.date,
                  ),
                },
                {'Payment Method:': data.paymentMethod},
              ],
            ),

            SizedBox(height: 20),

            PrimaryButton(
              label: 'Return to Homepage',
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

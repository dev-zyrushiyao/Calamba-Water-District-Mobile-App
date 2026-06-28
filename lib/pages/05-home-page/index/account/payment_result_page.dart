import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/custom-widgets/circular_copy_button.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/custom-widgets/receipt_container.dart';
import 'package:myapp/providers/auth_provider.dart';

import 'package:myapp/services/user_interface_service.dart';

class PaymentResultPage extends ConsumerWidget {
  const PaymentResultPage({super.key, required this.receiptData});

  final Map<String, dynamic>? receiptData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);

    final data = receiptData;

    if (data == null) {
      return DisplayNoData();
    }

    final receipt = data['receipt'];
    final waterAccount = data['waterAccount'];

    final _ = ref.watch(authNotifierProvider);

    final UserInterfaceService userInterfaceService = UserInterfaceService();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  const Headline(
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

            const SizedBox(height: 20),

            ReceiptContainer(
              copyButton: CircularCopyButton(
                targetTextToCopy: receipt.transactionNumber,
              ),
              actions: [
                {'Transaction No.': receipt.transactionNumber},
                {'Biller:': receipt.billerName},
                {'Amount:': receipt.amount.toStringAsFixed(2)},
                {
                  'Date:': userInterfaceService.convertReceiptDateFormat(
                    date: receipt.date,
                  ),
                },
                {'Payment Method:': receipt.paymentMethod},
              ],
            ),

            const SizedBox(height: 20),

            PrimaryButton(
              label: 'Return to Account Page',
              width: double.infinity,
              onPressed: () {
                context.push('/accountinformation', extra: waterAccount);
              },
            ),
          ],
        ),
      ),
    );
  }
}

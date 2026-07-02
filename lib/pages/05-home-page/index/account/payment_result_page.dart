import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/custom-widgets/circular_copy_button.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/custom-widgets/receipt_container.dart';
import 'package:myapp/models/receipt.dart';
import 'package:myapp/models/water_account.dart';
import 'package:myapp/providers/auth_provider.dart';

import 'package:myapp/services/user_interface_service.dart';

class PaymentResultPage extends ConsumerWidget {
  const PaymentResultPage({super.key, this.receiptData});

  final Map<String, dynamic>? receiptData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);

    final _ = ref.watch(authProvider);
    final data = receiptData;

    if (data == null) {
      return DisplayNoData();
    }

    final receipt = data['receipt'] as Receipt?;
    final waterAccount = data['waterAccount'] as WaterAccount?;

    if (receipt == null || waterAccount == null) {
      return DisplayNoData();
    }

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
                final loggedAccount = ref.read(authProvider);
                if (loggedAccount == null) return;

                //looks for WaterAccount from the state
                //Making sure the state gets updated value
                //instead of passing the modified waterAccount to /accountInformation
                //stateWaterAccount and waterAccount should have the same value
                final stateWaterAccount = loggedAccount.linkedAccounts
                    .firstWhere(
                      (account) =>
                          account.accountNumber == waterAccount.accountNumber,
                    );

                context.go(
                  '/home/accountinformation',
                  extra: {'waterAccount': stateWaterAccount},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

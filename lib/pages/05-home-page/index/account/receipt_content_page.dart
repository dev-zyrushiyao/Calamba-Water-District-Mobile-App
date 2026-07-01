import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/custom-widgets/appbar_custom_header.dart';
import 'package:myapp/custom-widgets/circular_copy_button.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/receipt_container.dart';
import 'package:myapp/data-class/receipt.dart';

import 'package:myapp/providers/auth_provider.dart';
import 'package:myapp/services/user_interface_service.dart';

class ReceiptContentPage extends ConsumerStatefulWidget {
  const ReceiptContentPage({super.key, this.receiptData});

  final Map<String, dynamic>? receiptData;

  @override
  ConsumerState<ReceiptContentPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<ReceiptContentPage> {
  final UserInterfaceService _userInterfaceService = UserInterfaceService();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final _ = ref.watch(authNotifierProvider);
    final data = widget.receiptData;

    if (data == null) {
      ArgumentError.notNull('data');
      return DisplayNoData();
    }

    final receipt = data['receipt'] as Receipt?;

    if (receipt == null) {
      ArgumentError.notNull('waterAccount');
      return DisplayNoData();
    }

    return Scaffold(
      appBar: AppBar(
        title: AppbarCustomHeader(
          title: 'Transaction #${receipt.transactionNumber}',
          subtitle: _userInterfaceService.convertReceiptDateFormat(
            date: receipt.date,
            receiptListFormat: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Column(
                spacing: 9.0,
                children: [
                  Text(
                    'Calamba Water District',
                    style: theme.textTheme.headlineSmall,
                  ),
                  Text(
                    'Official Receipt',
                    style: theme.textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            ReceiptContainer(
              copyButton: CircularCopyButton(
                targetTextToCopy: receipt.transactionNumber,
              ),
              actions: [
                {'Transaction No.': receipt.transactionNumber},
                {'Biller:': receipt.billerName},
                {'Amount:': receipt.amount.toStringAsFixed(2)},
                {
                  'Date:': _userInterfaceService.convertReceiptDateFormat(
                    date: receipt.date,
                  ),
                },
                {'Payment Method:': receipt.paymentMethod},
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/appbar_custom_header.dart';
import 'package:myapp/custom-widgets/circular_copy_button.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/receipt_container.dart';
import 'package:myapp/data-bank/receipt.dart';
import 'package:myapp/services/user_interface_service.dart';

class ReceiptContentPage extends StatefulWidget {
  const ReceiptContentPage({super.key});

  @override
  State<ReceiptContentPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ReceiptContentPage> {
  final UserInterfaceService _userInterfaceService = UserInterfaceService();

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Receipt?;
    final ThemeData theme = Theme.of(context);

    if (data == null) {
      return DisplayNoData();
    }

    return Scaffold(
      appBar: AppBar(
        title: AppbarCustomHeader(
          title: 'Transaction #${data.transactionNumber}',
          subtitle: _userInterfaceService.convertReceiptDateFormat(
            date: data.date,
            receiptListFormat: true,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          const SizedBox(height: 93),
          SizedBox(
            child: Column(
              spacing: 9.0,
              children: [
                Text(
                  'Calamba Water District',
                  style: theme.textTheme.headlineSmall,
                ),
                Text('Official Receipt', style: theme.textTheme.headlineMedium),
              ],
            ),
          ),
          const SizedBox(height: 35),
          ReceiptContainer(
            copyButton: CircularCopyButton(
              targetTextToCopy: data.transactionNumber,
            ),
            actions: [
              {'Transaction No.': data.transactionNumber},
              {'Biller:': data.billerName},
              {'Amount:': data.amount.toStringAsFixed(2)},
              {
                'Date:': _userInterfaceService.convertReceiptDateFormat(
                  date: data.date,
                ),
              },
              {'Payment Method:': data.paymentMethod},
            ],
          ),
        ],
      ),
    );
  }
}

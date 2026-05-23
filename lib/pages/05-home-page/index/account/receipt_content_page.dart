import 'package:flutter/material.dart';
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Transaction #${data.transactionNumber}'),
            Text(
              _userInterfaceService.convertReceiptDateFormat(
                date: data.date,
                receiptListFormat: true,
              ),
              style: theme.textTheme.labelSmall?.copyWith(
                color: Color(0xFF616161),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          SizedBox(height: 93),
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
          SizedBox(height: 35),
          ReceiptContainer(
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

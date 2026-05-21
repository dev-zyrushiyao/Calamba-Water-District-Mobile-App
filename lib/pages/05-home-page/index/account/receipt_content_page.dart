import 'package:flutter/material.dart';

class ReceiptContentPage extends StatefulWidget {
  const ReceiptContentPage({super.key});

  @override
  State<ReceiptContentPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ReceiptContentPage> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Receipt Number')),
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
          Container(
            padding: EdgeInsets.all(30),
            height: 500,
            decoration: BoxDecoration(
              color: Color(0xFF5456A7),
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Receipt #:',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Transaction No:',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Biller:',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Amount:',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Date:',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Current Balance:',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Payment Method:',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

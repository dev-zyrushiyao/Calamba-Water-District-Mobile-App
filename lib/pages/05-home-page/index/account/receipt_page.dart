import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/data-bank/receipt.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as List<Receipt>?;

    if (data == null || data.isEmpty) {
      return DisplayNoData();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Receipt')),
      body: ListView(
        physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 60),
          Align(
            //Used align to break the container filling all the width available from the ListView
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7),
              decoration: BoxDecoration(
                border: BoxBorder.fromSTEB(bottom: BorderSide()),
              ),
              child: const Headline(headline: 'Receipt'),
            ),
          ),
        ],
      ),
    );
  }
}

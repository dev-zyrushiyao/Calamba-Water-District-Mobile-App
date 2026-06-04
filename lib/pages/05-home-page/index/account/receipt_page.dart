import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/data-bank/receipt.dart';
import 'package:myapp/services/user_interface_service.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as List<Receipt>?;

    //service
    final UserInterfaceService userInterfaceService = UserInterfaceService();

    //theme
    final ThemeData theme = Theme.of(context);

    if (data == null || data.isEmpty) {
      return DisplayNoData();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Receipt')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
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
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 20),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 30),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/receiptcontent',
                        arguments: data[index],
                      );
                    },
                    child: SizedBox(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '• Transaction #',
                              style: theme.textTheme.bodyLarge,
                            ),

                            TextSpan(
                              text: data[index].transactionNumber,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            TextSpan(
                              text: ' - ',
                              style: theme.textTheme.bodyLarge,
                            ),

                            TextSpan(
                              text: userInterfaceService
                                  .convertReceiptDateFormat(
                                    date: data[index].date,
                                    receiptListFormat: true,
                                  ),
                              style: theme.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

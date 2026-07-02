import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/models/water_account.dart';
import 'package:myapp/providers/auth_provider.dart';
import 'package:myapp/services/user_interface_service.dart';

class ReceiptPage extends ConsumerWidget {
  const ReceiptPage({super.key, this.linkedAccountData});

  final Map<String, dynamic>? linkedAccountData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _ = ref.watch(authProvider);

    //service
    final UserInterfaceService userInterfaceService = UserInterfaceService();

    //theme
    final ThemeData theme = Theme.of(context);

    final data = linkedAccountData;
    if (data == null || data.isEmpty) {
      ArgumentError('data');
      return DisplayNoData();
    }

    final waterAccount = data['waterAccount'] as WaterAccount?;

    if (waterAccount == null) {
      ArgumentError('waterAccount');
      return DisplayNoData();
    }

    final reversedReceiptList = waterAccount.receipt.reversed.toList();

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
                itemCount: reversedReceiptList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      context.push(
                        '/receipt/receiptcontent',
                        extra: {'receipt': reversedReceiptList[index]},
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
                              text:
                                  reversedReceiptList[index].transactionNumber,
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
                                    date: reversedReceiptList[index].date,
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

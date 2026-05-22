import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/data-bank/account_type.dart';
import 'package:myapp/data-bank/receipt.dart';
import 'package:myapp/data-class/constants/biller_enum.dart';
import 'package:myapp/data-class/constants/payment_method_enum.dart';
import 'package:myapp/data-class/user_account.dart';
import 'package:myapp/data-class/water_account.dart';
import 'package:myapp/services/payment_service.dart';

class PaymentConfirmation extends StatelessWidget {
  const PaymentConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    //logged user account
    final UserAccount loggedUser = AccountType().owner;

    //service
    final PaymentService paymentService = PaymentService();

    //theme
    final ThemeData theme = Theme.of(context);

    final data = ModalRoute.of(context)?.settings.arguments as Map?;

    if (data == null) {
      return const DisplayNoData();
    }

    final double inputAmount = data['inputAmount'];
    final WaterAccount waterAccount = data['waterAccount'];

    return Scaffold(
      appBar: AppBar(title: Text('Payment Confirmation')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 60.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  spacing: 40,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    SizedBox(
                      child: Text(
                        'Payment Confirmation',
                        style: theme.textTheme.headlineMedium,
                      ),
                    ),
                    Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDisplayItem(
                          'Biller',
                          Biller.calambaWaterDistrict.value,
                          theme,
                        ),
                        _buildDisplayItem(
                          'Amount',
                          inputAmount.toString(),
                          theme,
                        ),
                        _buildDisplayItem(
                          'Current Balance',
                          waterAccount.balance.toString(),
                          theme,
                        ),
                        _buildDisplayItem(
                          'Payment Method',
                          '${PaymentMethod.gCash.value} (${loggedUser.ewallet})',
                          theme,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PrimaryButton(
                label: 'Pay bill',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog.adaptive(
                        title: Text('Payment Confirmation'),
                        content: Text(
                          'Are you sure all the information is correct?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No, cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              var generatedTransactionNumber = paymentService
                                  .generateTransactionNumber();

                              await paymentService.saveAndCreateReceipt(
                                waterAccount: waterAccount,
                                transactionNumber: generatedTransactionNumber,
                                billerName: Biller.calambaWaterDistrict,
                                inputAmount: inputAmount,
                                paymentMethod: PaymentMethod.gCash,
                              );

                              Receipt? retrievedReceipt = await paymentService
                                  .searchReceiptToDisplay(
                                    searchTransactionNumber:
                                        generatedTransactionNumber,
                                    waterAccountReceipt: waterAccount.receipt,
                                  );

                              //guard
                              if (!context.mounted) return;

                              if (retrievedReceipt != null) {
                                Navigator.pushNamed(
                                  context,
                                  '/paymentresult',
                                  arguments: retrievedReceipt,
                                );
                              } else {
                                debugPrint(
                                  'NOTE: the value of receipt object is $retrievedReceipt',
                                );
                              }
                            },

                            child: Text('Yes, proceed'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDisplayItem(
    String itemSection,
    String itemData,
    ThemeData theme,
  ) {
    return FittedBox(
      // width: 280,
      child: Row(
        spacing: 20,
        children: [
          Text('$itemSection:', style: theme.textTheme.bodyLarge),
          Text(
            itemData,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

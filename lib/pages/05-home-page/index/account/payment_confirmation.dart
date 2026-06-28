import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/primary_button.dart';

import 'package:myapp/data-bank/receipt.dart';
import 'package:myapp/data-class/constants/biller_enum.dart';
import 'package:myapp/data-class/constants/payment_method_enum.dart';

import 'package:myapp/data-class/water_account.dart';
import 'package:myapp/providers/auth_provider.dart';
import 'package:myapp/services/payment_service.dart';

class PaymentConfirmation extends ConsumerWidget {
  const PaymentConfirmation({super.key, required this.paymentData});

  final Map<String, dynamic>? paymentData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedUser = ref.watch(authNotifierProvider);

    if (loggedUser == null) {
      return DisplayNoData();
    }

    //service
    final PaymentService paymentService = PaymentService();

    //theme
    final ThemeData theme = Theme.of(context);

    final data = paymentData;

    if (data == null) {
      return const DisplayNoData();
    }

    final inputAmount = data['inputAmount'] as double;
    final waterAccount = data['waterAccount'] as WaterAccount;

    return Scaffold(
      appBar: AppBar(title: const Text('Payment Confirmation')),
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
                          waterAccount.balance.toStringAsFixed(2),
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
                        title: const Text('Payment Confirmation'),
                        content: const Text(
                          'Are you sure all the information is correct?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: const Text('No, cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              //create a generated transaction number
                              var generatedTransactionNumber = paymentService
                                  .generateTransactionNumber();

                              //use the generated transaction number and create the receipt
                              //deduct the balance
                              final updatedWaterAccount = await paymentService
                                  .saveAndCreateReceipt(
                                    waterAccount: waterAccount,
                                    transactionNumber:
                                        generatedTransactionNumber,
                                    billerName: Biller.calambaWaterDistrict,
                                    inputAmount: inputAmount,
                                    paymentMethod: PaymentMethod.gCash,
                                  );
                              ref
                                  .read(authNotifierProvider.notifier)
                                  .updateLinkedAccount(updatedWaterAccount);

                              //after creating the receipt , search the linkedAccount generated transaction number
                              //returns a Receipt object of that specific transaction (current one created)
                              Receipt? retrievedReceipt = await paymentService
                                  .searchReceiptToDisplay(
                                    searchTransactionNumber:
                                        generatedTransactionNumber,
                                    waterAccountReceipt:
                                        updatedWaterAccount.receipt,
                                  );

                              //guard clause
                              if (!context.mounted) return;

                              //The Receipt object is pass as argument to be displayed on the next page
                              //shows the receipt of user's current transaction
                              if (retrievedReceipt != null) {
                                context.push(
                                  '/paymentresult',
                                  extra: {
                                    'receipt': retrievedReceipt,
                                    'waterAccount': updatedWaterAccount,
                                  },
                                );
                              } else {
                                debugPrint(
                                  'NOTE: the value of receipt object is $retrievedReceipt',
                                );
                              }
                            },

                            child: const Text('Yes, proceed'),
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

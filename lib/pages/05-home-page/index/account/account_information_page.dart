import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/custom-widgets/secondary_button.dart';
import 'package:myapp/custom-widgets/secondary_button_outlined.dart';
import 'package:myapp/custom-widgets/status_indicator.dart';
import 'package:myapp/data-class/constants/custom_action_enum.dart';
import 'package:myapp/data-class/water_account.dart';

import 'package:myapp/providers/auth_provider.dart';
import 'package:myapp/services/masking_service.dart';

class AccountInformationPage extends ConsumerWidget {
  const AccountInformationPage({super.key, this.linkedAccountData});

  final Map<String, dynamic>? linkedAccountData;

  void _buildDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogBoxContext) {
        return AlertDialog.adaptive(
          icon: const Icon(Icons.delete),
          title: const Text('Unlink this account?'),
          content: const Text(
            'Local transaction history for this account will be removed from this device.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                //When the user tap the Delete icon
                //Destroy the Dialogbox
                //Destroy the current page (account information)
                //return a CustomAction enum that will be triggered from
                //AccountIndex _buildSlider() Guesture Detector onTap () async to delete the WaterAccount data
                context.pop();
                Future.delayed(Duration(seconds: 1), () {});
                context.pop(CustomAction.delete);
              },
              child: const Text('Unlink'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //provider
    final _ = ref.watch(authNotifierProvider);

    final MaskingService maskingService = MaskingService();

    final ThemeData theme = Theme.of(context);
    //Philippine Peso sign
    final String currencySign = '\u20B1';
    //Data passed through Account Index to Account InformationPage
    final data = linkedAccountData;

    if (data == null) {
      return DisplayNoData();
    }

    final waterAccount = data['waterAccount'] as WaterAccount;

    //Receipt button
    bool hasReceipt = waterAccount.receipt.isNotEmpty;
    bool hasTicket = waterAccount.ticket.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        actions: [
          IconButton(
            onPressed: () {
              _buildDialog(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: ListView(
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
              child: const Headline(headline: 'Account Information'),
            ),
          ),

          //Account Information
          Container(
            padding: const EdgeInsets.symmetric(vertical: 23),
            child: Column(
              spacing: 7.0,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Text('Account Number:', style: theme.textTheme.bodyLarge),
                    Text(
                      maskingService.formatAccountNumber(
                        accountNumber: waterAccount.accountNumber,
                      ),
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StatusIndicator(waterAccount: waterAccount),
                  ],
                ),

                Row(
                  spacing: 10,
                  children: [
                    Text('Nickname :', style: theme.textTheme.bodyLarge),
                    Text(
                      waterAccount.accountName,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 26),
            child: Column(
              spacing: 18,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Due date: ${waterAccount.dueDay} of the month',
                  style: theme.textTheme.titleLarge,
                ),
                Text(
                  'Balance: $currencySign ${waterAccount.balance.toStringAsFixed(2)}',
                  style: theme.textTheme.headlineMedium,
                ),

                //payment CTA
                SecondaryButton(
                  label: 'Pay',
                  width: 200,
                  onPressed: () {
                    context.push(
                      '/payment',
                      extra: {'waterAccount': waterAccount},
                    );
                  },
                ),
              ],
            ),
          ),

          //Transacitions
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 30,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: BoxBorder.fromSTEB(bottom: BorderSide()),
                  ),
                  child: Text(
                    'Transactions',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                Row(
                  spacing: 15,
                  children: [
                    Expanded(
                      child: SecondaryButtonOutlined(
                        label: 'Billing',
                        onPressed: () {
                          context.push(
                            '/billing',
                            extra: {'waterAccount': waterAccount},
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: PrimaryButton(
                        width: double.infinity,
                        label: 'Receipt',
                        onPressed: hasReceipt
                            ? () {
                                context.push(
                                  '/receipt',
                                  extra: {'waterAccount': waterAccount},
                                );
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: BoxBorder.fromSTEB(bottom: BorderSide()),
                  ),
                  child: Text('Ticket', style: theme.textTheme.titleLarge),
                ),
                PrimaryButton(
                  label: 'View Ticket',
                  width: 200,
                  onPressed: hasTicket
                      ? () {
                          context.push(
                            '/ticket',
                            extra: {'waterAccount': waterAccount},
                          );
                        }
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

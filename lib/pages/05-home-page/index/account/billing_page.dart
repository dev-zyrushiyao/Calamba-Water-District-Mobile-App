import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/custom-widgets/colored_container.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/data-class/water_account.dart';
import 'package:myapp/providers/auth_provider.dart';
import 'package:myapp/services/masking_service.dart';

class BillingPage extends ConsumerWidget {
  const BillingPage({super.key, required this.waterAccount});

  final WaterAccount? waterAccount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = waterAccount;

    final _ = ref.watch(authNotifierProvider);

    final MaskingService maskingService = MaskingService();
    final ThemeData theme = Theme.of(context);

    if (data == null) {
      return DisplayNoData();
    }

    final reversedBillList = data.bill.reversed.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Billing')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
        children: [
          const SizedBox(height: 60),

          ColoredContainer(
            height: 700,
            child: Column(
              spacing: 30,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  decoration: BoxDecoration(
                    border: BoxBorder.fromSTEB(bottom: BorderSide()),
                  ),
                  child: Headline(
                    headline:
                        '${maskingService.formatAccountNumber(accountNumber: data.accountNumber)} Bills',
                  ),
                ),
                if (reversedBillList.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 50),
                      itemCount: reversedBillList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.push(
                              '/billcontent',
                              extra: reversedBillList[index],
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Calamba Water District Bill - ',
                                style: theme.textTheme.bodyLarge,
                              ),
                              Text(
                                '${reversedBillList[index].monthName} 2026',
                                style: theme.textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                else
                  const DottedBorder(child: Text('No bills to Show')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

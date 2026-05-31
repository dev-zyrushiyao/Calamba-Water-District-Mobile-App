import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/colored_container.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/data-class/bill.dart';
import 'package:myapp/data-class/water_account.dart';
import 'package:myapp/services/masking_service.dart';
import 'package:myapp/services/user_interface_service.dart';

class BillingPage extends StatelessWidget {
  const BillingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Map?;

    final MaskingService maskingService = MaskingService();
    final ThemeData theme = Theme.of(context);

    if (data == null) {
      return DisplayNoData();
    }

    var billList = data['reversedListData'] as List<Bill>;
    var userData = data['userData'] as WaterAccount;

    return Scaffold(
      appBar: AppBar(title: const Text('Billing')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                        '${maskingService.formatAccountNumber(accountNumber: userData.accountNumber)} Bills',
                  ),
                ),
                if (billList.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 50),
                      itemCount: billList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/billingcontent',
                            arguments: billList[index],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Calamba Water District Bill - ',
                                style: theme.textTheme.bodyLarge,
                              ),
                              Text(
                                '${billList[index].monthName} 2026',
                                style: theme.textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                else
                  DottedBorder(child: Text('No bills to Show')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

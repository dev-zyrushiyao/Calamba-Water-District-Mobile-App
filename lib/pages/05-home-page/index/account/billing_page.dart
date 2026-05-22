import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/colored_container.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/data-class/water_account.dart';
import 'package:myapp/services/user_interface_service.dart';

class BillingPage extends StatelessWidget {
  const BillingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as WaterAccount?;
    final UserInterfaceService userInterfaceService = UserInterfaceService();
    final ThemeData theme = Theme.of(context);

    debugPrint('Is the Bill list length: ${data?.bill?.length}');

    if (data == null) {
      return DisplayNoData();
    }

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
                        '${userInterfaceService.formatAccountNumber(accountNumber: data.accountNumber)} Bills',
                  ),
                ),
                if (data.bill != null && data.bill!.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 50),
                      itemCount: data.bill!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/billingcontent',
                            arguments: data.bill?.reversed.toList()[index],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Calamba Water District Bill - ',
                                style: theme.textTheme.bodyLarge,
                              ),
                              Text(
                                '${data.bill?.reversed.toList()[index].monthName} 2026',
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

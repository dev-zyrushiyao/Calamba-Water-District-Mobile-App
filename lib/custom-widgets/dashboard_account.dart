import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/custom-widgets/status_indicator.dart';
import 'package:myapp/data-class/water_account.dart';

import 'package:myapp/services/user_interface_service.dart';

class DashboardDisplay extends StatelessWidget {
  const DashboardDisplay({
    super.key,
    required this.waterAccount,
    required this.primaryButton,
  });

  final WaterAccount waterAccount;
  final PrimaryButton primaryButton;

  @override
  Widget build(BuildContext context) {
    //service
    final UserInterfaceService userInterfaceService = UserInterfaceService();
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(23.0),
      width: deviceWidth,
      decoration: BoxDecoration(
        color: Color(0xFFEEEEFA),
        border: BoxBorder.all(
          color: const Color(0xFFC8C8E5),
          width: 3,
          strokeAlign: -1.0,
        ),
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 5,
            children: [
              Text(
                waterAccount.accountName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                userInterfaceService.formatAccountNumber(
                  accountNumber: waterAccount.accountNumber,
                ),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                spacing: 7.0,
                children: [
                  Text(
                    'Status:',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  StatusIndicator(isActive: waterAccount.isActive),
                ],
              ),
              Text(
                'Previous Bill: ${waterAccount.previousBill}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                'Last Reading: ${waterAccount.lastReading} m³',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 5,
            children: [
              Text(
                waterAccount.remainingDayDue == 0
                    ? 'Due today'
                    : 'Due in ${waterAccount.remainingDayDue} days',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w600),
              ),
              Text('Balance', style: Theme.of(context).textTheme.titleLarge),
              Text(
                '₱ ${waterAccount.balance}',

                style: Theme.of(context).textTheme.headlineSmall,
              ),
              if (waterAccount.isActive == true) primaryButton,
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/custom-widgets/status_indicator.dart';
import 'package:myapp/models/constants/water_account_status_enum.dart';
import 'package:myapp/models/water_account.dart';
import 'package:myapp/services/masking_service.dart';

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

    final MaskingService maskingService = MaskingService();
    final double deviceWidth = MediaQuery.of(context).size.width;
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(23.0),
      width: deviceWidth,
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEFA),
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
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                maskingService.formatAccountNumber(
                  accountNumber: waterAccount.accountNumber,
                ),
                style: theme.textTheme.titleMedium,
              ),
              Row(
                spacing: 7.0,
                children: [
                  Text(
                    'Status:',
                    style: theme.textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  StatusIndicator(waterAccount: waterAccount),
                ],
              ),
              Text(
                'Previous Bill: ${waterAccount.previousBill}',
                style: theme.textTheme.labelSmall,
              ),
              Text(
                'Last Reading: ${waterAccount.lastReading} m³',
                style: theme.textTheme.labelSmall,
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
                style: theme.textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text('Balance', style: theme.textTheme.titleLarge),
              Text(
                '₱ ${waterAccount.balance.toStringAsFixed(2)}',

                style: theme.textTheme.headlineSmall,
              ),
              if (waterAccount.isActive == WaterAccountStatus.active)
                primaryButton,
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/data-class/linked_water_account.dart';

class DashboardDisplay extends StatelessWidget {
  const DashboardDisplay({
    super.key,
    required this.waterAccount,
    required this.primaryButton,
  });

  final LinkedWaterAccount waterAccount;
  final PrimaryButton primaryButton;

  Color getStatusColor(bool isActive) {
    if (isActive) {
      return Color(0xFFC8F2CF);
    } else {
      return Colors.grey[400]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor = getStatusColor(waterAccount.isActive);
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
                waterAccount.accountNumber,
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
                  Container(
                    padding: EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: statusColor,
                      border: Border.all(
                        color: Color(0xFFE3E3E3),
                        width: 1.0,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: Text(
                      waterAccount.isActive ? 'Active' : 'Inactive',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Previous Bill: ${waterAccount.balance}',
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
                'Due in ${waterAccount.dueDay} days',
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

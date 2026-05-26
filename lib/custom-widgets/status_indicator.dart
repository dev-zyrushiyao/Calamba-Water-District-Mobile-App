import 'package:flutter/material.dart';
import 'package:myapp/data-class/water_account.dart';

class StatusIndicator extends StatelessWidget {
  const StatusIndicator({super.key, required this.waterAccount});

  final WaterAccount waterAccount;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: waterAccount.statusColor,
        border: Border.all(
          color: Color(0xFFE3E3E3),
          width: 1.0,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Text(
        waterAccount.isActive ? 'Active' : 'Inactive',
        style: theme.textTheme.labelSmall!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/services/user_interface_service.dart';

class StatusIndicator extends StatelessWidget {
  const StatusIndicator({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final UserInterfaceService userInterfaceService = UserInterfaceService();
    ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: userInterfaceService.getStatusColor(isActive),
        border: Border.all(
          color: Color(0xFFE3E3E3),
          width: 1.0,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: theme.textTheme.labelSmall!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

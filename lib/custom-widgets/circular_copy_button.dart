import 'package:flutter/material.dart';
import 'package:myapp/services/user_interface_service.dart';
import 'package:flutter/services.dart';

class CircularCopyButton extends StatelessWidget {
  const CircularCopyButton({
    super.key,
    required this.targetTextToCopy,
    this.padding = const EdgeInsets.all(30),
  });

  final String targetTextToCopy;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    //Service
    final UserInterfaceService userInterfaceService = UserInterfaceService();

    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: targetTextToCopy));

        if (context.mounted) {
          userInterfaceService.showCustomSnackbar(
            context,
            'Copied to clipboard!',
          );
        }
      },
      child: Container(
        padding: padding ?? EdgeInsets.zero,
        decoration: ShapeDecoration(color: Colors.amber, shape: CircleBorder()),
        child: Column(
          children: [
            Icon(Icons.copy),
            Text('Copy', style: theme.textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}

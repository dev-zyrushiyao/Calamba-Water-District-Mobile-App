import 'package:flutter/material.dart';

class AppbarCustomHeader extends StatelessWidget {
  const AppbarCustomHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Text(subtitle, style: theme.textTheme.labelSmall),
      ],
    );
  }
}

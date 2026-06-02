import 'package:flutter/material.dart';

class BoardingCaption extends StatelessWidget {
  const BoardingCaption({
    super.key,
    required this.title,
    required this.caption,
    this.space = 28,
  });

  final String title;
  final String caption;
  final double space;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      spacing: space,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          caption,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium,
        ),
      ],
    );
  }
}

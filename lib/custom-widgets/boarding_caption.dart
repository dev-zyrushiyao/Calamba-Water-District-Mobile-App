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
    return Column(
      spacing: space,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),

        Text(
          caption,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}

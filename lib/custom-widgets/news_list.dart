import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key, required this.date, required this.title});

  final String date;
  final String title;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      spacing: 35.0,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            date,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.bodyLarge,
            overflow: TextOverflow.clip,
          ),
        ),
      ],
    );
  }
}

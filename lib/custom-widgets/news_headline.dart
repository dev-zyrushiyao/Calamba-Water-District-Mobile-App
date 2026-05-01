import 'package:flutter/material.dart';

class NewsHeadline extends StatelessWidget {
  const NewsHeadline({super.key, required this.data});

  final Map<String?, String?> data;

  @override
  Widget build(BuildContext context) {
    String? headline = data["headline"];
    String? subheadline = data["subheadline"];

    final ThemeData theme = Theme.of(context);

    return Column(
      spacing: 7.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headline != null) Text(headline, style: theme.textTheme.titleLarge),
        if (subheadline != null)
          Text(subheadline, style: theme.textTheme.bodyLarge),
      ],
    );
  }
}

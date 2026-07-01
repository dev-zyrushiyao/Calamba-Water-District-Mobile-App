import 'package:flutter/material.dart';

class NewsHeadline extends StatelessWidget {
  const NewsHeadline({super.key, this.headline, this.subheadline});

  final String? headline;
  final String? subheadline;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final headline = this.headline;
    final subheadline = this.subheadline;

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

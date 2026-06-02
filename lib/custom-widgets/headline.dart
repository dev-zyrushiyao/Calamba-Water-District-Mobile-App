import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  const Headline({
    super.key,
    required this.headline,
    this.subHeadline,
    this.textAlign = TextAlign.left,
    this.spacing = 0,
    this.elementAlignment = CrossAxisAlignment.start,
  });

  final String headline;
  final String? subHeadline;
  final TextAlign textAlign;
  final double spacing;
  final CrossAxisAlignment elementAlignment;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SizedBox(
      child: Column(
        spacing: spacing,
        crossAxisAlignment: elementAlignment,
        children: [
          Text(
            headline,
            textAlign: textAlign,
            style: theme.textTheme.headlineLarge!.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
          if (subHeadline != null)
            Text(
              subHeadline!,
              textAlign: textAlign,
              style: theme.textTheme.titleMedium!.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
        ],
      ),
    );
  }
}

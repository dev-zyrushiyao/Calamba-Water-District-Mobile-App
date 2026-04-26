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
    return SizedBox(
      child: Column(
        spacing: spacing,
        crossAxisAlignment: elementAlignment,
        children: [
          Text(
            headline,
            textAlign: textAlign,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          if (subHeadline != null)
            Text(
              subHeadline!,
              textAlign: textAlign,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
        ],
      ),
    );
  }
}

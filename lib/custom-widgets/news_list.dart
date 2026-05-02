import 'package:flutter/material.dart';
import 'package:myapp/data-class/news_information.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key, required this.newsInformation});

  final NewsInformation newsInformation;

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
            newsInformation.dateWord!,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/newscontent',
                arguments: newsInformation,
              );
            },
            child: Text(
              newsInformation.title!,
              style: theme.textTheme.bodyLarge,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      ],
    );
  }
}

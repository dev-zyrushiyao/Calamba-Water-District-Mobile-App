import 'package:flutter/material.dart';
import 'package:myapp/models/news.dart';

class NewsHeader extends StatelessWidget {
  const NewsHeader({super.key, this.news});

  final News? news;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final news = this.news;

    if (news == null) {
      return Text('No news data available', style: theme.textTheme.bodyLarge);
    }

    return Column(
      spacing: 10.0,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date: ${news.month.numberValue}-${news.day}-${news.year.value}',
          style: theme.textTheme.labelSmall,
        ),
        Text(news.title, style: theme.textTheme.titleLarge),
        Row(
          spacing: 7.0,
          children: [
            Text('Status:', style: theme.textTheme.labelSmall),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: news.status.color,
                borderRadius: BorderRadius.circular(23.0),
                border: BoxBorder.all(
                  color: const Color(0xFF7E7E7E),
                  width: 0.3,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
              child: Text(
                news.status.value,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

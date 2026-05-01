import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/news_information.dart';

class NewsHeader extends StatelessWidget {
  const NewsHeader({super.key, required this.data});

  final NewsInformation data;

  Color setStatusColor(NewsInformation data) {
    if (data.status == 'On Going Repair') {
      return Color(0xFFD3ED3F);
    } else if (data.status == 'Issue Resolved') {
      return Colors.green;
    } else if (data.status == 'Currently Monitoring') {
      return Colors.pink;
    } else {
      //default
      return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color statusColor = setStatusColor(data);

    return Column(
      spacing: 10.0,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date: ${data.dateNum}', style: theme.textTheme.labelSmall),
        Text('${data.title}', style: theme.textTheme.titleLarge),
        Row(
          spacing: 7.0,
          children: [
            Text('Status:', style: theme.textTheme.labelSmall),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(23.0),
                border: BoxBorder.all(
                  color: Color(0xFF7E7E7E),
                  width: 0.3,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
              child: Text(
                '${data.status}',
                style: theme.textTheme.labelSmall!.copyWith(
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

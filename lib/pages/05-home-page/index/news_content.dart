import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/news_headline.dart';
import 'package:myapp/custom-widgets/news_information.dart';
import 'package:myapp/custom-widgets/news_header.dart';

class NewsContentPage extends StatelessWidget {
  const NewsContentPage({super.key});

  //method string buffer -> for paragraphs
  String formatList({required List<String> items, bool bulletFormat = false}) {
    final buffer = StringBuffer();

    for (var item in items) {
      bulletFormat ? buffer.writeln("• $item") : buffer.writeln(item);
      buffer.writeln("");
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = ModalRoute.of(context)?.settings.arguments as NewsInformation?;

    if (data == null) {
      return Scaffold(body: Center(child: const Text('404 News Not found')));
    }

    return Scaffold(
      appBar: AppBar(title: Text('News')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),

        children: [
          //News Header
          NewsHeader(data: data),

          SizedBox(height: 10),

          Divider(color: Color(0xFF6C6C6C), radius: BorderRadius.circular(6.0)),

          SizedBox(height: 10),
          Text(
            formatList(items: data.paragraph1, bulletFormat: false),
            style: theme.textTheme.bodyLarge,
          ),

          if (data.imageDirectory != null)
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Image.asset('${data.imageDirectory}', fit: BoxFit.contain),
            ),

          if (data.headLine1 != null) NewsHeadline(data: data.headLine1!),
          if (data.bulletList1 != null)
            Text(
              formatList(items: data.bulletList1!, bulletFormat: true),
              style: theme.textTheme.bodyLarge,
            ),

          if (data.headLine2 != null) NewsHeadline(data: data.headLine2!),
          if (data.bulletList2 != null)
            Text(
              formatList(items: data.bulletList2!, bulletFormat: true),
              style: theme.textTheme.bodyLarge,
            ),

          if (data.headLine3 != null) NewsHeadline(data: data.headLine3!),
          if (data.bulletList3 != null)
            Text(
              formatList(items: data.bulletList3!, bulletFormat: true),
              style: theme.textTheme.bodyLarge,
            ),
        ],
      ),
    );
  }
}

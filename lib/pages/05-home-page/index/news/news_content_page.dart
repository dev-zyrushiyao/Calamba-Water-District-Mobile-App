import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/news_bullet.dart';
import 'package:myapp/custom-widgets/news_headline.dart';
import 'package:myapp/data-class/deprecated-class/news_information.dart';
import 'package:myapp/custom-widgets/news_header.dart';
import 'package:myapp/services/news_content_page_service.dart';

class NewsContentPage extends StatefulWidget {
  const NewsContentPage({super.key, this.newsInformation});

  final NewsInformation? newsInformation;

  @override
  State<NewsContentPage> createState() => _NewsContentPageState();
}

class _NewsContentPageState extends State<NewsContentPage> {
  //service
  final NewsContentPageService _newsContentPage = NewsContentPageService();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = widget.newsInformation;
    if (data == null) {
      return DisplayNoData();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        surfaceTintColor: theme.colorScheme.primary,
        scrolledUnderElevation: 1,
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(13.0)),
            ),

            child: IconButton(
              onPressed: () {},
              alignment: Alignment.center,
              tooltip: 'share',
              icon: const Icon(Icons.share),
              color: theme.colorScheme.onPrimary,
              style: const ButtonStyle(
                backgroundColor: WidgetStateColor.fromMap(
                  <WidgetStatesConstraint, Color>{
                    WidgetState.any: Color(0xFF80D8FF),
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          //News Header
          NewsHeader(data: data),

          const SizedBox(height: 10),

          Divider(
            color: const Color(0xFF6C6C6C),
            radius: BorderRadius.circular(6.0),
          ),

          const SizedBox(height: 10),

          Text(
            _newsContentPage.formatList(
              items: data.paragraph1,
              bulletFormat: false,
            ),
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

          const SizedBox(height: 20),

          if (data.headLine1 != null) NewsHeadline(data: data.headLine1!),

          const SizedBox(height: 10),

          if (data.bulletList1 != null)
            NewsBullet(bulletList: data.bulletList1!, bulletFormat: true),

          if (data.headLine2 != null) NewsHeadline(data: data.headLine2!),
          const SizedBox(height: 10),

          if (data.bulletList2 != null)
            NewsBullet(bulletList: data.bulletList2!, bulletFormat: true),

          const SizedBox(height: 10),

          if (data.headLine3 != null) NewsHeadline(data: data.headLine3!),
          const SizedBox(height: 10),

          if (data.bulletList3 != null)
            NewsBullet(bulletList: data.bulletList3!, bulletFormat: true),
        ],
      ),
    );
  }
}

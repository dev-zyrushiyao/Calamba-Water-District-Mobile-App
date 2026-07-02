import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/news_bullet.dart';
import 'package:myapp/custom-widgets/news_headline.dart';
import 'package:myapp/custom-widgets/news_header.dart';
import 'package:myapp/models/news.dart';
import 'package:myapp/services/news_content_page_service.dart';

class NewsContentPage extends ConsumerStatefulWidget {
  const NewsContentPage({super.key, this.news});

  final News? news;

  @override
  ConsumerState<NewsContentPage> createState() => _NewsContentPageState();
}

class _NewsContentPageState extends ConsumerState<NewsContentPage> {
  //service
  final NewsContentPageService _newsContentPage = NewsContentPageService();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final data = widget.news;

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
          NewsHeader(news: data),

          const SizedBox(height: 10),

          Divider(
            color: const Color(0xFF6C6C6C),
            radius: BorderRadius.circular(6.0),
          ),

          const SizedBox(height: 10),

          Text(
            _newsContentPage.formatList(
              items: data.paragraph,
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

          NewsHeadline(headline: data.headline1, subheadline: data.subline1),
          const SizedBox(height: 10),

          NewsBullet(bulletList: data.firstList, bulletFormat: true),
          const SizedBox(height: 10),

          NewsHeadline(headline: data.headline2, subheadline: data.subline2),
          const SizedBox(height: 10),

          NewsBullet(bulletList: data.secondList, bulletFormat: true),
          const SizedBox(height: 10),

          NewsHeadline(headline: data.headline3, subheadline: data.subline3),
          const SizedBox(height: 10),

          NewsBullet(bulletList: data.thirdList, bulletFormat: true),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

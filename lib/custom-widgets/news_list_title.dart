import 'package:flutter/material.dart';
import 'package:myapp/data-class/news_information.dart';
import 'package:myapp/pages/05-home-page/index/news_index.dart';

class NewsListTitle extends StatefulWidget {
  const NewsListTitle({
    super.key,
    required this.newsInformationList,
    required this.refreshNewsList,
  });

  final NewsInformation newsInformationList;
  final VoidCallback refreshNewsList;

  @override
  State<NewsListTitle> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewsListTitle> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      spacing: 35.0,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            widget.newsInformationList.dateWord!,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              //Wait for the user to go back From NewsContent -> NewsIndex
              await Navigator.pushNamed(
                context,
                '/newscontent',
                arguments: widget.newsInformationList,
              );

              //When a user press the back button of the appbar it will invoke the NewsIndex._updateTheNews()
              //this method is going to clear -> refetch the latest news or changes then display back to the UI(NewsIndex)
              widget.refreshNewsList();
            },
            child: Text(
              widget.newsInformationList.title!,
              style: theme.textTheme.bodyLarge,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      ],
    );
  }
}

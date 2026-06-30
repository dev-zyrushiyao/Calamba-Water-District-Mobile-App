import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/page_logo.dart';
import 'package:myapp/data-class/constants/year_enum.dart';
import 'package:myapp/data-class/news.dart';
import 'package:myapp/providers/news_provider.dart';

class NewsIndex extends ConsumerStatefulWidget {
  const NewsIndex({super.key});

  @override
  ConsumerState<NewsIndex> createState() => _NewsIndexState();
}

class _NewsIndexState extends ConsumerState<NewsIndex> {
  //Dynamic dropdown data
  Year _chosenValue = Year.y2026;
  final List<DropdownMenuItem<Year>> _yearMenu = [];
  List<News?> _newsToDisplay = [];

  @override
  void initState() {
    super.initState();

    _initializeDropdownYear();
  }

  void _initializeDropdownYear() {
    for (var year in Year.values) {
      _yearMenu.add(
        DropdownMenuItem(value: year, child: Text('${year.value}')),
      );
    }
  }

  List<News?> displayNews(Year year) {
    final newsList = ref.read(newsProviderNotifier);

    //filter list item by year
    final listToDisplay = newsList.where((news) => news.year == year).toList();
    //sort the items by month
    listToDisplay.sort(
      (a, b) => a.month.numberValue.compareTo(b.month.numberValue),
    );

    //return as reversed list
    return listToDisplay.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final news = ref.watch(newsProviderNotifier);

    if (news.isEmpty) {
      return DisplayNoData();
    }
    //updates the item list shown every time the page rebuilds
    _newsToDisplay = displayNews(_chosenValue);

    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            PageLogo(),

            const SizedBox(height: 38),

            const Align(
              alignment: AlignmentGeometry.centerStart,
              child: Headline(
                headline: 'News',
                subHeadline: 'Latest announcements and community updates.',
              ),
            ),

            const SizedBox(height: 38),

            //Dropdown
            Row(
              spacing: 10.0,
              children: [
                SizedBox(
                  width: 110,
                  child: DropdownButtonFormField(
                    initialValue: _chosenValue,
                    borderRadius: BorderRadius.circular(13.0),
                    itemHeight: 55, //default 48
                    items: _yearMenu,
                    decoration: InputDecoration(
                      labelText: 'Year',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    hint: const Text('Year'),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _chosenValue = value;
                          _newsToDisplay = displayNews(value);
                        });
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Divider(
                    height: 3.0,
                    thickness: 2.0,
                    color: theme.colorScheme.onPrimary,
                    radius: BorderRadiusGeometry.circular(3.0),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 33),

            //News Display
            Expanded(
              child: _newsToDisplay.isEmpty
                  ? Container(
                      alignment: AlignmentGeometry.center,
                      child: Text(
                        'No news to show',
                        style: theme.textTheme.bodyLarge,
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 35),
                      itemCount: _newsToDisplay.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          spacing: 35.0,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                '${_newsToDisplay[index]?.month.capitalize}-${_newsToDisplay[index]?.day}',
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  //Wait for the user to go back From NewsContent -> NewsIndex
                                  // await context.push(
                                  //   '/newscontent',
                                  //   extra: widget.newsInformationList,
                                  // );
                                },
                                child: Text(
                                  '${_newsToDisplay[index]?.title}',
                                  style: theme.textTheme.bodyLarge,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

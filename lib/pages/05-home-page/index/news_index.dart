import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/news_list.dart';

class NewsIndex extends StatefulWidget {
  const NewsIndex({super.key});

  @override
  State<NewsIndex> createState() => _NewsIndexState();
}

class _NewsIndexState extends State<NewsIndex> {
  //Year raw data
  final int currentYear = DateTime.now().year;
  //Dynamic dropdown data
  int? chosenValue;
  List<NewsList> newsList = [];

  @override
  void initState() {
    super.initState();
    chosenValue = currentYear;
    addNews();
  }

  void addNews() {
    newsList = [
      NewsList(
        date: 'March-25',
        title: 'Notice of Scheduled Interconnection: Brgy. Mayapa Area',
      ),
      NewsList(
        date: 'March-22',
        title:
            'CWD Celebrates World Water Day 2026: Glacier Preservation Awareness',
      ),
      NewsList(
        date: 'March-18',
        title: 'Water Conservation Workshop for Calamba City Public Schools',
      ),
      NewsList(
        date: 'March-12',
        title: 'Emergency Pipe Repair: Lakeview Subd. Main Entrance',
      ),
      NewsList(
        date: 'March-09',
        title: '"Walk In Her Shoes" Activity Honors Women in the Water Sector',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    //dropdown value
    List<int> years = List.generate(7, (index) => currentYear - index);
    List<DropdownMenuItem<int>> yearMenu = [
      ...years.map(
        (int year) =>
            DropdownMenuItem(value: year, child: Text(year.toString())),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 86),
      child: Column(
        children: [
          Headline(
            headline: 'News',
            subHeadline: 'Latest announcements and community updates.',
          ),

          SizedBox(height: 38),

          Row(
            spacing: 10.0,
            children: [
              SizedBox(
                width: 110,
                child: DropdownButtonFormField(
                  initialValue: chosenValue,
                  borderRadius: BorderRadius.circular(13.0),
                  itemHeight: 55, //default 48
                  items: yearMenu,
                  decoration: InputDecoration(
                    labelText: 'Year',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  hint: Text('Year'),
                  onChanged: (int? value) {
                    if (value != null) {
                      setState(() {
                        chosenValue = value;
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

          SizedBox(height: 33),

          Flexible(
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 35),
              itemCount: newsList.length,
              itemBuilder: (BuildContext context, int index) {
                return newsList[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}

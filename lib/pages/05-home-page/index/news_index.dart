import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/data-class/news_information.dart';
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
  Map<String, String> status = {
    'ongoing': 'On Going Repair',
    'resolved': 'Issue Resolved',
    'monitoring': 'Currently Monitoring',
  };

  @override
  void initState() {
    super.initState();
    //starter data
    chosenValue = currentYear;
    addNews(chosenValue!);
  }

  void addNews(int chosenValue) {
    if (chosenValue == 2026) {
      newsList = [
        NewsList(
          newsInformation: NewsInformation(
            dateNum: '03-25-2026',
            dateWord: 'March-25',
            title: 'Notice of Scheduled Interconnection: Brgy. Mayapa Area',
            status: status['resolved'],
            paragraph1: [
              'The Calamba Water District (CWD) has issued an urgent advisory following a major pipe burst reported early this morning at the Main Entrance of Lakeview Subdivision.',
              'The rupture was identified in a primary 8-inch distribution line, causing significant water loss and localized flooding near the subdivision gates.',
              'CWD emergency response crews were dispatched at 8:30 AM and are currently on-site performing excavation and pipe replacement.',
            ],
            imageDirectory: 'assets/news-image/mar-25-2026-news.jpg',
            headLine1: {
              "headline": 'Service Impact',
              "subheadline":
                  'Residents in the following areas may experience low pressure to zero water supply during the repair period:',
            },
            bulletList1: [
              'Lakeview Subdivision (All Phases)',
              'Portions of Brgy. Halang',
              'Immediate neighboring residential compounds',
            ],
            headLine2: {
              "headline": "Restoration Timeline",
              "subheadline":
                  "CWD engineers estimate that repairs will be completed and water pressure will begin to normalize by 6:00 PM today, March 12, 2026.",
            },
            headLine3: {
              "headline": "Advice for Residents",
              "subheadline": null,
            },
            bulletList3: [
              'Storage: Residents are encouraged to use stored water wisely until service is restored.',
              'Water Quality: Upon restoration, "turbidity" (brownish water) may occur briefly. Please let your faucets run for 1–2 minutes until the water clears.',
              'Traffic: Motorists are advised to take alternate routes as one lane near the Lakeview Main Entrance is partially obstructed by service vehicles and equipment.',
            ],
          ),
        ),

        NewsList(
          newsInformation: NewsInformation(
            dateNum: '03-22-2026',
            dateWord: 'March-22',
            title: 'Notice of Scheduled Interconnection: Brgy. Mayapa Area',
            status: status['ongoing'],
            paragraph1: ['placeholder paragraph'],
          ),
        ),

        NewsList(
          newsInformation: NewsInformation(
            dateNum: '03-18-2026',
            dateWord: 'March-18',
            title:
                'Water Conservation Workshop for Calamba City Public Schools',
            status: status['ongoing'],
            paragraph1: ['placeholder paragraph'],
          ),
        ),

        NewsList(
          newsInformation: NewsInformation(
            dateNum: '03-12-2026',
            dateWord: 'March-12',
            title: 'Emergency Pipe Repair: Lakeview Subd. Main Entrance',
            status: status['ongoing'],
            paragraph1: ['placeholder paragraph'],
          ),
        ),

        NewsList(
          newsInformation: NewsInformation(
            dateNum: '03-09-2026',
            dateWord: 'March-09',
            title:
                '"Walk In Her Shoes" Activity Honors Women in the Water Sector',
            status: status['ongoing'],
            paragraph1: ['placeholder paragraph'],
          ),
        ),
      ];
    } else {
      newsList.clear();
    }
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

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 86),
        child: Column(
          children: [
            Align(
              alignment: AlignmentGeometry.centerStart,
              child: Headline(
                headline: 'News',
                subHeadline: 'Latest announcements and community updates.',
              ),
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
                          addNews(chosenValue!);
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
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 2));
                  setState(() {
                    addNews(chosenValue!);
                  });
                },

                child: newsList.isEmpty
                    ? Container(
                        alignment: AlignmentGeometry.center,
                        child: Text(
                          'No news to show',
                          style: theme.textTheme.bodyLarge,
                        ),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 35),
                        itemCount: newsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return newsList[index];
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

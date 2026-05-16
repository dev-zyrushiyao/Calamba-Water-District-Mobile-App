import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/news_list_title.dart';
import 'package:myapp/data-bank/news_data.dart';
import 'package:myapp/data-class/news_information.dart';

class NewsIndex extends StatefulWidget {
  const NewsIndex({super.key});

  @override
  State<NewsIndex> createState() => _NewsIndexState();
}

class _NewsIndexState extends State<NewsIndex> {
  //Year raw data
  final int _currentYear = DateTime.now().year;

  //Dynamic dropdown data
  int? _chosenValue;
  final List<DropdownMenuItem<int>> yearMenu = [];

  //News simulated Database - source data , do not modify, only use in _buildNewsAndUI()
  List<NewsInformation> _newsInformationList = NewsData().createNews();
  //News UI to Display - dynamic data to modify
  final List<NewsListTitle> _newsToDisplay = [];

  @override
  void initState() {
    super.initState();
    //set the default year to latest year
    _chosenValue = _currentYear;
    _createDropdownIitem();
    _buildNewsAndUI(_chosenValue, _newsInformationList);
  }

  void _buildNewsAndUI(
    int? chosenValue,
    List<NewsInformation> newsInformationList,
  ) {
    //clear the list everytime it invokes then add news if its year 2026
    _newsToDisplay.clear();
    //When user choose 2026 as dropdown menu show the News list
    //loop through NewsInformationList Created by NewsData
    //newsToDisplay is a list of Widget(NewsListTitle) containing newsInformationList
    //Algorithm : newsInformationList data fetched news from NewsData class , a class that contains news
    //----------- The list newsToDisplay is a list of Widget to display the UI News using the data of newsInformation
    //if you want to create a year 2025 list, create a new list in NewsData class then loop it inside the if conditionals here
    //if the value of dropdown is NOT 2026 it will clear the list(newsToDisplay)
    //if the list is empty it will show 'No News to show UI'
    //
    //the refreshNewList is a way to trigger the _updateNews inside the CustomWidget
    if (chosenValue == 2026) {
      for (var index = 0; index < newsInformationList.length; index++) {
        _newsToDisplay.add(
          NewsListTitle(
            newsInformationList: newsInformationList[index],
            refreshNewsList: _updateTheNews,
          ),
        );
      }
    }
  }

  void _createDropdownIitem() {
    //dropdown value
    //Algorithm: generate 4 items in a list that returns the current year - index
    //For example: current year is 2026
    //The generated list is [currentYear - 0(index) = 2026 , currentYear - 1(index) = 2025 , currentYear - 2(index).. and so on]
    List<int> yearList = List.generate(4, (index) => _currentYear - index);

    for (int year in yearList) {
      yearMenu.add(DropdownMenuItem(value: year, child: Text('$year')));
    }
  }

  void _updateTheNews() {
    //UpdateTheNews is to simulate the Live changes in the news such as title , content and status.
    setState(() {
      //Overrite the content of the news (if there is changed made like title, status etc)
      _newsInformationList = NewsData().createNews();
      //Rebuilds the News UI with the latest value
      _buildNewsAndUI(_chosenValue, _newsInformationList);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    //Changes the value of list per year
    //_buildNewsAndUI(_chosenValue, _newsInformationList);

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
                        //updates the dropdown current value
                        _chosenValue = value;

                        //triggers refresh the page and updating the newsToDisplay
                        _updateTheNews();
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

            //News Display
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 2));
                  _updateTheNews();
                },

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
                            SizedBox(height: 35),
                        itemCount: _newsToDisplay.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _newsToDisplay[index];
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

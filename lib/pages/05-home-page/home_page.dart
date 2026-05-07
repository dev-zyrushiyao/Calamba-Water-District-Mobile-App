import 'package:flutter/material.dart';
import 'package:myapp/pages/05-home-page/index/account_index.dart';
import 'package:myapp/pages/05-home-page/index/home_index.dart';
import 'package:myapp/pages/05-home-page/index/news_index.dart';
import 'package:myapp/pages/05-home-page/index/profile_index.dart';
import 'package:myapp/pages/05-home-page/index/support_index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    //FOR ADJUSTMENT: use the Account Object on the pages parameters
    final List<Widget> pages = [
      HomeIndex(),
      NewsIndex(),
      AccountIndex(),
      SupportIndex(), //pending
      ProfileIndex(),
    ];

    return Scaffold(
      floatingActionButton: _currentPageIndex > 0
          ? null
          : FloatingActionButton(
              onPressed: () {
                debugPrint('Floating has been pressed, add new account');
              },
              backgroundColor: themeData.colorScheme.secondaryContainer,
              child: Icon(Icons.add, color: themeData.colorScheme.onSecondary),
            ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        labelTextStyle: WidgetStateProperty<TextStyle>.fromMap(
          <WidgetStatesConstraint, TextStyle>{
            WidgetState.selected: TextStyle(
              fontWeight: FontWeight.bold,
              color: themeData.colorScheme.onSecondary,
            ),
            WidgetState.any: TextStyle(
              fontWeight: FontWeight.normal,
              color: themeData.colorScheme.onSecondary,
            ),
          },
        ),
        indicatorColor: themeData.colorScheme.onSecondary,
        selectedIndex: _currentPageIndex,
        backgroundColor: themeData.colorScheme.primary,
        animationDuration: Duration(milliseconds: 500),
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(
              Icons.home_outlined,
              color: themeData.colorScheme.onSecondary,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.newspaper,
              color: themeData.colorScheme.onPrimary,
            ),
            icon: Icon(
              Icons.newspaper,
              color: themeData.colorScheme.onSecondary,
            ),
            label: 'News',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.water_drop,
              color: themeData.colorScheme.onPrimary,
            ),
            icon: Icon(
              Icons.water_drop_outlined,
              color: themeData.colorScheme.onSecondary,
            ),
            label: 'Account',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.build,
              color: themeData.colorScheme.onPrimary,
            ),
            icon: Icon(
              Icons.build_outlined,
              color: themeData.colorScheme.onSecondary,
            ),
            label: 'Support',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.account_circle,
              color: themeData.colorScheme.onPrimary,
            ),
            icon: Icon(
              Icons.account_circle_outlined,
              color: themeData.colorScheme.onSecondary,
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: pages[_currentPageIndex],
    );
  }
}

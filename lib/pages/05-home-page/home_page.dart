import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/pages/05-home-page/index/account/account_index.dart';
import 'package:myapp/pages/05-home-page/index/home_index.dart';
import 'package:myapp/pages/05-home-page/index/news/news_index.dart';
import 'package:myapp/pages/05-home-page/index/profile_index.dart';
import 'package:myapp/pages/05-home-page/index/support/support_index.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final List<Widget> pages = [
      const HomeIndex(),
      const NewsIndex(),
      const AccountIndex(),
      const SupportIndex(),
      const ProfileIndex(),
    ];

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      floatingActionButton: _currentPageIndex > 0
          ? null
          : FloatingActionButton(
              onPressed: () async {
                await context.push('/linkaccount');
              },
              backgroundColor: themeData.colorScheme.secondaryContainer,
              shape: const CircleBorder(),
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
        animationDuration: const Duration(milliseconds: 500),
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: const Icon(Icons.home),
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

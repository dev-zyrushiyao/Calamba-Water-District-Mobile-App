import 'package:flutter/material.dart';

import 'package:myapp/custom-widgets/dashboard_account.dart';
import 'package:myapp/pages/05-home-page/index/home_index.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/pages/05-home-page/index/news_index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> accounts = [];
  int _currentPageIndex = 0;

  void addAccount() {
    accounts.addAll([
      DashboardAccount(
        accountName: 'Zyrus Hiyao',
        accountNumber: '591-482-637',
        isActive: true,
        previousBill: 373.25,
        lastReading: 124.0,
        dueDay: 3,
        balance: 346.00,
        primaryButton: PrimaryButton(
          label: 'Pay Bill',
          width: 92,
          height: 43,
          onPressed: () {},
        ),
      ),

      DashboardAccount(
        accountName: 'Apartment - A',
        accountNumber: '415-882-361',
        isActive: true,
        previousBill: 289.25,
        lastReading: 110.0,
        dueDay: 12,
        balance: 235.00,
        primaryButton: PrimaryButton(
          label: 'Pay Bill',
          width: 92,
          height: 43,
          onPressed: () {},
        ),
      ),

      DashboardAccount(
        accountName: 'Apartment - A',
        accountNumber: '415-882-361',
        isActive: true,
        previousBill: 289.25,
        lastReading: 110.0,
        dueDay: 12,
        balance: 235.00,
        primaryButton: PrimaryButton(
          label: 'Pay Bill',
          width: 92,
          height: 43,
          onPressed: () {},
        ),
      ),

      DashboardAccount(
        accountName: 'Apartment - A',
        accountNumber: '415-882-361',
        isActive: true,
        previousBill: 289.25,
        lastReading: 110.0,
        dueDay: 12,
        balance: 235.00,
        primaryButton: PrimaryButton(
          label: 'Pay Bill',
          width: 92,
          height: 43,
          onPressed: () {},
        ),
      ),
    ]);
  }

  @override
  void initState() {
    super.initState();
    addAccount();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final List<Widget> pages = [
      HomeIndex(accounts: accounts),
      NewsIndex(),
      Text('Account'),
      Text('Support'),
      Text('Profile'),
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
      body: SafeArea(child: pages[_currentPageIndex]),
    );
  }
}

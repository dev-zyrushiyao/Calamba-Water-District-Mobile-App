import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:myapp/custom-widgets/dashboard_account.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> accounts = [];

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
    int _currentPageIndex = 1;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Floating has been pressed, add new account');
        },
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        labelTextStyle: WidgetStateProperty<TextStyle>.fromMap(
          <WidgetStatesConstraint, TextStyle>{
            WidgetState.selected: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            WidgetState.any: TextStyle(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          },
        ),
        overlayColor: WidgetStateColor.fromMap(<WidgetStatesConstraint, Color>{
          WidgetState.any: Colors.blueGrey,
        }),
        indicatorColor: Theme.of(context).colorScheme.onSecondary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        animationDuration: Duration(seconds: 1),
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(icon: Icon(Icons.newspaper), label: 'News'),
          NavigationDestination(
            icon: Icon(Icons.water_drop_outlined),
            label: 'Account',
          ),
          NavigationDestination(
            icon: Icon(Icons.build_outlined),
            label: 'Support',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SvgPicture.asset('assets/home-logo.svg', fit: BoxFit.cover),

              SizedBox(height: 28.0),

              Align(
                alignment: Alignment.bottomLeft,
                child: Headline(
                  headline: 'Hi, Zyrus!',
                  subHeadline:
                      'Ready to settle your dues? We\'ve made it easy.',
                  spacing: 5.0,
                ),
              ),

              SizedBox(height: 26.0),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),

              SizedBox(height: 13.0),

              Expanded(
                child: ListView(
                  children: [
                    if (accounts.isNotEmpty)
                      for (var item in accounts) ...[
                        item,
                        SizedBox(height: 26),
                      ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

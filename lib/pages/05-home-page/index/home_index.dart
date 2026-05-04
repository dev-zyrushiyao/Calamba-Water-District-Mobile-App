import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/custom-widgets/dashboard_account.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/data-bank/linked_account_list.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/data-bank/account_type.dart';

class HomeIndex extends StatefulWidget {
  const HomeIndex({super.key});

  @override
  State<HomeIndex> createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  final _loggedUser = AccountType().owner;

  @override
  Widget build(BuildContext context) {
    //accounts to display
    final List<dynamic> accountList = LinkedAccountList().accounts;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Align(
              alignment: AlignmentGeometry.centerStart,
              child: SvgPicture.asset(
                'assets/home-logo.svg',
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 28.0),

            Align(
              alignment: Alignment.bottomLeft,
              child: Headline(
                headline: 'Hi, ${_loggedUser.nickname}!',
                subHeadline: 'Ready to settle your dues? We\'ve made it easy.',
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

            if (accountList.isNotEmpty)
              Expanded(
                child: ListView(
                  children: [
                    for (var item in accountList) ...[
                      DashboardDisplay(
                        waterAccount: item,
                        primaryButton: PrimaryButton(
                          label: 'Pay Bill',
                          width: 92,
                          height: 43,
                          onPressed: () {
                            // debugPrint('${item.accountName}');
                            debugPrint('${accountList[2].accountName}');
                          },
                        ),
                      ),
                      SizedBox(height: 26),
                    ],
                  ],
                ),
              )
            else
              Expanded(
                child: Container(
                  alignment: Alignment.center,

                  child: Text('No linked account'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

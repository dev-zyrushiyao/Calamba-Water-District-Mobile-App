import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/custom-widgets/dashboard_account.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/custom-widgets/silver_dotted_border.dart';
import 'package:myapp/data-bank/account_type.dart';

class HomeIndex extends StatefulWidget {
  const HomeIndex({super.key});

  @override
  State<HomeIndex> createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  final _loggedUser = AccountType().owner;

  @override
  void initState() {
    super.initState();

    debugPrint('Current logged: ${_loggedUser.nickname}');
  }

  @override
  Widget build(BuildContext context) {
    //Updates the value of _loggedUser to any of the account logged in

    final ThemeData theme = Theme.of(context);

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

            const SizedBox(height: 28.0),

            Align(
              alignment: Alignment.bottomLeft,
              child: Headline(
                headline: 'Hi, ${_loggedUser.nickname}!',
                subHeadline: 'Ready to settle your dues? We\'ve made it easy.',
                spacing: 5.0,
              ),
            ),

            const SizedBox(height: 26.0),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('Dashboard', style: theme.textTheme.headlineMedium),
            ),

            const SizedBox(height: 13.0),

            if (_loggedUser.linkedAccounts.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 26),
                  itemCount: _loggedUser.linkedAccounts.length,
                  itemBuilder: (context, index) {
                    return DashboardDisplay(
                      waterAccount: _loggedUser.linkedAccounts[index],
                      primaryButton: PrimaryButton(
                        label: 'Pay Bill',
                        width: 92,
                        height: 43,
                        onPressed: () async {
                          //Push to AccountInformationPage and return a triggerable String stored in result variable
                          final result = await Navigator.pushNamed(
                            context,
                            '/accountinformation',
                            arguments: _loggedUser.linkedAccounts[index],
                          );

                          //When the Account Information Page pressed the delete button it will return
                          //a 'delete string to a variable result'
                          //if the condition is met this will delete the current linked account on the list , the slidable controller on the list
                          //and dispose the controller that has been removed from the SlidableController
                          if (result == 'delete') {
                            setState(() {
                              //removed the target UserLinked LinkedAccount
                              _loggedUser.linkedAccounts.removeAt(index);
                            });
                          } else {
                            //refresh the page when the user get back from
                            //AccountInformationPage to HomeIndex if linked account is not deleted
                            setState(() {});
                          }
                        },
                      ),
                    );
                  },
                ),
              )
            else
              SilverDottedBorder(
                height: 500,
                message: Text(
                  'No linked account',
                  style: theme.textTheme.bodyLarge,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

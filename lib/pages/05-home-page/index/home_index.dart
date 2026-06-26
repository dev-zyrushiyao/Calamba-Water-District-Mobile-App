import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/custom-widgets/dashboard_account.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/custom-widgets/silver_dotted_border.dart';
import 'package:myapp/providers/auth_provider.dart';

class HomeIndex extends ConsumerStatefulWidget {
  const HomeIndex({super.key});

  @override
  ConsumerState<HomeIndex> createState() => _HomeIndexState();
}

class _HomeIndexState extends ConsumerState<HomeIndex> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final loggedUser = ref.watch(authNotifierProvider);

    if (loggedUser == null) {
      return DisplayNoData();
    }

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
                headline: 'Hi, ${loggedUser.nickname}!',
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

            if (loggedUser.linkedAccounts.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 26),
                  itemCount: loggedUser.linkedAccounts.length,
                  itemBuilder: (context, index) {
                    return DashboardDisplay(
                      waterAccount: loggedUser.linkedAccounts[index],
                      primaryButton: PrimaryButton(
                        label: 'Pay Bill',
                        width: 92,
                        height: 43,
                        onPressed: () async {
                          //Push to AccountInformationPage and return a triggerable String stored in result variable
                          final result = await Navigator.pushNamed(
                            context,
                            '/accountinformation',
                            arguments: loggedUser.linkedAccounts[index],
                          );

                          //When the Account Information Page pressed the delete button it will return
                          //a 'delete string to a variable result'
                          //if the condition is met this will delete the current linked account on the list , the slidable controller on the list
                          //and dispose the controller that has been removed from the SlidableController
                          if (result == 'delete') {
                            setState(() {
                              //removed the target UserLinked LinkedAccount
                              loggedUser.linkedAccounts.removeAt(index);
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

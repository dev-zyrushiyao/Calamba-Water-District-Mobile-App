import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/custom-widgets/dashboard_account.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/page_logo.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/custom-widgets/silver_dotted_border.dart';
import 'package:myapp/models/constants/custom_action_enum.dart';
import 'package:myapp/providers/auth_provider.dart';

class HomeIndex extends ConsumerStatefulWidget {
  const HomeIndex({super.key});

  @override
  ConsumerState<HomeIndex> createState() => _HomeIndexState();
}

class _HomeIndexState extends ConsumerState<HomeIndex> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final loggedUser = ref.watch(authProvider);

    if (loggedUser == null) {
      return DisplayNoData();
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            PageLogo(),

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
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 50.0),
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
                          final result = await context.push(
                            '/home/accountinformation',
                            extra: {
                              'waterAccount': loggedUser.linkedAccounts[index],
                            },
                          );

                          //When the Account Information Page pressed the delete button it will return
                          //returns enum to a variable result'
                          //if the condition is met this will delete the current linked account on the list
                          if (result == CustomAction.delete) {
                            ref
                                .read(authProvider.notifier)
                                .removeAccountAtIndex(index);
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

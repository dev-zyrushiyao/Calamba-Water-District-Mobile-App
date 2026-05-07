import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/data-bank/account_type.dart';

class AccountIndex extends StatefulWidget {
  const AccountIndex({super.key});

  @override
  State<AccountIndex> createState() => _AccountIndexState();
}

class _AccountIndexState extends State<AccountIndex> {
  final _loggedUser = AccountType().owner;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 85.0),

            // Dismissible(key: key, child: Text('Text Widget'))
            Headline(
              headline: 'My Account',
              subHeadline:
                  'Manage your active water connections and service details',
            ),

            const SizedBox(height: 30),
            Container(
              color: Color(0xFFEEEEFA),
              child: Container(
                color: Color(0xFFDBDBF0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(children: [Text('591-482-637'), Text('Active')]),
                        Text('Zyrus'),
                      ],
                    ),
                    Text('Button'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

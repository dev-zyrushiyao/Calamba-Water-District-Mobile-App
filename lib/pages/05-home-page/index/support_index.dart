import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/data-bank/account_type.dart';

class SupportIndex extends StatefulWidget {
  const SupportIndex({super.key});

  @override
  State<SupportIndex> createState() => _SupportIndexState();
}

class _SupportIndexState extends State<SupportIndex> {
  final _loggedUser = AccountType().owner;

  final List<String> category = [
    'Report a leak',
    'Billing Issue',
    'Account Issue',
    'App Bug',
  ];

  final List accountList = [];

  // void createAccountList(){
  //   accountList.add(value)
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   addCategory();
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 85.0),

            Headline(
              headline: 'File a Report',
              subHeadline:
                  'Let us know about issues with your water service connection.',
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

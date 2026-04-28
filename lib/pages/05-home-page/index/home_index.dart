import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/custom-widgets/headline.dart';

class HomeIndex extends StatelessWidget {
  const HomeIndex({super.key, required this.accounts});

  final List<Widget> accounts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SvgPicture.asset('assets/home-logo.svg', fit: BoxFit.cover),

          SizedBox(height: 28.0),

          Align(
            alignment: Alignment.bottomLeft,
            child: Headline(
              headline: 'Hi, Zyrus!',
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

          Expanded(
            child: ListView(
              children: [
                if (accounts.isNotEmpty)
                  for (var item in accounts) ...[item, SizedBox(height: 26)],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

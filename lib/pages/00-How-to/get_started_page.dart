import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/primary_button.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 25.0,
            children: [
              const SizedBox(height: 20.0),
              Text(
                'Welcome to the Unofficial Calamba Water District App!',
                style: theme.textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),

              Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Disclaimer:',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Text(
                'Explore this interactive demo built with Flutter, designed to showcase modern mobile UI layouts and application features.',
                style: theme.textTheme.bodyLarge,
              ),

              Text(
                'This demo doesn\'t connect to a real server. It simulates a database by using data classes, lists, and the singleton pattern to store your information temporarily while the app is open.\n'
                'Any data entered will be lost when the app is closed or restarted.',
                style: theme.textTheme.bodyLarge,
              ),

              Text(
                'Web rendering engines may cause animations to appear faster than normal. The native mobile application retains the intended animation speeds and transitions.',
                style: theme.textTheme.bodyLarge,
              ),

              Text(
                'This app is not affiliated with the official Calamba Water District and is intended for demonstration purposes only.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),

              PrimaryButton(
                label: 'Next',
                width: double.infinity,
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/guide'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

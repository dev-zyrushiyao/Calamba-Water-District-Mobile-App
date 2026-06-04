import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/primary_button.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<GuidePage> {
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
                'App Guide',
                style: theme.textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10.0),

              Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'How to use',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Text(
                '• This app requires an account. For testing purposes, please sign up using placeholder credentials. You may use a mock email (e.g., zy@email.com), a mock phone number, or a fake e-wallet number where required.',
                style: theme.textTheme.bodyLarge,
              ),

              Text(
                '• Some buttons and features may not be fully functional as this UI is a demo. Please use mobile view for the best experience.',
                style: theme.textTheme.bodyLarge,
              ),

              Text(
                '• Explore features like Pay Bill, View Bill, Profile Update, Link Account, Chat Support, and the Ticketing System. All data is fictional for demonstration purposes',
                style: theme.textTheme.bodyLarge,
              ),

              Text(
                '• For any questions or issues, please report it on my github repository or contact me through email: zyrushiyao@gmail.com',
                style: theme.textTheme.bodyLarge,
              ),

              const SizedBox(height: 10.0),

              PrimaryButton(
                label: 'Proceed to App',
                width: double.infinity,
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/primary_button.dart';

class RegisterResultPage extends StatelessWidget {
  const RegisterResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 300),
              Icon(
                Icons.check_circle_rounded,
                size: 97.5,
                color: theme.colorScheme.primary,
                semanticLabel: 'checkmark logo',
              ),

              Text(
                'Account created successfully !',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium,
              ),
              Text(
                'You’re all set! Enjoy a faster way to pay your bills and submit service requests anytime, anywhere.',
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall,
              ),

              const SizedBox(height: 300),
              PrimaryButton(
                label: 'Login to get started',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

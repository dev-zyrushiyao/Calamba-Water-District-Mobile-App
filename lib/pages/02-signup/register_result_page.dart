import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/primary_button.dart';

class RegisterResultPage extends StatelessWidget {
  const RegisterResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 19.0,
          children: <Widget>[
            SizedBox(height: 300),

            Icon(
              Icons.check_circle_rounded,
              size: 97.5,
              color: Theme.of(context).colorScheme.primary,
              semanticLabel: 'checkmark logo',
            ),

            Text(
              'Account created successfully !',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'You’re all set! Enjoy a faster way to pay your bills and submit service requests anytime, anywhere.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall,
            ),

            SizedBox(height: 250),
            PrimaryButton(
              label: 'Login to get started',
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/login'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

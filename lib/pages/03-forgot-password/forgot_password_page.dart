import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account Recovery')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 150),

              Headline(
                headline: 'Forgot Password',
                subHeadline:
                    'Need a hand? Provide your email address and we will send you a link to securely update your password.',
                textAlign: TextAlign.center,
                elementAlignment: CrossAxisAlignment.center,
                spacing: 10,
              ),

              SizedBox(height: 45),

              Text(
                'Email',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Enter your registered email address',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
                  ),

                  //error style for validator property (InputDecoration)
                  errorStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                autovalidateMode: AutovalidateMode.onUnfocus,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  //email validation that requires the user to enter a valid email
                  //that contains '@' + '.com' OR '.ph'
                  if (value.contains('@') &&
                      value.endsWith('.com') ^ value.endsWith('.ph')) {
                    return null;
                  } else {
                    return 'Invalid email';
                  }
                },
              ),

              SizedBox(height: 35),

              PrimaryButton(
                label: 'Reset Password',
                onPressed: () {
                  Navigator.pushNamed(context, '/forgotpasswordresult');
                },
              ),

              SizedBox(height: 160),

              Text(
                'Quick Reminder:',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'If it doesn\'t appear in your inbox within a few minutes, it might be in your Spam folder.',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/data-class/user_account.dart';

import 'package:myapp/services/validator_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _validatorService = ValidatorService();

  UserAccount? searchedUser;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Account Recovery')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 150),

              const Headline(
                headline: 'Forgot Password',
                subHeadline:
                    'Need a hand? Provide your email address and we will send you a link to securely update your password.',
                textAlign: TextAlign.center,
                elementAlignment: CrossAxisAlignment.center,
                spacing: 10,
              ),

              const SizedBox(height: 45),

              SizedBox(
                width: double.infinity,
                child: Text(
                  'Email',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Form(key: _formKey, child: _buildTextField(theme)),

              const SizedBox(height: 35),

              PrimaryButton(
                label: 'Reset Password',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    await Future.delayed(Duration(seconds: 1), () {});

                    if (!context.mounted) return;

                    final user = searchedUser;

                    if (user != null) {
                      Navigator.pushNamed(
                        context,
                        '/forgotpasswordresult',
                        arguments: user.email,
                      );
                    } else {
                      throw ArgumentError(
                        'Account is not found , reset password is terminated',
                      );
                    }
                  }
                },
              ),

              const SizedBox(height: 160),

              _buildQuickReminder(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickReminder(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Reminder:',
          textAlign: TextAlign.left,
          style: theme.textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.bold,
            // backgroundColor: Colors.blue[200],
          ),
        ),
        Text(
          'If it doesn\'t appear in your inbox within a few minutes, it might be in your Spam folder.',
          style: theme.textTheme.labelSmall,
        ),
      ],
    );
  }

  Widget _buildTextField(ThemeData theme) {
    final validationService = ValidatorService();
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: 'Enter your registered email address',
        hintStyle: TextStyle(color: theme.colorScheme.onPrimaryFixedVariant),
        errorStyle: theme.textTheme.labelSmall!.copyWith(
          color: theme.colorScheme.error,
        ),
      ),
      onSaved: (String? value) {
        searchedUser = _validatorService.retrieveAccount(value);
      },
      autovalidateMode: AutovalidateMode.onUserInteractionIfError,
      validator: (value) {
        return validationService.resetEmailValidator(value);
      },
    );
  }
}

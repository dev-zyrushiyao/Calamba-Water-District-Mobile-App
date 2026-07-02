import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/models/user_account.dart';
import 'package:myapp/providers/account_provider.dart';

import 'package:myapp/services/validator_service.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
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
                  FocusScope.of(context).unfocus();

                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    await Future.delayed(Duration(seconds: 1), () {});

                    //guard clause
                    if (!context.mounted) return;

                    final emailToReset = searchedUser?.email;

                    if (emailToReset != null) {
                      context.go(
                        '/forgotpassword/recovery',
                        extra: emailToReset,
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
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: 'Enter your registered email address',
        hintStyle: TextStyle(color: theme.colorScheme.onPrimaryFixedVariant),
        errorStyle: theme.textTheme.labelSmall!.copyWith(
          color: theme.colorScheme.error,
        ),
      ),
      validator: (value) {
        searchedUser = ref.read(accountProvider.notifier).searchEmail(value);

        //if the user is not null declare declare boolean as true
        //else return null
        bool? isUserAccountExist = searchedUser != null ? true : null;
        return _validatorService.resetEmailValidator(isUserAccountExist);
      },
      onSaved: (String? value) {
        //no methods here , reset password does not have to save anything
      },
      autovalidateMode: AutovalidateMode.onUserInteractionIfError,
    );
  }
}

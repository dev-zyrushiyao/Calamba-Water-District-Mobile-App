import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:myapp/data-class/user_account.dart';
import 'package:myapp/providers/account_provider.dart';

class AccountVerificationPage extends ConsumerStatefulWidget {
  const AccountVerificationPage({super.key, this.newUser});

  //object passed through GoRoute
  final UserAccount? newUser;

  @override
  ConsumerState<AccountVerificationPage> createState() =>
      _AccountVerificationPageState();
}

class _AccountVerificationPageState
    extends ConsumerState<AccountVerificationPage> {
  final List<Widget> _otp = [];

  //generate node focus
  final List<FocusNode> _focusNodes = List.generate(5, (index) => FocusNode());
  //generate text controllers
  final List<TextEditingController> _controllers = List.generate(
    5,
    (index) => TextEditingController(),
  );

  bool _isOtpComplete = false;

  @override
  void initState() {
    super.initState();
    _addTextField(5);

    for (var controller in _controllers) {
      controller.addListener(_otpChecker);
    }
  }

  @override
  void dispose() {
    _disposeAllController();

    for (var controller in _controllers) {
      controller.removeListener(_otpChecker);
    }

    super.dispose();
  }

  void _otpChecker() {
    final allFilled = _controllers.every(
      (controller) => controller.text.isNotEmpty,
    );

    if (allFilled != _isOtpComplete) {
      setState(() {
        _isOtpComplete = allFilled;
      });
    }
  }

  void _disposeAllController() {
    for (TextEditingController item in _controllers) {
      item.dispose();
    }
  }

  void _addTextField(int textFieldQuantity) {
    for (int i = 0; i < textFieldQuantity; i++) {
      _otp.add(
        _verificationTextField(_focusNodes[i], _controllers[i], (inputValue) {
          //When the textbox has input do the forward focus until it reach the last box
          if (inputValue.isNotEmpty && i < textFieldQuantity - 1) {
            _focusNodes[i + 1].requestFocus();
          }

          //When a textbox is empty do backward focus until it reach the first box
          if (inputValue.isEmpty && i > 0) {
            _focusNodes[i - 1].requestFocus();
          }
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final data = widget.newUser;

    debugPrint('THE NEW USER IS : ${widget.newUser}');

    if (data == null) {
      return DisplayNoData();
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(title: const Text('Account Verification')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 250),

                const Headline(
                  headline: 'Enter Verification Code',
                  subHeadline:
                      'Enter the 6-digit code sent to your email.\nYou can put any digit to bypass the OTP',
                ),

                const SizedBox(height: 40),

                Row(
                  spacing: 10,
                  children: [
                    for (var index = 0; index < _otp.length; index++)
                      Flexible(flex: 1, child: _otp[index]),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: Text.rich(
                    textAlign: TextAlign.left,
                    TextSpan(
                      style: theme.textTheme.labelSmall,
                      children: <TextSpan>[
                        TextSpan(
                          style: const TextStyle(color: Color(0xFF5E5E5E)),
                          text: 'Did not receive code?',
                        ),
                        TextSpan(text: '  '),
                        TextSpan(
                          style: TextStyle(
                            color: theme.colorScheme.outlineVariant,
                            fontWeight: FontWeight.w900,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          text: 'Resend',
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 250),

                PrimaryButton(
                  label: 'Submit',
                  onPressed: _isOtpComplete
                      ? () async {
                          //unfocus keyboard
                          FocusScope.of(context).unfocus();
                          //save the account
                          await ref
                              .read(accountNotifierProvider.notifier)
                              .registerUser(data);

                          if (!context.mounted) return;
                          context.push('/signup/accountverification/result');
                        }
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _verificationTextField(
    FocusNode currentFocusNode,
    TextEditingController controller,
    Function(String) onChanged,
  ) {
    return TextField(
      focusNode: currentFocusNode,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 30),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        counterText: '',
      ),
      maxLength: 1,
      onChanged: onChanged,
    );
  }
}

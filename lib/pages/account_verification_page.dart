import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

class AccountVerificationPage extends StatefulWidget {
  const AccountVerificationPage({super.key});

  @override
  State<AccountVerificationPage> createState() =>
      _AccountVerificationPageState();
}

class _AccountVerificationPageState extends State<AccountVerificationPage> {
  final List<Widget> _otp = [];

  //generate node focus
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  //generate text controllers
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

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
        counterText: '',
        border: OutlineInputBorder(),
      ),
      maxLength: 1,
      onChanged: onChanged,
    );
  }

  @override
  void initState() {
    super.initState();
    _addTextField(6);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: Text('Account Verification')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Headline(
                headline: 'Enter Verification Code',
                subHeadline: 'Enter the 6-digit code sent to your email.',
              ),

              SizedBox(height: 40),

              Row(
                spacing: 10,
                children: [
                  for (var index = 0; index < _otp.length - 1; index++)
                    Flexible(flex: 1, child: _otp[index]),
                ],
              ),

              SizedBox(height: 33),

              PrimaryButton(
                width: double.infinity,
                height: 60,
                label: 'Submit',
                onPressed: () {},
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: Text.rich(
                  textAlign: TextAlign.left,
                  TextSpan(
                    style: Theme.of(context).textTheme.labelSmall,
                    children: <TextSpan>[
                      TextSpan(
                        style: TextStyle(color: Color(0xFF5E5E5E)),
                        text: 'Don’t have account?',
                      ),
                      TextSpan(text: '  '),
                      TextSpan(
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outlineVariant,
                          fontWeight: FontWeight.w900,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/signup');
                          },
                        text: 'Sign Up',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/primary_button.dart';

class RecoveryResultPage extends StatelessWidget {
  const RecoveryResultPage({super.key});

  static const List<String> passwordMask = ["*", "*", "*", "*"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 180),

                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      Icons.mail_outline,
                      size: 200,
                      color: Color(0xFFA1A2D0),
                    ),

                    //Askterisk Textbox Icon
                    Positioned(
                      left: 80,
                      top: 120,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFF2E3092),
                          border: BoxBorder.all(
                            width: 10.0,
                            color: Color(0xFF252675),
                          ),
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 26,
                          children: [
                            for (var item in passwordMask)
                              Text(
                                item,
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondary,
                                    ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                Column(
                  spacing: 20.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Check your email',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text.rich(
                      TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: [
                          TextSpan(text: 'We’ve sent a '),
                          TextSpan(
                            text: 'verification code to m*****@email.com** ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Please follow the instruction to reset your password.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 235),

                PrimaryButton(
                  label: 'Go back to Login',
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/login'));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

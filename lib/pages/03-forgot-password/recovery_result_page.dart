import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/services/masking_service.dart';

class RecoveryResultPage extends StatelessWidget {
  const RecoveryResultPage({super.key});

  static const List<String> passwordMask = ["*", "*", "*", "*"];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MaskingService maskingService = MaskingService();

    final data = ModalRoute.of(context)?.settings.arguments as String?;

    if (data == null) {
      return DisplayNoData();
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 180),

                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(
                        Icons.mail_outline,
                        size: 200,
                        color: Color(0xFFA1A2D0),
                      ),

                      //Askterisk Textbox Icon
                      Positioned(
                        left: 80,
                        top: 120,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E3092),
                            border: BoxBorder.all(
                              width: 10.0,
                              color: const Color(0xFF252675),
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
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    color: theme.colorScheme.onSecondary,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Column(
                    spacing: 20.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Check your email',
                        textAlign: TextAlign.left,
                        style: theme.textTheme.headlineMedium,
                      ),
                      Text.rich(
                        TextSpan(
                          style: theme.textTheme.bodyLarge,
                          children: [
                            const TextSpan(text: 'We’ve sent a '),
                            TextSpan(
                              text: '${maskingService.maskEmail(data)} ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                              text:
                                  'Please follow the instruction to reset your password.',
                            ),
                            const TextSpan(
                              text:
                                  '(This feature is not available in the demo app)',
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
                      Navigator.popUntil(
                        context,
                        ModalRoute.withName('/login'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

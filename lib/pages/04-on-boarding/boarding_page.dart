import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/custom-widgets/boarding_caption.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/custom-shapes/scoop_border.dart';
import 'package:myapp/custom-widgets/secondary_button_outlined.dart';
import 'package:myapp/custom-widgets/shrinking_divider.dart';

class BoardingPageOne extends StatefulWidget {
  const BoardingPageOne({super.key});

  @override
  State<BoardingPageOne> createState() => _BoardingPageOneState();
}

class _BoardingPageOneState extends State<BoardingPageOne> {
  int _currentPageActive = 1;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    const List<AssetImage> boardingImage = [
      AssetImage('assets/mobile-app/onboarding/boarding-1.jpg'),
      AssetImage('assets/mobile-app/onboarding/boarding-2.jpg'),
      AssetImage('assets/mobile-app/onboarding/boarding-3.jpg'),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: ScoopBorder(),
              child: Container(
                height: 545,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 180),
                alignment: Alignment.center,
                color: theme.colorScheme.primary,
                // color: Colors.blue,
                child: AnimatedContainer(
                  height: 224,
                  width: 335,
                  curve: Curves.easeInOutBack,
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(13.0)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: boardingImage[_currentPageActive - 1],
                    ),
                  ),
                ),
              ),
            ),

            _buildBoardingCaption(),

            const SizedBox(height: 70),

            //divider
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 23.00,
              children: [
                ShrinkingDivider(activeDivider: _currentPageActive == 1),
                ShrinkingDivider(activeDivider: _currentPageActive == 2),
                ShrinkingDivider(activeDivider: _currentPageActive == 3),
              ],
            ),

            const SizedBox(height: 70),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear,
                  opacity: _currentPageActive == 1 ? 0 : 1,
                  child: SecondaryButtonOutlined(
                    label: 'Previous',
                    onPressed: _currentPageActive != 1
                        ? () {
                            if (_currentPageActive > 1) {
                              setState(() {
                                _currentPageActive--;
                              });
                            }
                          }
                        : null,
                  ),
                ),

                PrimaryButton(
                  width: 180,
                  label: _currentPageActive == 3 ? 'Dashboard' : 'Next',
                  onPressed: () {
                    if (_currentPageActive < 3) {
                      setState(() {
                        _currentPageActive++;
                      });
                    } else {
                      setState(() {
                        context.go('/home');
                      });
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoardingCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 39.0),
      child: switch (_currentPageActive) {
        1 => const BoardingCaption(
          title: 'Skip the Line, Pay Online',
          caption:
              'View and settle your Calamba Water District bills anytime, anywhere. Secure, fast, and hassle-free',
        ),
        2 => const BoardingCaption(
          title: 'Manage Multiple Accounts',
          caption:
              'Easily add and monitor water bills for your home, business, or relatives—all in one single app.',
        ),
        3 => const BoardingCaption(
          title: 'Track & Connect',
          caption:
              'Access your full payment history, download official receipts, and get instant support whenever you need help.',
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/boarding_caption.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/custom-widgets/scoop_border.dart';
import 'package:myapp/custom-widgets/shrinking_divider.dart';

class BoardingPageOne extends StatefulWidget {
  const BoardingPageOne({super.key});

  @override
  State<BoardingPageOne> createState() => _BoardingPageOneState();
}

class _BoardingPageOneState extends State<BoardingPageOne> {
  int _currentPageActive = 1;

  // void updateDividers() {
  //   debugPrint('pageTransition method invoked!');
  //   debugPrint('PAGE wheninvoked $_currentPageActive');
  //   if (_currentPageActive == 1) {
  //     setState(() {
  //       _isDivider1Active = false;
  //       _isDivider2Active = true;
  //       _isDivider3Active = false;
  //       debugPrint('Current page: $_currentPageActive');
  //     });
  //   }

  //   if (_currentPageActive == 2) {
  //     setState(() {
  //       _isDivider1Active = false;
  //       _isDivider2Active = false;
  //       _isDivider3Active = true;
  //       debugPrint('Current page: $_currentPageActive');
  //     });
  //   }

  //   if (_currentPageActive == 3) {
  //     setState(() {
  //       _isDivider1Active = true;
  //       _isDivider2Active = false;
  //       _isDivider3Active = false;
  //       debugPrint('DashBoard button pressed');
  //       debugPrint('Current page: $_currentPageActive');
  //     });
  //     debugPrint('HEY');
  //   }

  //   if (_currentPageActive > 3) {
  //     debugPrint('Beyond the Limits');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Get the actual screen height
    final double screenWeight = MediaQuery.of(context).size.width;

    const List<AssetImage> boardingImage = [
      AssetImage('assets/mobile-app/onboarding/boarding-1.jpg'),
      AssetImage('assets/mobile-app/onboarding/boarding-2.jpg'),
      AssetImage('assets/mobile-app/onboarding/boarding-3.jpg'),
    ];

    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: ScoopBorder(),
            child: Container(
              height: 545,
              width: screenWeight,
              padding: EdgeInsets.only(top: 180),
              alignment: Alignment.center,
              color: Theme.of(context).colorScheme.primary,
              // color: Colors.blue,
              child: AnimatedContainer(
                height: 224,
                width: 335,
                curve: Curves.easeInOutBack,
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(13.0)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: boardingImage[_currentPageActive - 1],
                  ),
                ),
              ),
            ),
          ),

          if (_currentPageActive == 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 39.0),
              child: const BoardingCaption(
                title: 'Skip the Line, Pay Online',
                caption:
                    'View and settle your Calamba Water District bills anytime, anywhere. Secure, fast, and hassle-free',
              ),
            ),

          if (_currentPageActive == 2)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 39.0),
              child: const BoardingCaption(
                title: 'Manage Multiple Accounts',
                caption:
                    'Easily add and monitor water bills for your home, business, or relatives—all in one single app.',
              ),
            ),

          if (_currentPageActive == 3)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 39.0),
              child: const BoardingCaption(
                title: 'Track & Connect',
                caption:
                    'Access your full payment history, download official receipts, and get instant support whenever you need help.',
              ),
            ),

          const SizedBox(height: 70),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 23.00,
            children: [
              //divider-1
              ShrinkingDivider(activeDivider: _currentPageActive == 1),

              ShrinkingDivider(activeDivider: _currentPageActive == 2),

              ShrinkingDivider(activeDivider: _currentPageActive == 3),
            ],
          ),

          SizedBox(height: 70),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              PrimaryButton(
                width: 180,
                label: _currentPageActive == 3 ? 'Dashboard' : 'Next',
                onPressed: () {
                  if (_currentPageActive < 3) {
                    setState(() {
                      _currentPageActive++;
                    });
                  }
                },
              ),

              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(180.0, 60.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

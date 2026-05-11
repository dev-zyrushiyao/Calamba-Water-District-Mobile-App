import 'package:flutter/material.dart';
import 'dart:async';
import 'package:morphable_shape/morphable_shape.dart';

import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';

class LinkAccountPage extends StatefulWidget {
  const LinkAccountPage({super.key});

  @override
  State<LinkAccountPage> createState() => _LinkAccountPageState();
}

class _LinkAccountPageState extends State<LinkAccountPage>
    with SingleTickerProviderStateMixin {
  //controller for modal bottom sheet animation

  late final AnimationController _controller = AnimationController(
    animationBehavior: AnimationBehavior.preserve,
    vsync: this,
    duration: const Duration(milliseconds: 500),
    reverseDuration: const Duration(milliseconds: 500),
  );

  //Variables for the Loading text animation
  late int _shapeIndex = 0;
  late String loadingText = 'Linking Account';
  late String loadingDotted = '...';
  late int substringStartIndex = 0;
  late int substringEndIndex = 0;
  late bool ascending = true;

  Timer? dotTimer;

  void startTimer() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      // If timer exists and is running, do nothing
      if (dotTimer != null && dotTimer!.isActive) return;

      if (isFinishedLinking || !mounted) {
        timer.cancel();
        dotTimer = null;
      } else {
        setState(() {
          loadingTextAnimation();
        });
      }
    });
  }

  //Function for the loading text animation
  void loadingTextAnimation() {
    if (ascending) {
      if (substringEndIndex < loadingDotted.length) {
        setState(() {
          substringEndIndex++;

          debugPrint(
            'Substring ASCENDING: $loadingDotted: $substringStartIndex , End: $substringEndIndex',
          );
        });
      }

      if (substringEndIndex == loadingDotted.length) {
        ascending = false;
      }
    } else {
      if (1 < loadingDotted.length) {
        substringEndIndex--;
        debugPrint(
          'Substring DECENDING: $loadingDotted: $substringStartIndex , End: $substringEndIndex',
        );
      }
      if (substringEndIndex == 0) {
        ascending = true;
      }
    }
  }

  //Variable to check if the process of linking acocunt is still in prorgress.
  late bool isFinishedLinking = false;

  //link account process simulation function
  Future<void> startLinkingProcess() async {
    //refresh back to default value when the user try to link another account.
    setState(() {
      isFinishedLinking = false;
    });

    // Simulate a delay for the linking process (e.g., API call)
    await Future.delayed(const Duration(seconds: 20), () {
      setState(() {
        isFinishedLinking = true;
      });
    });

    //if the widget still exist pop the modal , the isLinking remains true and will switch to false when the function is triggered again.
    await Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        if (isFinishedLinking == true) {
          //reset the value of substring when the linking process is finished
          substringStartIndex = 0;
          substringEndIndex = 0;
          ascending = true;

          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account linked successfully!')),
          );
        }
      }
    });
  }

  //List of shapes for the morphing animation
  List<MorphableShapeBorder?> _shapes = [];

  //star
  late MorphableShapeBorder shape1 = StarShapeBorder(
    corners: 5,
    inset: 50.toPercentLength,
    cornerRadius: 30.toPXLength,
    cornerStyle: CornerStyle.rounded,
    insetRadius: 0.toPXLength,
    insetStyle: CornerStyle.rounded,
  );

  //Rounded Triangle
  late MorphableShapeBorder shape2 = PolygonShapeBorder(
    sides: 3,
    cornerRadius: 20.toPercentLength,
    cornerStyle: CornerStyle.rounded,
  );

  //Round
  late MorphableShapeBorder shape3 = CircleShapeBorder(
    border: DynamicBorderSide(width: 1, color: Colors.transparent),
  );

  //octagon
  late MorphableShapeBorder shape4 = StarShapeBorder(
    corners: 8,
    inset: 50.toPercentLength,
    cornerRadius: 15.toPercentLength,
    cornerStyle: CornerStyle.rounded,
    insetStyle: CornerStyle.rounded,
  );

  late MorphableShapeBorder shape5 = StarShapeBorder(
    corners: 4,
    inset: 50.toPXLength,
    cornerRadius: 15.toPercentLength,
    cornerStyle: CornerStyle.rounded,
  );

  @override
  void initState() {
    super.initState();
    _shapes = [shape1, shape2, shape3, shape4, shape5];
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Link Account')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 54),

            Headline(
              headline: 'Link new account',
              subHeadline:
                  'Enter your account number to track usage and pay bills.',
            ),

            SizedBox(height: 30),

            Container(
              color: Color(0xFFEEEEFA),

              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                spacing: 52.0,
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text('Account Number'),
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      label: Text('Account Name'),
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 250),
            PrimaryButton(
              label: 'Link Account',
              onPressed: () {
                startLinkingProcess();
                startTimer();

                showModalBottomSheet<void>(
                  barrierLabel:
                      'Account linking in progress', //accessibility label for screen readers
                  // isDismissible: false,
                  transitionAnimationController: _controller,
                  backgroundColor: Color(0xFF12133A),
                  sheetAnimationStyle: AnimationStyle(
                    curve: Curves.easeInOutBack,
                  ),
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setModalState) {
                        return SizedBox(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 30,
                              children: [
                                TweenAnimationBuilder<MorphableShapeBorder?>(
                                  duration: Duration(seconds: 3),
                                  curve: Curves.easeInOut,
                                  onEnd: () {
                                    setModalState(() {
                                      _shapeIndex =
                                          (_shapeIndex + 1) % _shapes.length;
                                    });
                                  },
                                  tween: MorphableShapeBorderTween(
                                    begin:
                                        /*Algorithm : #---------First Build---------#
                                                      #During intial build the end shape is first index (0) of the list
                                                      #The beginning if the index is 0 then use the last index (shape.length -1 because its used inside a bracket length[5-1]) of the list
                                                      #For example: There a list of 5 shapes , beginning is shape[4] , end is shape[0]. The transition is Shape E to Shape A
                                                      #After the transition is completed the onEnd callback is called and set new value to the index 
                                                      #The new value formula is (current index + 1) % size of the list.
                                                      #For example: current index is 0 , the formula will be (0 + 1) then % 5 = this is going to equal to 1.
                                                      #The new index is 1.
                                                      #The modal is going to rebuild after the animation using SetModalState from the onEnd() callback
                                                      #---------Second Build---------#
                                                      #The end shape now is shape[index of 1]
                                                      #To get the beginning a condition will run if the index is equal to 0? since index is already 1 it will not trigger the length-1 
                                                      #It will run the else which is index - 1 
                                                      #The beginning shape is now [Index 1] - 1 = 0, the beginning index will be 0
                                                      #While the ending index is index 1 , this is going to trigger animation of transition of Shape A to Shape B
                                                      #After the animation it will trigger again the onEnd() callback to set a new index that will be used as ending and beginning.
                                                      */
                                        _shapes[_shapeIndex == 0
                                            ? _shapes.length - 1
                                            : _shapeIndex - 1],
                                    end: _shapes[_shapeIndex],
                                  ),
                                  builder: (context, value, _) {
                                    return AnimatedRotation(
                                      turns: _shapeIndex * 0.50,
                                      curve: Curves.easeInOut,
                                      duration: Duration(seconds: 1),
                                      child: Container(
                                        width: 200,
                                        height: 200,
                                        decoration: ShapeDecoration(
                                          color: theme.colorScheme.tertiary,
                                          shape: value!,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                isFinishedLinking
                                    ? Text(
                                        'Account Linked Successfully!',
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  theme.colorScheme.onSecondary,
                                            ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            loadingText,
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: theme
                                                      .colorScheme
                                                      .onSecondary,
                                                ),
                                          ),

                                          SizedBox(
                                            width: 30,
                                            child: Text(
                                              loadingDotted.substring(
                                                substringStartIndex,
                                                substringEndIndex,
                                              ),
                                              style: theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: theme
                                                        .colorScheme
                                                        .onSecondary,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


    // AnimatedBuilder(
    //                           animation: _controller!,
    //                           builder: (context, child) {
    //                             return SizedBox(
    //                               width: 200,
    //                               height: 200,
    //                               child: ClipPath(
    //                                 clipper: switch (_controller!.value) {
    //                                   < 0.2 => FirstShapePattern(),
    //                                   < 0.4 => SecondShapePattern(),
    //                                   < 0.6 => ThirdShapePattern(),
    //                                   < 0.8 => FourthShapePattern(),
    //                                   _ => FirstShapePattern(),
    //                                 },
    //                                 child: Container(
    //                                   color: _colorAnimation!.value,
    //                                 ),
    //                               ),
    //                             );
    //                           },
    //                         ),

    
                // showModalBottomSheet<void>(
                //   context: context,
                //   builder: (context) {
                //     return AnimatedBuilder(
                //       animation: _controller!,
                //       builder: (context, child) {
                //         return Container(
                //           color: Color(0xFF12133A),
                //           //Center widget to prevent the shape from stretching to the parent widget (container)
                //           child: Center(
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               spacing: 20,
                //               children: [
                //                 SizedBox(
                //                   width: 200,
                //                   height: 200,
                //                   child: AnimatedSwitcher(
                //                     duration: const Duration(seconds: 1),
                //                     transitionBuilder: (child, animation) {
                //                       return RotationTransition(
                //                         turns: animation,
                //                         child: child,
                //                       );
                //                     },
                //                     child: ClipPath(
                //                       key: ValueKey(_controller!.value),
                //                       clipper: switch (_controller!.value) {
                //                         < 0.2 => FirstShapePattern(),
                //                         < 0.4 => SecondShapePattern(),
                //                         < 0.6 => ThirdShapePattern(),
                //                         < 0.8 => FourthShapePattern(),
                //                         _ => FirstShapePattern(),
                //                       },

                //                       child: Container(color: Colors.amber),
                //                     ),
                //                   ),
                //                 ),
                //                 Text(
                //                   'Now Loading',
                //                   style: theme.textTheme.headlineMedium!
                //                       .copyWith(
                //                         color: theme.colorScheme.onSecondary,
                //                       ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         );
                //       },
                //     );
                //   },
                // );
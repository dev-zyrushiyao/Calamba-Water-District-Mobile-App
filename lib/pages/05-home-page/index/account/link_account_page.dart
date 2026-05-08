import 'package:flutter/material.dart';
import 'package:myapp/custom-shapes/modal-shape/first_shape_pattern.dart';
import 'package:myapp/custom-shapes/modal-shape/fourth_shape_pattern.dart';
import 'package:myapp/custom-shapes/modal-shape/second_shape_pattern.dart';
import 'package:myapp/custom-shapes/modal-shape/third_shape_pattern.dart';
import 'package:myapp/custom-widgets/form_editable_textfield.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';

class LinkAccountPage extends StatefulWidget {
  const LinkAccountPage({super.key});

  @override
  State<LinkAccountPage> createState() => _LinkAccountPageState();
}

class _LinkAccountPageState extends State<LinkAccountPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _colorAnimation;
  bool isAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 15),
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: Colors.amber,
      end: Colors.red,
    ).animate(_controller!);

    _controller!.addListener(() {
      debugPrint('Controller Value: ${_controller!.value}');
      debugPrint('Animation Value: ${_colorAnimation!.value}');
    });

    _controller!.addStatusListener((status) {
      //if animation complete set isAnimated boolean to True
      if (status == AnimationStatus.completed) {
        setState(() {
          isAnimated = true;
        });
      }
      //if animation dismissed set isAnimated boolean to false
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isAnimated = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    //Flower shape
    StarBorder flowerShape = StarBorder(
      points: 7,
      innerRadiusRatio: 0.5,
      pointRounding: 0.8,
    );

    StarBorder randomShape = StarBorder(
      points: 5,
      innerRadiusRatio: 0.6,
      pointRounding: 0.5,
    );

    // Animation morphingShape = ShapeBorderTween(
    //   begin: flowerShape,
    //   end: randomShape,
    // ).animate(animationController);

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
                setState(() {
                  isAnimated ? _controller!.reverse() : _controller!.forward();
                });

                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    // 1. Wrap with AnimatedBuilder to listen to _controller
                    return AnimatedBuilder(
                      animation: _controller!,
                      builder: (context, child) {
                        return Container(
                          color: const Color(0xFF12133A),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 30,
                              children: [
                                AnimatedRotation(
                                  duration: Duration.zero,
                                  turns: _controller!.value * 5,
                                  curve: Curves.easeInCubic,
                                  child: SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: ClipPath(
                                      // 2. This key now updates constantly via AnimatedBuilder
                                      clipper: switch (_controller!.value) {
                                        < 0.2 => FirstShapePattern(),
                                        < 0.4 => SecondShapePattern(),
                                        < 0.6 => ThirdShapePattern(),
                                        < 0.8 => FourthShapePattern(),
                                        _ => FirstShapePattern(),
                                      },
                                      child: Container(
                                        // 3. Color will now update smoothly
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Now Loading',
                                  style: theme.textTheme.headlineMedium!
                                      .copyWith(
                                        color: theme.colorScheme.onSecondary,
                                      ),
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
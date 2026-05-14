import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:morphable_shape/morphable_shape.dart';

import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/data-bank/account_type.dart';
import 'package:myapp/data-bank/water_account_list.dart';
import 'package:myapp/data-class/water_account.dart';

class LinkAccountPage extends StatefulWidget {
  const LinkAccountPage({super.key});

  @override
  State<LinkAccountPage> createState() => _LinkAccountPageState();
}

class _LinkAccountPageState extends State<LinkAccountPage>
    with SingleTickerProviderStateMixin {
  //User
  final _loggedUser = AccountType().owner;

  //textController for the text field, value to be wipe after the linking success
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();

  //Map to store the form to transfer for userObject after the linking process finish
  Map<String, String> linkedAccountForm = {
    'accountNumber': '',
    'accountName': '',
  };

  bool _isAccountLinkedFull = false;
  final int _maxAccountToLink = 5;

  //method to generate number using Generic Type
  T generateNumber<T extends num>({
    required int minValue,
    required int maxValue,
  }) {
    String decimalFormat;
    double rawNum;

    switch (T) {
      case == double:
        rawNum = Random().nextDouble() * (maxValue - minValue) + minValue;
        //convert the generated double to String as 00.00 format
        decimalFormat = rawNum.toStringAsFixed(2);
        //convert back the String into double as return
        return double.parse(decimalFormat) as T;

      case == int:
        return Random().nextInt(maxValue) + minValue as T;

      default:
        throw ArgumentError("Unsupported Type");
    }
  }

  //simulated datebase of water accounts
  final List<WaterAccount> waterAccountList = WaterAccountList().accounts;

  //form key for the form widget
  final _formKey = GlobalKey<FormState>();

  //controller for modal bottom sheet animation
  AnimationController? _animationController;

  //Variables for the Loading text animation
  int _shapeIndex = 0;
  String loadingText = 'Linking Account';
  String loadingDotted = '...';
  int substringStartIndex = 0;
  int substringEndIndex = 0;
  bool ascending = true;

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
    if (!mounted) {
      return;
    }

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

          //if the validation is passed and the linking process is finished save the form values
          //values will be saved temporary on a map
          _formKey.currentState?.save();
          debugPrint('Linking process is finished!');

          //store the map values to the UserObject water account to simulate database saving (one to many relationship)
          //add to the linkedaccount list of UserObject (Owner/Currently Logged in User)
          _loggedUser.linkedAccounts.add(
            WaterAccount(
              accountNumber: linkedAccountForm['accountNumber']!,
              accountName: linkedAccountForm['accountName']!,
              isActive: true, //default value
              previousBill: generateNumber<double>(
                minValue: 150,
                maxValue: 700,
              ),
              lastReading: generateNumber<double>(
                minValue: 300,
                maxValue: 1500,
              ),
              dueDay: generateNumber<int>(minValue: 0, maxValue: 30),
              balance: generateNumber<double>(minValue: 150, maxValue: 900),
            ),
          );

          //clears the value of the textfield after saving the information
          _accountNumberController.clear();
          _accountNameController.clear();

          //remove the modal after the process is finished
          Navigator.pop(context);

          //shows snackbar to inform the user about status of the action
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account linked successfully!')),
          );
        }
      } else {
        return;
      }
    });
  }

  //Content of the modal bottom sheet including the saving of form
  Widget modalContent(StateSetter setModalState, ThemeData theme) {
    //linking status progress
    if (!isFinishedLinking) {
      debugPrint('Linking process is still in progress...');
    }
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
                  _shapeIndex = (_shapeIndex + 1) % _shapes.length;
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
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSecondary,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loadingText,
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSecondary,
                        ),
                      ),

                      SizedBox(
                        width: 30,
                        child: Text(
                          loadingDotted.substring(
                            substringStartIndex,
                            substringEndIndex,
                          ),
                          style: theme.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
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
    _animationController = AnimationController(
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
    //added shapes
    _shapes = [shape1, shape2, shape3, shape4, shape5];
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();

    _accountNumberController.dispose();
    _accountNameController.dispose();
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
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              decoration: BoxDecoration(
                color: Color(0xFFEEEEFA),
                border: BoxBorder.all(
                  color: const Color(0xFFC8C8E5),
                  width: 3,
                  strokeAlign: -1.0,
                ),
                borderRadius: BorderRadius.circular(13.0),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 30.0,
                  children: [
                    TextFormField(
                      controller: _accountNumberController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      maxLength: 9,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter account number';
                        }

                        if (value.length != 9) {
                          return 'Field must be 9 digits long';
                        }

                        //only accept numbers 0-9
                        if (!RegExp(r'^\d+$').hasMatch(value)) {
                          return 'Field must contain only numbers';
                        }

                        //validation pass
                        return null;
                      },
                      onSaved: (value) {
                        //value is saved to the map when the linking process is finished
                        linkedAccountForm['accountNumber'] = value!;
                      },
                      decoration: InputDecoration(
                        label: Text('Account Number'),
                        helperStyle: theme.textTheme.labelSmall!.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryFixedVariant,
                        ),
                        errorStyle: Theme.of(context).textTheme.labelSmall!
                            .copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                        filled: true,
                        fillColor: theme.colorScheme.surface,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextFormField(
                      controller: _accountNameController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.name,
                      maxLength: 15,
                      onSaved: (value) {
                        linkedAccountForm['accountName'] = value!;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter account number';
                        }

                        if (value.length < 2) {
                          return 'Field must accepts 2 or more characters';
                        }

                        //only accept letters and space
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                          return 'Invalid Character';
                        }

                        //validation pass
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text('Nickname'),
                        helperStyle: theme.textTheme.labelSmall!.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryFixedVariant,
                        ),
                        errorStyle: Theme.of(context).textTheme.labelSmall!
                            .copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                        filled: true,
                        fillColor: theme.colorScheme.surface,
                        border: OutlineInputBorder(),
                      ),
                    ),

                    _isAccountLinkedFull
                        ? Text(
                            'Message: You have reached the maximum number of linked service connections.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 250),
            PrimaryButton(
              label: 'Link Account',
              onPressed: () {
                if (_loggedUser.linkedAccounts.length == _maxAccountToLink) {
                  //if it reaches maximum linked account , display error
                  setState(() {
                    _isAccountLinkedFull = true;
                  });
                } else if (_formKey.currentState!.validate()) {
                  //if validation passed, the modalBottomSheet appears and will trigger the linking process and the loading text animation
                  //Saving form is triggered from the methood modalContent(setModalState, theme) that returns a widget used for ModalBottomSheet content.
                  //Start linking process
                  startLinkingProcess();
                  //Start the timer for text loading animation
                  startTimer();

                  //Show the modal bottom sheet while the linking process is still in progress
                  showModalBottomSheet<void>(
                    barrierLabel:
                        'Account linking in progress', //accessibility label for screen readers
                    isDismissible: false,
                    transitionAnimationController: _animationController,
                    backgroundColor: Color(0xFF12133A),
                    sheetAnimationStyle: AnimationStyle(
                      curve: Curves.easeInOutBack,
                    ),
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setModalState) {
                          //Stateful Builder , setModal State is use to upload a specifc part of the widget instead of rebuilding the entire page
                          //modalContent method returns a widget of shape morning and loading text
                          //it also saved the value from the form to UserObject linkedAccounts
                          return modalContent(setModalState, theme);
                        },
                      );
                    },
                  );
                } else {
                  debugPrint('Did not pass validation requirements');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

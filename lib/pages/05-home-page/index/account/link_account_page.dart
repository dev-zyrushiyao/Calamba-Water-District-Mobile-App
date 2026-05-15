import 'package:flutter/material.dart';
import 'dart:async';
import 'package:morphable_shape/morphable_shape.dart';
import 'package:myapp/custom-shapes/morphing-shapes/morph_shape.dart';
import 'package:myapp/custom-widgets/colored_container.dart';

import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/data-bank/account_type.dart';
import 'package:myapp/data-bank/water_account_list.dart';
import 'package:myapp/data-class/water_account.dart';
import 'package:myapp/services/link_account_service.dart';
import 'package:myapp/services/user_interface_service.dart';

class LinkAccountPage extends StatefulWidget {
  const LinkAccountPage({super.key});

  @override
  State<LinkAccountPage> createState() => _LinkAccountPageState();
}

class _LinkAccountPageState extends State<LinkAccountPage>
    with SingleTickerProviderStateMixin {
  //User
  final _loggedUser = AccountType().owner;

  //Service
  final LinkAccountService _linkAccountService = LinkAccountService();
  final UserInterfaceService _userInterfaceService = UserInterfaceService();

  //TextController for the text field, value to be wipe after the linking success
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();

  //Map to store the form to transfer for userObject after the linking process finish
  final Map<String, dynamic> linkedAccountForm = {
    'accountNumber': '',
    'accountName': '',
  };

  //Account Link checker
  bool _isAccountLinkedFull = false;
  final int _maxAccountToLink = 5;

  //Duplicate Account checker
  bool _isAccountAlreadyOnList = false;

  //Simulated datebase of water accounts
  final List<WaterAccount> waterAccountList = WaterAccountList().accounts;

  //Form key for the form widget
  final _formKey = GlobalKey<FormState>();

  //controller for modal bottom sheet animation
  AnimationController? _animationController;

  //Variables for the Loading text animation
  int _shapeIndex = 0;
  final String loadingText = 'Linking Account';
  final String loadingDotted = '...';
  int substringStartIndex = 0;
  int substringEndIndex = 0;
  bool ascending = true;

  //Animation Timer for Loading Text
  Timer? dotTimer;

  //List of shapes for the morphing animation
  List<MorphableShapeBorder?> _shapes = [];

  //Variable to check if the process of linking acocunt is still in prorgress.
  late bool _isFinishedLinking = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();

    //Get all shape from MorphShape class
    _shapes = MorphShape().getAllShapes();
  }

  @override
  void dispose() {
    dotTimer?.cancel();
    _animationController?.dispose();
    _accountNumberController.dispose();
    _accountNameController.dispose();
    super.dispose();
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
  }

  // ==================//
  // private methods   //
  // ==================//

  void _startTimer() {
    if (!mounted) return;

    Timer.periodic(const Duration(seconds: 3), (timer) {
      // If timer exists and is running, do nothing
      if (dotTimer != null && dotTimer!.isActive) return;

      if (_isFinishedLinking || !mounted) {
        timer.cancel();
        dotTimer = null;
      } else {
        setState(() {
          _loadingTextAnimation();
        });
      }
    });
  }

  //Function for the loading text animation
  void _loadingTextAnimation() {
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

  void _accountDuplicationChecker() {
    for (var account in _loggedUser.linkedAccounts) {
      if (account.accountNumber ==
          int.tryParse(_accountNumberController.text)) {
        setState(() {
          _isAccountAlreadyOnList = true;
        });
        break;
      } else {
        setState(() {
          _isAccountAlreadyOnList = false;
        });
      }
    }
  }

  void _accountMaxLimitChecker() {
    if (_loggedUser.linkedAccounts.length == _maxAccountToLink) {
      debugPrint('NOTE: ACCOUNT LIKED IS FULL');
      setState(() {
        _isAccountLinkedFull = true;
      });
    } else {
      setState(() {
        _isAccountLinkedFull = false;
      });
    }
  }

  void _createLinkAccount() {
    //store the map values to the UserObject water account to simulate database saving (one to many relationship)
    //add to the linkedaccount list of UserObject (Owner/Currently Logged in User)
    _loggedUser.linkedAccounts.add(
      WaterAccount(
        accountNumber: linkedAccountForm['accountNumber'],
        accountName: linkedAccountForm['accountName']!,
        isActive: true, //default value
        previousBill: _linkAccountService.generateNumber<double>(
          minValue: 150,
          maxValue: 700,
        ),
        lastReading: _linkAccountService.generateNumber<double>(
          minValue: 300,
          maxValue: 1500,
        ),
        dueDay: _linkAccountService.generateNumber<int>(
          minValue: 0,
          maxValue: 30,
        ),
        balance: _linkAccountService.generateNumber<double>(
          minValue: 150,
          maxValue: 900,
        ),
      ),
    );
  }

  //link account process simulation function
  Future<void> _startLinkingProcess() async {
    if (!mounted) return;

    //refresh back to default value when the user try to link another account.
    setState(() {
      _isFinishedLinking = false;
    });

    // Simulate a delay for the linking process (e.g., API call)
    await Future.delayed(const Duration(seconds: 20), () {
      setState(() {
        _isFinishedLinking = true;
      });
    });

    //if the widget still exist pop the modal , the isLinking remains true and will switch to false when the function is triggered again.
    await Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        if (_isFinishedLinking == true) {
          //reset the value of substring when the linking process is finished
          substringStartIndex = 0;
          substringEndIndex = 0;
          ascending = true;

          //if the validation is passed and the linking process is finished save the form values
          //values will be saved temporary on a map
          _formKey.currentState?.save();
          debugPrint('Linking process is finished!');

          _createLinkAccount();

          //clears the value of the textfield after saving the information
          _accountNumberController.clear();
          _accountNameController.clear();

          //remove the modal after the process is finished
          Navigator.pop(context);

          //shows snackbar to inform the user about status of the action
          _userInterfaceService.showCustomSnackbar(
            context,
            'Account linked successfully!',
          );
        }
      } else {
        return;
      }
    });
  }

  void _activateModal(ThemeData theme) {
    //Show the modal bottom sheet while the linking process is still in progress
    //_buildModalContent(setModalState, theme) that returns a widget used for ModalBottomSheet content.
    showModalBottomSheet<void>(
      barrierLabel:
          'Account linking in progress', //accessibility label for screen readers
      isDismissible: false,
      transitionAnimationController: _animationController,
      backgroundColor: Color(0xFF12133A),
      sheetAnimationStyle: AnimationStyle(curve: Curves.easeInOutBack),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            //Stateful Builder , setModal State is used to upload a specifc part of the widget instead of rebuilding the entire page
            //_buildModalContent method returns a widget of shape morphing and loading text
            //it also saved the value from the form to UserObject linkedAccounts
            return _buildModalContent(setModalState, theme);
          },
        );
      },
    );
  }

  //Main UI
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Link Account')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
          children: [
            SizedBox(height: 54),

            Headline(
              headline: 'Link new account',
              subHeadline:
                  'Enter your account number to track usage and pay bills.',
            ),

            SizedBox(height: 30),

            //Size box - A
            ColoredContainer(
              // height: 300,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildAccountNumberTextField(theme),
                    _buildAccountNameTextField(theme),

                    _buildLinkAlert(),
                  ],
                ),
              ),
            ),

            //content-B
            Container(
              height: 350,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: PrimaryButton(
                label: 'Link Account',
                onPressed: () {
                  _accountDuplicationChecker();
                  _accountMaxLimitChecker();

                  //if a user is trying to link account already liked OR if the account liked reached its maximum limit -> Reload the page
                  //else continue build the modal , linking process and timer animation
                  if (_isAccountAlreadyOnList == true ||
                      _isAccountLinkedFull == true) {
                    setState(() {
                      debugPrint('AccountLinked or Already List detected');
                    });
                  } else if (_formKey.currentState!.validate()) {
                    //if validation passed, the modalBottomSheet appears and will trigger the linking process and the loading text animation

                    //Start linking process - Form Saving process
                    _startLinkingProcess();
                    //Start the timer for text loading animation
                    _startTimer();

                    //Show the modal
                    _activateModal(theme);
                  } else {
                    debugPrint('Did not pass validation requirements');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================//
  // PRIVATE UI HELPER METHODS //
  // ==========================//

  Widget _buildTextAlert({required String message}) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        message,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
      ),
    );
  }

  Widget _buildLinkAlert() {
    return SizedBox(
      child: _isAccountAlreadyOnList && _isAccountLinkedFull
          ? _buildTextAlert(
              message:
                  '• The account exist in your list. \n'
                  '• You have reached the maximum number of linked service connections.',
            )
          : _isAccountAlreadyOnList
          ? _buildTextAlert(message: '• The account exist in your list')
          : _isAccountLinkedFull
          ? _buildTextAlert(
              message:
                  '• You have reached the maximum number of linked service connections.',
            )
          : null,
    );
  }

  Widget _buildMorphingShapes(StateSetter setModalState, ThemeData theme) {
    return TweenAnimationBuilder<MorphableShapeBorder?>(
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
            _shapes[_shapeIndex == 0 ? _shapes.length - 1 : _shapeIndex - 1],
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
    );
  }

  Widget _buildAccountNameTextField(ThemeData theme) {
    return TextFormField(
      controller: _accountNameController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.name,
      maxLength: 15,
      onSaved: (value) {
        if (value != null) {
          linkedAccountForm['accountName'] = value;
        } else {
          debugPrint('Error onSaved: TextFormField: Account Name');
          debugPrintStack();
        }
      },
      validator: (value) {
        return _linkAccountService.validateAccountNameTextField(value);
      },
      decoration: InputDecoration(
        label: Text('Nickname'),
        helperStyle: theme.textTheme.labelSmall!.copyWith(
          color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
        ),
        errorStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
          color: Theme.of(context).colorScheme.error,
        ),
        filled: true,
        fillColor: theme.colorScheme.surface,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildAccountNumberTextField(ThemeData theme) {
    return TextFormField(
      controller: _accountNumberController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      maxLength: 9,
      validator: (value) {
        return _linkAccountService.validateAccountNumberTextField(value);
      },
      onSaved: (value) {
        //value is saved to the map when the linking process is finished
        if (value != null) {
          linkedAccountForm['accountNumber'] = int.tryParse(value);
        } else {
          debugPrint('Error onSaved: TextFormField: Account Number');
          debugPrintStack();
        }
      },
      decoration: InputDecoration(
        label: Text('Account Number'),
        helperStyle: theme.textTheme.labelSmall!.copyWith(
          color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
        ),
        errorStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
          color: Theme.of(context).colorScheme.error,
        ),
        filled: true,
        fillColor: theme.colorScheme.surface,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildLoadingDottedAnimation(ThemeData theme) {
    return Row(
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
            loadingDotted.substring(substringStartIndex, substringEndIndex),
            style: theme.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSecondary,
            ),
          ),
        ),
      ],
    );
  }

  //Content of the modal bottom sheet including the saving of form
  Widget _buildModalContent(StateSetter setModalState, ThemeData theme) {
    //linking status progress
    if (!_isFinishedLinking) {
      debugPrint('Linking process is still in progress...');
    }
    return SizedBox(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            _buildMorphingShapes(setModalState, theme),
            _isFinishedLinking
                ? Text(
                    'Account Linked Successfully!',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSecondary,
                    ),
                  )
                : _buildLoadingDottedAnimation(theme),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:morphable_shape/morphable_shape.dart';
import 'package:myapp/custom-shapes/morphing-shapes/morph_shape.dart';
import 'package:myapp/custom-widgets/colored_container.dart';
import 'package:myapp/custom-widgets/custom_text_alert.dart';

import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/providers/auth_provider.dart';

import 'package:myapp/services/link_account_service.dart';
import 'package:myapp/services/user_interface_service.dart';

class LinkAccountPage extends ConsumerStatefulWidget {
  const LinkAccountPage({super.key});

  @override
  ConsumerState<LinkAccountPage> createState() => _LinkAccountPageState();
}

class _LinkAccountPageState extends ConsumerState<LinkAccountPage>
    with SingleTickerProviderStateMixin {
  //Service
  final LinkAccountService _linkAccountService = LinkAccountService();
  final UserInterfaceService _userInterfaceService = UserInterfaceService();

  //TextController for the text field, value to be wipe after the linking success
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();

  //Map to store the form to transfer for userObject after the linking process finish
  final Map<String, dynamic> _linkedAccountForm = {
    'accountNumber': null,
    'accountName': null,
  };

  //Account Link checker
  bool _isAccountLinkedFull = false;
  final int _maxAccountToLink = 5;

  //Duplicate Account checker
  bool _isAccountAlreadyOnList = false;

  //Simulated datebase of water accounts - use only as placeholder
  // final List<WaterAccount> _waterAccountList = WaterAccountList().accounts;

  //Form key for the form widget
  final _formKey = GlobalKey<FormState>();

  //controller for modal bottom sheet animation
  AnimationController? _animationController;

  //Variables for the Loading text animation
  late int _shapeIndex = 0;
  final String _loadingText = 'Linking Account';
  final String _loadingDotted = '...';
  late int _substringStartIndex = 0;
  late int _substringEndIndex = 0;
  late bool _isAscending = true;

  //Animation Timer for Loading Text
  Timer? _dotTimer;

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
    _dotTimer?.cancel();
    _animationController?.dispose();
    _accountNumberController.dispose();
    _accountNameController.dispose();
    super.dispose();
  }

  // ==================//
  // initState methods //
  // ==================//

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
      if (_dotTimer != null && _dotTimer!.isActive) return;

      if (_isFinishedLinking || !mounted) {
        timer.cancel();
        _dotTimer = null;
      } else {
        _loadingTextAnimation();
      }
    });
  }

  //Function for the loading text animation
  void _loadingTextAnimation() {
    if (_isAscending) {
      if (_substringEndIndex < _loadingDotted.length) {
        setState(() {
          _substringEndIndex++;

          debugPrint(
            'Substring ASCENDING value of: [$_loadingDotted] , Start: $_substringStartIndex , End: $_substringEndIndex',
          );
        });
      }

      if (_substringEndIndex == _loadingDotted.length) {
        _isAscending = false;
      }
    } else {
      if (1 < _loadingDotted.length) {
        _substringEndIndex--;
        debugPrint(
          'Substring DECENDING value of: [$_loadingDotted] , Start: $_substringStartIndex , End: $_substringEndIndex',
        );
      }
      if (_substringEndIndex == 0) {
        _isAscending = true;
      }
    }
  }

  void _accountDuplicationChecker() {
    final loggedUser = ref.read(authNotifierProvider);

    if (loggedUser == null) {
      throw ArgumentError.notNull('loggedUser');
    }

    final inputNumber = int.tryParse(_accountNumberController.text);

    bool isExist = loggedUser.linkedAccounts.any((account) {
      return account.accountNumber == inputNumber ? true : false;
    });

    setState(() {
      _isAccountAlreadyOnList = isExist;
    });
  }

  void _accountMaxLimitChecker() {
    final loggedUser = ref.read(authNotifierProvider);

    if (loggedUser == null) {
      throw ArgumentError.notNull('loggedUser');
    }

    //check if the length of the linked account reach the maximum limit
    bool isFull = loggedUser.linkedAccounts.length == _maxAccountToLink;

    setState(() {
      _isAccountLinkedFull = isFull;
    });
  }

  void _clearTextController() {
    _accountNumberController.clear();
    _accountNameController.clear();
  }

  //link account process simulation function
  Future<void> _startLinkingProcess() async {
    if (!mounted) return;

    final loggedUser = ref.read(authNotifierProvider);

    if (loggedUser == null) {
      throw ArgumentError.notNull('loggedUser');
    }

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
          _substringStartIndex = 0;
          _substringEndIndex = 0;
          _isAscending = true;

          //if the validation is passed and the linking process is finished save the form values
          //values will be saved temporary on a map
          _formKey.currentState?.save();

          bool hasNullValue = _linkedAccountForm.entries.any(
            (item) => item.value == null,
          );

          if (!hasNullValue) {
            //create a new WaterAccount
            final newLinkedAccount = _linkAccountService.createLinkAccount(
              _linkedAccountForm,
            );

            ref
                .read(authNotifierProvider.notifier)
                .addLinkedAccount(newLinkedAccount);

            debugPrint('Linking process is finished!');
          } else {
            throw ArgumentError.value(
              '$hasNullValue',
              'bool fromHasValue',
              'Error LinkedAccountForm has a null value (ERR-A1001)',
            );
          }

          //clears the value of the textfield after saving the information
          _clearTextController();

          //remove the modal after the process is finished
          context.pop();

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
      backgroundColor: const Color(0xFF12133A),
      sheetAnimationStyle: const AnimationStyle(curve: Curves.easeIn),
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
    final ThemeData theme = Theme.of(context);

    final _ = ref.watch(authNotifierProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Link Account'),
        leading: IconButton(
          onPressed: () async {
            if (!context.mounted) return;
            FocusScope.of(context).unfocus();

            await Future.delayed(Duration(milliseconds: 1), () {});

            if (!context.mounted) return;
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: SizedBox(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  spacing: 20,
                  children: [
                    const Headline(
                      headline: 'Link new account',
                      subHeadline:
                          'Enter your account number to track usage and pay bills.',
                    ),
                    ColoredContainer(
                      // height: 300,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildAccountNumberTextField(theme),
                            SizedBox(height: 20),
                            _buildAccountNameTextField(theme),

                            _buildLinkAlert(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //content-B
              PrimaryButton(
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
            ],
          ),
        ),
      ),
    );
  }

  // ==========================//
  // PRIVATE UI HELPER METHODS //
  // ==========================//

  Widget _buildLinkAlert() {
    return SizedBox(
      child: _isAccountAlreadyOnList && _isAccountLinkedFull
          ? CustomTextAlert(
              message:
                  '• The account exist in your list. \n'
                  '• You have reached the maximum number of linked service connections.',
            )
          : _isAccountAlreadyOnList
          ? CustomTextAlert(message: '• The account exist in your list')
          : _isAccountLinkedFull
          ? CustomTextAlert(
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
            #For example: There is a list of 5 shapes , beginning is shape[4] , end is shape[0]. The transition is Shape E to Shape A
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
          _linkedAccountForm['accountName'] = value;
        } else {
          debugPrint('Error onSaved: TextFormField: Account Name');
          debugPrintStack();
        }
      },
      validator: (value) {
        return _linkAccountService.validateAccountNameTextField(value);
      },
      decoration: InputDecoration(
        label: const Text('Nickname'),
        helperStyle: theme.textTheme.labelSmall!.copyWith(
          color: theme.colorScheme.onPrimaryFixedVariant,
        ),
        errorStyle: theme.textTheme.labelSmall!.copyWith(
          color: theme.colorScheme.error,
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
          _linkedAccountForm['accountNumber'] = int.tryParse(value);
        } else {
          debugPrint('Error onSaved: TextFormField: Account Number');
          debugPrintStack();
        }
      },
      decoration: InputDecoration(
        label: const Text('Account Number'),
        helperStyle: theme.textTheme.labelSmall!.copyWith(
          color: theme.colorScheme.onPrimaryFixedVariant,
        ),
        errorStyle: theme.textTheme.labelSmall!.copyWith(
          color: theme.colorScheme.error,
        ),
        filled: true,
        fillColor: theme.colorScheme.surface,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildLoadedDottedText(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _loadingText,
          style: theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSecondary,
          ),
        ),
        SizedBox(
          width: 30,
          child: Text(
            _loadingDotted.substring(_substringStartIndex, _substringEndIndex),
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
                : _buildLoadedDottedText(theme),
          ],
        ),
      ),
    );
  }
}

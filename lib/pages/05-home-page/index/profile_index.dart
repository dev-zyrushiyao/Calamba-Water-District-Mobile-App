import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/custom-shapes/profile_border.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/form_editable_textfield.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/custom-widgets/profile_content_display_animation.dart';

import 'package:myapp/data-class/constants/gender_enum.dart';

import 'package:flutter/services.dart';
import 'package:myapp/data-class/constants/text_section_enum.dart';
import 'package:myapp/data-class/user_account.dart';
import 'package:myapp/providers/account_provider.dart';
import 'package:myapp/providers/auth_provider.dart';
import 'package:myapp/services/masking_service.dart';
import 'package:myapp/services/profile_service.dart';
import 'package:myapp/services/user_interface_service.dart';
import 'package:myapp/services/validator_service.dart';

class ProfileIndex extends ConsumerStatefulWidget {
  const ProfileIndex({super.key});

  @override
  ConsumerState<ProfileIndex> createState() => _ProfileIndexState();
}

class _ProfileIndexState extends ConsumerState<ProfileIndex> {
  //services
  final _profileService = ProfileService();
  final _userInterfaceService = UserInterfaceService();
  final _validatorService = ValidatorService();
  final _maskingService = MaskingService();

  //Shape container animation
  double _containerHeight = 0;
  double _photoSize = 0;
  double _nameSize = 0;

  //temporary store new values to a Map of shape animation
  Map<String, double> newSize = {};

  //list to display information from UI
  // final List<dynamic> _loggedUserValues = [];
  Map<TextSection, dynamic> loggedUserValues = {};
  //list of profile section
  List<TextSection> _textSection = [];

  //controller
  final List<TextEditingController> _textController = [];
  final List<DropdownMenuItem<Gender>> _dropDownItems = [];
  Gender? _chosenValue;

  //toggle editing mode
  bool _isEditing = false;

  //toggle hidden character
  bool _isHidden = true;

  //form validator
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Makes the status bar pull the color from your ClipPath
    // statusBarColor: Colors.transparent,
    // Makes icons white (use .dark for black icons)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarContrastEnforced: true,
      ),
    );

    _initializeDropdownItem();
    _initializeTextSection();

    final loggedUser = ref.watch(authNotifierProvider);
    if (loggedUser != null) {
      createUserDisplayValue(loggedUser);
      createTextControllers(loggedUser);
      createDropdownValue(loggedUser);
    }

    // _initializeTextControllers();
    _triggerEntranceAnimation();
  }

  @override
  void dispose() {
    // turn the System tray color to Dark if Profile Index page is closed
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    );

    //controller dispose
    _disposeControllers();
    super.dispose();
  }

  // ==================//
  // initState methods //
  // ==================//

  void _initializeDropdownItem() {
    //invoke at initState
    //Add Gender Enum on the Dropdownlist
    //Sample output: value = Gender.male , Text('Male')
    for (var item in Gender.values) {
      _dropDownItems.add(
        DropdownMenuItem(value: item, child: Text(item.value)),
      );
    }
  }

  void createDropdownValue(UserAccount loggedUser) {
    //Initial Value and changed value of dropdown
    _chosenValue = loggedUser.gender;
  }

  void _initializeTextSection() {
    //make a copy of TextSection Enum in a List that will be looped through the Form
    _textSection = TextSection.values;
  }

  void createTextControllers(UserAccount loggedUser) {
    //initial value of textfield for UI Display
    //add controller to the list
    for (var item in loggedUserValues.values) {
      _textController.add(TextEditingController(text: item.toString()));
    }
  }

  void _triggerEntranceAnimation() {
    //Initial animation unshrink of the Shape
    Future.delayed(Duration(milliseconds: 100), () {
      // Check if the widget is still in the tree before calling setState
      // if (!mounted) return;

      setState(() {
        _containerHeight = 300;
        _photoSize = 50;
        _nameSize = 22;
      });
    });
  }

  void createUserDisplayValue(UserAccount loggedUser) {
    loggedUserValues = {
      TextSection.nickname: loggedUser.nickname,
      TextSection.phoneNumber: loggedUser.phoneNumber.toString().startsWith('9')
          ? '0${loggedUser.phoneNumber}'
          : loggedUser.phoneNumber.toString(),
      TextSection.email: loggedUser.email,
      TextSection.password: loggedUser.password,
      TextSection.gender: loggedUser.gender,
      TextSection.eWallet: loggedUser.ewallet,
    };
  }

  // ==================//
  // Dispose methods   //
  // ==================//

  void _disposeControllers() {
    for (var item in _textController) {
      item.dispose();
    }
  }

  //Main UI
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final loggedUser = ref.watch(authNotifierProvider);

    if (loggedUser == null) {
      return DisplayNoData();
    }

    return Column(
      children: [
        //header animation
        ClipPath(
          clipper: ProfileBorder(),
          clipBehavior: Clip.hardEdge,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: _containerHeight),
            duration: const Duration(seconds: 1),
            curve: Curves.easeOutBack,
            builder: (context, value, _) {
              return _buildProfileContainer(value, theme, loggedUser);
            },
          ),
        ),

        //User Information Display
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
            child: Column(
              spacing: 5,
              mainAxisSize: MainAxisSize.min,
              children: [
                //Edit Toggle Button
                _buildEditButton(theme),

                const SizedBox(height: 20),

                //Editing Form
                _isEditing
                    ? Expanded(
                        child: Form(
                          key: _formKey,
                          child: ListView.separated(
                            physics: const ClampingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: _textController.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20.0),
                            itemBuilder: (context, index) {
                              return _textSection[index] == TextSection.gender
                                  //if index is Gender section return a dropdown list
                                  ? _buildGenderDropDownButton(
                                      index,
                                      theme,
                                      loggedUser,
                                    )
                                  //else show TextField
                                  : _buildFormTextFields(index, loggedUser);
                            },
                          ),
                        ),
                      )
                    //Displaying the Current User Information
                    : Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          physics: const ScrollPhysics(
                            parent: ClampingScrollPhysics(),
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemCount: _textSection.length,
                          itemBuilder: (context, index) {
                            return _displayUserInformation(
                              index,
                              theme,
                              loggedUser,
                            );
                          },
                        ),
                      ),
                //Save button
                Column(
                  //Button shrinking toggle animation
                  children: [
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 600),
                      tween: Tween<double>(
                        begin: 10,
                        end: _isEditing ? 80 : 10,
                      ),
                      curve: Curves.easeInOutBack,
                      builder: (context, value, _) {
                        return _buildSaveButton(value);
                      },
                    ),
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                        begin: 80,
                        end: _isEditing ? 10 : 80,
                      ),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOutBack,
                      builder: (context, value, child) {
                        return _buildLogoutButton(value, theme);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==========================//
  // PRIVATE UI HELPER METHODS //
  // ==========================//

  Widget _buildProfileContainer(
    double value,
    ThemeData theme,
    UserAccount loggedUser,
  ) {
    final containerWidth = MediaQuery.of(context).size.width;
    return Container(
      width: containerWidth,
      height: value,
      color: theme.colorScheme.primary,
      child: value < 150
          ? const SizedBox.shrink()
          : ProfileContentDisplayAnimation(
              loggedUser: loggedUser,
              containerHeight: _containerHeight,
              photoSize: _photoSize,
              nameSize: _nameSize,
            ),
    );
  }

  Widget _buildEditButton(ThemeData theme) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        label: Text(_isEditing ? 'Cancel' : 'Update Profile'),
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(
            _isEditing
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSecondary,
          ),

          backgroundColor: WidgetStateProperty.all(
            _isEditing ? Color(0xFFB4B5DB) : theme.colorScheme.primary,
          ),
        ),

        icon: Icon(_isEditing ? Icons.close : Icons.edit),
        onPressed: () {
          setState(() {
            //toggle editing mode
            _isEditing = !_isEditing;

            newSize = _profileService.toggleShrinkingAnimation(
              toShrink: _isEditing,
              containerHeight: _containerHeight,
              photoSize: _photoSize,
              nameSize: _nameSize,
            );
            //assign new value to make animation toggle shrinking animation
            _containerHeight = newSize['containerHeight']!;
            _photoSize = newSize['photoSize']!;
            _nameSize = newSize['nameSize']!;
          });
        },
      ),
    );
  }

  Widget _buildGenderDropDownButton(
    int index,
    ThemeData theme,
    UserAccount loggedUser,
  ) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              _textSection[index].value,
              style: theme.textTheme.bodyLarge,
            ),
          ),
          DropdownButtonFormField<Gender>(
            hint: Text(_chosenValue!.value),
            items: _dropDownItems,
            isExpanded: true,
            onSaved: (value) {
              //Saves the form values to User Object (loggedUser)
              //saves only from the TextSection enum : _, _, _, _, gender , _
              if (value != null) {
                _profileService.saveForm(
                  textSection: _textSection[index],
                  textFieldValue: null,
                  loggedUser: loggedUser,
                  dropdownValue: value,
                );

                debugPrint('GENDER DROPDOWN VALUE: $value');

                //re-updates the list for UI display
                loggedUserValues[_textSection[index]] = value.name;
              }
            },
            onChanged: (value) {
              setState(() {
                //Value is Enum (example: Gender.Male)
                _chosenValue = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIconPasswordButton(TextSection textSection) {
    return IconButton(
      onPressed: () {
        setState(() {
          //toggle Switch to hide and unhide password
          _isHidden = !_isHidden;
        });
      },
      icon:
          //if the TextSection is TextSection.password
          //check if the value of isHidden
          //if true -> Hides the Password of Password field and use Visibility Off icon
          //if false -> Show the password of the Password field and use Visibility On icon
          _profileService.hideCharactersFrom(
            textSection: textSection,
            isHidden: _isHidden,
          )
          ? Icon(Icons.visibility_off)
          : Icon(Icons.visibility),
    );
  }

  Widget _buildFormTextFields(int index, UserAccount loggedUser) {
    return FormEditableTextfield(
      textController: _textController[index],
      textSection: _textSection[index].value,
      isHidden: //Hides if character if the textfield is TextSection.password, toggle is trigger by suffix Icon:  __buildIconPasswordButton()
      _profileService.hideCharactersFrom(
        textSection: _textSection[index],
        isHidden: _isHidden,
      ),
      textInputType: _profileService.setInputTypeFrom(_textSection[index]),
      maxLength: _profileService.setMaxCharacterInputFrom(_textSection[index]),
      //if textSection == password show an icon
      suffixIcon: _textSection[index] == TextSection.password
          ? _buildIconPasswordButton(_textSection[index])
          : null,
      validator: (value) {
        bool? isAccountExist;
        if (value != null) {
          isAccountExist = ref
              .read(accountNotifierProvider.notifier)
              .isAccountExist(value);
        }

        switch (_textSection[index]) {
          case TextSection.email:
            if (loggedUser.email != value) {
              return _validatorService.validateInputFrom(
                value: value,
                textSection: _textSection[index],
                loggedUser: loggedUser,
                isAccountExist: isAccountExist,
              );
            }
            break;
          default:
            return _validatorService.validateInputFrom(
              value: value,
              textSection: _textSection[index],
              loggedUser: loggedUser,
              isAccountExist: isAccountExist,
            );
        }

        return null;
      },
      onSaved: (value) {
        //Saves the form values to User Object (loggedUser) except the Gender secton since it is a dropdown list
        //saves only from the TextSection enum : nickname, phoneNumber, email, password, _ , eWallet
        //onSaved() automatically loops all the values of the form to save
        if (value != null) {
          //re-updates the display
          //onSaved() automatically loops all the values of the form to save
          //_LoggedUserValues now equals to the value saved on form instead of controller text.
          //reset the password obscure -> isHidden variable back to default value : true
          setState(() {
            _profileService.saveForm(
              loggedUser: loggedUser,
              textSection: _textSection[index],
              textFieldValue: value,
            );

            loggedUserValues[_textSection[index]] = value;
            _isHidden = true;
          });
        }
      },
      onChanged: (_) {},
    );
  }

  Widget _displayUserInformation(
    int index,
    ThemeData theme,
    UserAccount loggedUser,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        //Text Sections:
        Flexible(
          flex: 1,
          child: SizedBox(
            width: double.infinity,
            child: Text(
              '${_textSection[index].value}:',
              style: theme.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        //Text Sections - value
        Flexible(
          flex: 1,
          child: switch (_textSection[index]) {
            TextSection.nickname => SizedBox(
              width: double.infinity,
              child: Text(
                // '${_loggedUserValues[_textSection[index]]}',
                loggedUser.nickname,

                textAlign: TextAlign.left,
                style: theme.textTheme.bodyLarge,
              ),
            ),

            TextSection.phoneNumber => SizedBox(
              width: double.infinity,
              child: Text(
                _maskingService.maskPhoneNumber(loggedUser.phoneNumber),
                textAlign: TextAlign.left,
                style: theme.textTheme.bodyLarge,
              ),
            ),

            TextSection.email => SizedBox(
              width: double.infinity,
              child: Text(
                // '${_loggedUserValues[_textSection[index]]}',
                loggedUser.email,

                textAlign: TextAlign.left,
                style: theme.textTheme.bodyLarge,
              ),
            ),

            //password mask
            TextSection.password => SizedBox(
              width: double.infinity,
              child: Text(
                '•' * loggedUser.password.length,
                style: theme.textTheme.bodyLarge,
              ),
            ),

            //gender
            TextSection.gender => SizedBox(
              width: double.infinity,
              child: Text(
                loggedUser.gender.value,
                style: theme.textTheme.bodyLarge,
              ),
            ),

            TextSection.eWallet => SizedBox(
              width: double.infinity,
              child: Text(
                loggedUser.ewallet.toString(),
                style: theme.textTheme.bodyLarge,
              ),
            ),
          },
        ),
      ],
    );
  }

  Widget _buildSaveButton(double value) {
    return Container(
      color: Colors.transparent,
      height: value,
      padding: const EdgeInsets.all(10),
      child: PrimaryButton(
        label: 'Save Details',
        onPressed: () {
          //Collapse the keyboard
          FocusScope.of(context).unfocus();

          if (_formKey.currentState!.validate()) {
            //save the form
            _formKey.currentState!.save();

            final updatedUser = ref.read(authNotifierProvider);

            if (updatedUser != null) {
              ref
                  .read(authNotifierProvider.notifier)
                  .updateAccountFromSession(updatedUser);
            }

            //hides again the button after successfully updating the user information
            setState(() {
              //turning off the toggle editing button
              _isEditing = !_isEditing;

              //expand the animatied container
              newSize = _profileService.toggleShrinkingAnimation(
                toShrink: _isEditing,
                containerHeight: _containerHeight,
                photoSize: _photoSize,
                nameSize: _nameSize,
              );

              //reasigning new values of container for toggle animation
              _containerHeight = newSize['containerHeight']!;
              _photoSize = newSize['photoSize']!;
              _nameSize = newSize['nameSize']!;

              //calling the snackbar
              _userInterfaceService.showCustomSnackbar(
                context,
                'Profile has been updated!',
              );
            });
          } else {
            debugPrint('Cannot Save Invalid Input');
          }
        },
      ),
    );
  }

  Widget _buildLogoutButton(double heightValue, ThemeData theme) {
    return Container(
      decoration: const BoxDecoration(),
      clipBehavior: Clip.hardEdge,
      width: 375.0,
      padding: const EdgeInsets.all(10),
      height: heightValue,
      child: FilledButton.icon(
        icon: _isEditing ? SizedBox.shrink() : Icon(Icons.logout),
        onPressed: () {
          ref.read(authNotifierProvider.notifier).logout();

          final currentUser = ref.read(authNotifierProvider);

          if (currentUser == null) {
            context.go('/');
          }
        },
        label: _isEditing ? SizedBox.shrink() : Text('Logout'),
        style: FilledButton.styleFrom(
          backgroundColor: theme.colorScheme.secondaryContainer,
          foregroundColor: theme.colorScheme.onSecondary,
        ),
      ),
    );
  }
}

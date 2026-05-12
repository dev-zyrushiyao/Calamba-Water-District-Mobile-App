import 'package:flutter/material.dart';
import 'package:myapp/custom-shapes/profile_border.dart';
import 'package:myapp/custom-widgets/form_editable_textfield.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/custom-widgets/profile_content_display_animation.dart';

import 'package:myapp/data-bank/account_type.dart';
import 'package:myapp/data-class/constants/enums.dart';

import 'package:flutter/services.dart';

class ProfileIndex extends StatefulWidget {
  const ProfileIndex({super.key});

  @override
  State<ProfileIndex> createState() => _ProfileIndexState();
}

class _ProfileIndexState extends State<ProfileIndex> {
  final _loggedUser = AccountType().owner;

  //RegexTranslator: https://playground.pomsky-lang.org/
  //r'''^[!@#$%^&*()_\-+~`\[\]|;:{}'" <>?,./\\]''',
  final RegExp _specialCharacter = RegExp(r'[\s!-/:-@\[-`{-~]');

  //[underscore , @ and dot] not included
  //r'''[!#$%^&*()\-+~`\[\]|;:{}'" <>?,/\\]''',
  final RegExp _specialCharacterWithException = RegExp(r'[\s!-\-/:-?\[-^`|~]');

  //Shape animation
  double _containerHeight = 0;
  double _photoSize = 0;
  double _nameSize = 0;

  List<dynamic> _loggedUserValues = [];
  List<String> _textSection = [];
  final List<TextEditingController> textController = [];
  final List<DropdownMenuItem<Gender>> dropDownItems = [];
  Gender? chosenValue;

  //toggle editing mode
  bool isEditing = false;

  //Snackbar Widget
  final SnackBar snackBar = SnackBar(
    content: Text('Profile information has been updated!'),
  );

  //form validator
  final _formKey = GlobalKey<FormState>();

  String letterCapitalization(Gender value) {
    return value.name == 'lgbt'
        ? value.name.toUpperCase()
        : value.name[0].toUpperCase() + value.name.substring(1);
  }

  void unShrinkAnimation() {
    _containerHeight = 300;
    _photoSize = 50;
    _nameSize = 22;
  }

  void shrinkAnimation() {
    _containerHeight = 80;
    _photoSize = 10;
    _nameSize = 10;
  }

  void saveFormInformationFrom(int index, String value, [Gender? chosenValue]) {
    switch (index) {
      case 0:
        _loggedUser.nickname = value;
        break;
      case 1:
        _loggedUser.phoneNumber =
            int.tryParse(value) ?? _loggedUser.phoneNumber;
        break;
      case 2:
        _loggedUser.email = value;
        break;
      case 3:
        _loggedUser.password = value;
        break;
      case 4:
        _loggedUser.gender = chosenValue!;
        break;
      case 5:
        _loggedUser.ewallet = int.tryParse(value) ?? 0;
        break;
    }
  }

  TextInputType setInputTypeFrom(int index) {
    return switch (index) {
      0 => TextInputType.name,
      1 || 5 => TextInputType.number,
      2 => TextInputType.emailAddress,
      _ => TextInputType.text,
    };
  }

  int? setMaxCharacterInputFrom(int index) {
    return switch (index) {
      //index of List => maxlength Value
      0 => 15,
      1 => 11,
      3 => 30,
      4 => 30,
      5 => 12,
      _ => null,
    };
  }

  String? validateInputFrom(String? value, index) {
    return switch (index) {
      0 =>
        (value != null && value.length < 2)
            ? 'Please put 2 or more characters'
            : null,
      1 =>
        (value != null && value.length < 11)
            ? 'Invalid number'
            : value!.contains(RegExp(r'^09\d{9}$'))
            ? null
            : 'Please put your 11 digit mobile number',
      2 =>
        (value == null || value.isEmpty)
            ? 'Email is required'
            : (value.startsWith(_specialCharacter))
            ? 'Invalid email: cannot start with special character'
            : (value.contains(_specialCharacterWithException))
            ? 'Invalid character detected'
            : (!value.contains('@'))
            ? 'Email require @ symbol'
            : (value.endsWith('.com')) || (value.endsWith('.ph'))
            ? null
            : 'Invalid Email format',
      3 =>
        (value == null || value.isEmpty)
            ? 'Password is required'
            : (value.length < 10)
            ? 'Not enough password character'
            : null,
      5 =>
        (value == null || value.isEmpty)
            ? 'Please add E-Wallet account'
            : (value.length == 12 &&
                  value.contains(RegExp(r'[0-9]')) &&
                  (value.contains(RegExp(r'^639\d{9}$'))))
            ? null
            : 'Invalid format (needs Area Code without the \'+\' and 11 digit mobile number)',
      _ => null,
    };
  }

  bool hideCharactersFrom(int index) {
    switch (index) {
      case 3:
        return true;
      default:
        return false;
    }
  }

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

    //Add Gender Enum on the Dropdownlist
    //Sample output: value = Gender.male , Text('Male')
    for (var value in Gender.values) {
      dropDownItems.add(
        DropdownMenuItem(
          value: value,
          child: Text(letterCapitalization(value)),
        ),
      );
    }

    //Initial Value and changed value of dropdown
    chosenValue = _loggedUser.gender;

    //section
    _textSection = [
      'Nickname',
      'Phone Number',
      'E-mail',
      'Password',
      'Gender',
      'E-Wallet (GCash)',
    ];

    //List of initial value of textfield from _LoggedUser Object
    _loggedUserValues = [
      _loggedUser.nickname,
      _loggedUser.phoneNumber.toString().startsWith('9')
          ? '0${_loggedUser.phoneNumber}'
          : _loggedUser.phoneNumber.toString(),
      _loggedUser.email,
      _loggedUser.password,
      _loggedUser.gender,
      _loggedUser.ewallet,
    ];

    //initial value of textfield for UI Display
    for (var item in _loggedUserValues) {
      textController.add(TextEditingController(text: item.toString()));
    }

    //Initial animation unshrink of the Shape
    Future.delayed(Duration(milliseconds: 100), () {
      // Check if the widget is still in the tree before calling setState
      setState(() {
        _containerHeight = 300;
        _photoSize = 50;
        _nameSize = 22;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    // turn the System tray color to Dark if Profile Index page is closed
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    );

    //controller dispose
    for (var item in textController) {
      item.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: [
        //header animation
        ClipPath(
          clipper: ProfileBorder(),
          clipBehavior: Clip.hardEdge,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: _containerHeight),
            duration: Duration(seconds: 1),
            curve: Curves.easeOutBack,
            builder: (context, value, child) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: value,
                color: theme.colorScheme.primary,
                child: value < 150
                    ? const SizedBox.shrink()
                    : ProfileContentDisplayAnimation(
                        loggedUser: _loggedUser,
                        containerHeight: _containerHeight,
                        photoSize: _photoSize,
                        nameSize: _nameSize,
                      ),
              );
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
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    label: Text('Edit'),
                    style: ButtonStyle(
                      backgroundColor: const WidgetStateProperty<Color>.fromMap(
                        <WidgetStatesConstraint, Color>{
                          WidgetState.selected: Colors.blue,
                          WidgetState.any: Colors.transparent,
                        },
                      ),
                    ),
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        //toggle editing mode
                        isEditing = !isEditing;

                        if (isEditing == true) {
                          //shrink animation of heading animated container
                          shrinkAnimation();
                        } else {
                          //unshrink animation of heading animated container
                          unShrinkAnimation();
                        }
                      });
                    },
                  ),
                ),

                //Editing Form
                isEditing
                    ? Expanded(
                        child: Form(
                          key: _formKey,
                          child: ListView.separated(
                            physics: const ClampingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: textController.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 20.0),
                            itemBuilder: (context, index) {
                              return _textSection[index] == 'Gender'
                                  //if index is Gender section return a dropdown list
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              _textSection[index],
                                              style: theme.textTheme.bodyLarge,
                                            ),
                                          ),
                                          DropdownButtonFormField<Gender>(
                                            hint: Text(
                                              //Gender Value of User Object will be capitalized for UI Display but the value Remains Enum
                                              //for example _LoggedUser.gender == Gender.male -> it will be converted to Male to Display
                                              letterCapitalization(
                                                chosenValue!,
                                              ),
                                            ),
                                            items: dropDownItems,
                                            isExpanded: true,
                                            onSaved: (value) {
                                              //Saves the form values to User Object (loggedUser)
                                              //saves from the index [4] which is the Gender section
                                              if (value != null) {
                                                saveFormInformationFrom(
                                                  index,
                                                  '',
                                                  value,
                                                );

                                                //re-updates the list for UI display
                                                _loggedUserValues[index] =
                                                    value.name;
                                              }
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                //Value is Enum (example: Gender.Male)
                                                chosenValue = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  //else show TextField
                                  : FormEditableTextfield(
                                      loggedUserValues:
                                          _loggedUserValues[index],
                                      textController: textController[index],
                                      textSection: _textSection[index],
                                      isHidden: hideCharactersFrom(index),
                                      textInputType: setInputTypeFrom(index),
                                      maxLength: setMaxCharacterInputFrom(
                                        index,
                                      ),
                                      validator: (value) {
                                        return validateInputFrom(value, index);
                                      },
                                      onSaved: (value) {
                                        //Saves the form values to User Object (loggedUser) except the Gender secton since it is a dropdown list
                                        //saves only from the index [0,1,2,3,5]
                                        if (value != null) {
                                          saveFormInformationFrom(index, value);

                                          //re-updates the display
                                          //_LoggedUserValues now equals to the value saved on form instead of controller text.
                                          _loggedUserValues[index] = value;
                                        }
                                      },
                                      onChanged: (_) {},
                                    );
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
                              SizedBox(height: 20),
                          itemCount: _textSection.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 20,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      '${_textSection[index]}:',
                                      style: theme.textTheme.bodyLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: switch (index) {
                                    3 => SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '•' * _loggedUserValues[index].length,
                                        style: theme.textTheme.bodyLarge,
                                      ),
                                    ),

                                    4 => SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        letterCapitalization(chosenValue!),
                                        style: theme.textTheme.bodyLarge,
                                      ),
                                    ),

                                    _ => SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '${_loggedUserValues[index]}',
                                        textAlign: TextAlign.left,
                                        style: theme.textTheme.bodyLarge,
                                      ),
                                    ),
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                //Save button
                Column(
                  children: [
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 600),
                      tween: Tween<double>(begin: 10, end: isEditing ? 80 : 10),
                      curve: Curves.easeInOutBack,
                      builder: (context, value, child) {
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
                                //hides again the button after successfully updating the user information
                                setState(() {
                                  //expand the animatied container
                                  unShrinkAnimation();
                                  //turning off the toggle editing button
                                  isEditing = !isEditing;

                                  //calling the snackbar
                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(snackBar);
                                });
                              } else {
                                debugPrint('Cannot Save Invalid Input');
                              }
                            },
                          ),
                        );
                      },
                    ),
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 80, end: isEditing ? 10 : 80),
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeInOutBack,
                      builder: (context, value, child) {
                        return Container(
                          decoration: const BoxDecoration(),
                          clipBehavior: Clip.hardEdge,
                          width: 375.0,
                          padding: const EdgeInsets.all(10),
                          height: value,
                          child: FilledButton.icon(
                            icon: isEditing
                                ? SizedBox.shrink()
                                : Icon(Icons.logout),
                            onPressed: () {},
                            label: isEditing
                                ? SizedBox.shrink()
                                : Text('Logout'),
                            style: FilledButton.styleFrom(
                              backgroundColor:
                                  theme.colorScheme.secondaryContainer,
                              foregroundColor: theme.colorScheme.onSecondary,
                            ),
                          ),
                        );
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
}

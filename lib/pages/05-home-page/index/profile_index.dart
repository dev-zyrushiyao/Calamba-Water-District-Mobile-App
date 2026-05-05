import 'package:flutter/material.dart';
import 'package:myapp/custom-shapes/profile_border.dart';
import 'package:myapp/custom-widgets/form_editable_textfield.dart';
import 'package:myapp/custom-widgets/primary_button.dart';

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

  //Shape animation
  double _containerHeight = 0;
  double _photoSize = 0;
  double _nameSize = 0;

  List _loggedUserValues = [];
  List<String> _textSection = [];
  final List<TextEditingController> textController = [];
  final List<DropdownMenuItem<dynamic>> dropDownItems = [];
  Gender? chosenValue;

  //toggle editing mode
  bool isEditing = false;

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
    _photoSize = 0;
    _nameSize = 0;
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
      _loggedUser.phoneNumber,
      _loggedUser.email,
      _loggedUser.password,
      _loggedUser.gender,
      _loggedUser.ewallet,
    ];

    //initial value of textfield for UI Display
    for (var item in _loggedUserValues) {
      textController.add(TextEditingController(text: item.toString()));
    }

    //Animation Shrink of the Shape
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
          child: AnimatedContainer(
            color: theme.colorScheme.primary,
            duration: Duration(seconds: 1),
            curve: Curves.easeOutBack,
            width: MediaQuery.of(context).size.width,
            height: _containerHeight,
            child: _containerHeight < 150
                ? const SizedBox.shrink()
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Column(
                        children: [
                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0, end: _photoSize),
                            duration: Duration(milliseconds: 900),
                            curve: Curves.easeOutBack,
                            builder: (context, value, child) {
                              return CircleAvatar(
                                radius: value,
                                backgroundImage: AssetImage(_loggedUser.image),
                              );
                            },
                          ),

                          SizedBox(height: 20),

                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0, end: _nameSize),
                            duration: Duration(milliseconds: 900),
                            curve: Curves.linear,
                            builder: (context, value, child) {
                              return _containerHeight < 150
                                  ? SizedBox.shrink()
                                  : Text(
                                      _loggedUser.nickname,
                                      style: theme.textTheme.headlineMedium!
                                          .copyWith(
                                            color:
                                                theme.colorScheme.onSecondary,
                                            fontSize: value,
                                          ),
                                    );
                            },
                          ),

                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
          ),
        ),

        //User Information Display
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
            child: Column(
              spacing: 15,
              mainAxisSize: MainAxisSize.min,
              children: [
                //Edit Toggle Button
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    label: Text('Edit'),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty<Color>.fromMap(
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
                                SizedBox(height: 30.0),
                            itemBuilder: (context, index) {
                              return _textSection[index] == 'Gender'
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
                                          DropdownButton(
                                            hint: Text(chosenValue!.name),
                                            items: dropDownItems,
                                            isExpanded: true,
                                            onChanged: (value) {
                                              setState(() {
                                                chosenValue = value;
                                                debugPrint(value.toString());
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  : FormEditableTextfield(
                                      loggedUserValues:
                                          _loggedUserValues[index],
                                      textController: textController[index],
                                      textSection: _textSection[index],
                                      isHidden: switch (index) {
                                        3 => true,
                                        _ => false,
                                      },
                                      textInputType: switch (index) {
                                        0 => TextInputType.name,
                                        1 || 5 => TextInputType.phone,
                                        2 => TextInputType.emailAddress,
                                        _ => TextInputType.text,
                                      },
                                      maxLength: switch (index) {
                                        //index of List => maxlength Value
                                        0 => 15,
                                        1 => 11,
                                        3 => 30,
                                        4 => 30,
                                        5 => 12,
                                        _ => null,
                                      },
                                      validator: (value) {
                                        return switch (index) {
                                          0 =>
                                            (value != null && value.length < 2)
                                                ? 'Please put 2 or more characters'
                                                : null,
                                          1 =>
                                            (value != null && value.length < 11)
                                                ? 'Invalid number'
                                                : value!.contains(
                                                    RegExp(r'^09\d{9}$'),
                                                  )
                                                ? null
                                                : 'Please put your 11 digit mobile number',
                                          2 =>
                                            (value == null || value.isEmpty)
                                                ? 'Email is required'
                                                : (value.contains('@') &&
                                                      value.endsWith('.com') ^
                                                          value.endsWith('.ph'))
                                                ? null
                                                : 'Invalid email',
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
                                                      value.contains(
                                                        RegExp(r'[0-9]'),
                                                      ) &&
                                                      (value.contains(
                                                        RegExp(r'^639\d{9}$'),
                                                      )))
                                                ? null
                                                : 'Invalid format (needs Area Code without the \'+\' and 11 digit mobile number)',

                                          _ => null,
                                        };
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
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 20),
                          itemCount: _textSection.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 30,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 150,
                                  child: Text(
                                    '${_textSection[index]}:',
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 150,
                                  child: switch (index) {
                                    3 => Text(
                                      '•' * _loggedUserValues[index].length,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.bodyLarge,
                                    ),

                                    4 => Text(
                                      letterCapitalization(chosenValue!),
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.bodyLarge,
                                    ),

                                    _ => Text(
                                      '${_loggedUserValues[index]}',
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.bodyLarge,
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
                      duration: Duration(milliseconds: 600),
                      tween: Tween<double>(begin: 10, end: isEditing ? 80 : 10),
                      curve: Curves.easeInOutBack,
                      builder: (context, value, child) {
                        return Container(
                          color: Colors.transparent,
                          height: value,
                          padding: EdgeInsets.all(10),
                          child: PrimaryButton(
                            label: 'Save Details',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                //Collapse the keyboard
                                FocusScope.of(context).unfocus();

                                //hides again the button after successfully updating the user information
                                setState(() {
                                  //expand the animatied container
                                  unShrinkAnimation();
                                  //turning off the toggle editing button
                                  isEditing = !isEditing;

                                  //updates the Singleton object for all pages and the List of User Information for display in Profile Index
                                  for (
                                    int i = 0;
                                    i < textController.length;
                                    i++
                                  ) {
                                    switch (i) {
                                      case 0:
                                        _loggedUser.nickname =
                                            textController[i].text;
                                        break;
                                      case 1:
                                        _loggedUser.phoneNumber =
                                            int.tryParse(
                                              textController[i].text,
                                            ) ??
                                            _loggedUser.phoneNumber;
                                        break;
                                      case 2:
                                        _loggedUser.email =
                                            textController[i].text;
                                        break;
                                      case 3:
                                        _loggedUser.password =
                                            textController[i].text;
                                        break;
                                      case 4:
                                        _loggedUser.gender = chosenValue!;
                                        break;
                                      case 5:
                                        _loggedUser.ewallet =
                                            int.tryParse(
                                              textController[i].text,
                                            ) ??
                                            0;
                                        break;
                                      // Add other cases (password, gender, etc.) as needed
                                    }
                                    //re-updates the display
                                    _loggedUserValues[i] =
                                        textController[i].text;
                                    debugPrint(
                                      'TEST CONTROLER VALUE:  ${textController[i].value}',
                                    );
                                  }
                                });
                              } else {
                                debugPrint('Cannot Save Invalid Input');
                              }

                              debugPrint(
                                'Current Phone number: ${_loggedUser.phoneNumber}',
                              );
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
                          decoration: BoxDecoration(),
                          clipBehavior: Clip.hardEdge,
                          width: 375.0,
                          padding: EdgeInsets.all(10),
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

  //  children: [
  //                   for (int i = 0; i < textController.length; i++)
  //                     Focus(
  //                       //change the animation of the UI (Shrinks the Shape)
  //                       onFocusChange: (hasFocus) {
  //                         if (hasFocus) {
  //                           setState(() {
  //                             _containerHeight = 30;
  //                             _photoSize = 0;
  //                             _nameSize = 0;
  //                           });
  //                           debugPrint('Its Focused');
  //                         } else {
  //                           setState(() {
  //                             _containerHeight = 300;
  //                             _photoSize = 50;
  //                             _nameSize = 22;
  //                           });
  //                         }
  //                       },
  //                       // if its Gender Section change to DropDown list else display TextField
  //                       child: i == 4
  //                           ? DropdownButton(
  //                               hint: Text(chosenValue!.name),
  //                               items: dropDownItems,
  //                               onChanged: (value) {
  //                                 setState(() {
  //                                   chosenValue = value;
  //                                   debugPrint(value.toString());
  //                                 });
  //                                 // debugPrint(value.toString());
  //                                 // debug
  //                               },
  //                             )
  //                           : FormEditableTextfield(
  //                               loggedUserValues: _loggedUserValues[i],
  //                               textController: textController[i],
  //                               textSection: _textSection[i],
  //                               isHidden: switch (i) {
  //                                 3 => true,
  //                                 _ => false,
  //                               },
  //                               textInputType: switch (i) {
  //                                 0 => TextInputType.name,
  //                                 1 || 5 => TextInputType.phone,
  //                                 2 => TextInputType.emailAddress,
  //                                 _ => TextInputType.text,
  //                               },
  //                               maxLength: switch (i) {
  //                                 //index of List => maxlength Value
  //                                 0 => 15,
  //                                 1 => 11,
  //                                 4 => 30,
  //                                 5 => 13,
  //                                 _ => null,
  //                               },
  //                               validator: (value) {
  //                                 return switch (i) {
  //                                   0 =>
  //                                     (value != null && value.length < 2)
  //                                         ? 'Did not reached the amount of characters need'
  //                                         : null,
  //                                   1 =>
  //                                     (value != null && value.length < 12)
  //                                         ? 'Did not reached the amount of characters need'
  //                                         : null,
  //                                   2 =>
  //                                     (value == null || value.isEmpty)
  //                                         ? 'Email is required'
  //                                         : (value.contains('@') &&
  //                                               value.endsWith('.com') ^
  //                                                   value.endsWith('.ph'))
  //                                         ? null
  //                                         : 'Invalid email',

  //                                   _ => null,
  //                                 };
  //                               },
  //                               onChanged: (value) {
  //                                 setState(() {
  //                                   //updates the list and textbox value not the actual object that used on the pages
  //                                   _loggedUserValues[i] = value;

  //                                   //updates the object for all pages
  //                                   switch (i) {
  //                                     case 0:
  //                                       _loggedUser.nickname = value;
  //                                       break;
  //                                     case 1:
  //                                       _loggedUser.phoneNumber =
  //                                           int.tryParse(value) ??
  //                                           _loggedUser.phoneNumber;
  //                                       break;
  //                                     case 2:
  //                                       _loggedUser.email = value;
  //                                       break;
  //                                     // Add other cases (password, gender, etc.) as needed
  //                                   }
  //                                 });
  //                               },
  //                             ),
  //                     ),

  //                   PrimaryButton(label: 'Save Details'),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }

import 'package:flutter/material.dart';
import 'package:myapp/custom-shapes/profile_border.dart';
import 'package:myapp/custom-widgets/form_editable_textfield.dart';
import 'package:myapp/custom-widgets/primary_button.dart';

import 'package:myapp/data-bank/account_type.dart';
import 'package:myapp/data-class/constants/enums.dart';

class ProfileIndex extends StatefulWidget {
  const ProfileIndex({super.key});

  @override
  State<ProfileIndex> createState() => _ProfileIndexState();
}

class _ProfileIndexState extends State<ProfileIndex> {
  final _loggedUser = AccountType().owner;

  double _containerHeight = 0;
  double _photoSize = 0;
  double _nameSize = 0;

  List _loggedUserValues = [];
  List<String> _textSection = [];
  final List<TextEditingController> textController = [];
  final List<DropdownMenuItem<dynamic>> dropDownItems = [];
  Gender? chosenValue;

  @override
  void initState() {
    super.initState();

    //Add Gender Enum on the Dropdownlist
    for (var value in Gender.values) {
      dropDownItems.add(
        DropdownMenuItem(value: value, child: Text(value.name)),
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
      'E-Wallet',
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

        Expanded(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 20,
              ),
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: textController.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10.0),
                      itemBuilder: (context, index) {
                        return Focus(
                          //change the animation of the UI (Shrinks and unshrinks the Shape)
                          onFocusChange: (hasFocus) {
                            if (hasFocus) {
                              setState(() {
                                _containerHeight = 30;
                                _photoSize = 0;
                                _nameSize = 0;
                              });
                              debugPrint('Its Focused');
                            }
                          },
                          // if its Gender Section change to DropDown list else display TextField
                          child: _textSection[index] == 'Gender'
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      Container(
                                        color: Colors.blue,
                                        width: double.infinity,
                                        child: Text(_textSection[index]),
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
                                          // debugPrint(value.toString());
                                          // debug
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : FormEditableTextfield(
                                  loggedUserValues: _loggedUserValues[index],
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
                                    4 => 30,
                                    5 => 13,
                                    _ => null,
                                  },
                                  validator: (value) {
                                    return switch (index) {
                                      0 =>
                                        (value != null && value.length < 2)
                                            ? 'Did not reached the amount of characters need'
                                            : null,
                                      1 =>
                                        (value != null && value.length < 11)
                                            ? 'Did not reached the amount of characters need'
                                            : null,
                                      2 =>
                                        (value == null || value.isEmpty)
                                            ? 'Email is required'
                                            : (value.contains('@') &&
                                                  value.endsWith('.com') ^
                                                      value.endsWith('.ph'))
                                            ? null
                                            : 'Invalid email',

                                      _ => null,
                                    };
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      //updates the list and textbox value not the actual object that used on the pages
                                      _loggedUserValues[index] = value;
                                    });
                                  },
                                ),
                        );
                      },
                    ),
                  ),
                  PrimaryButton(
                    label: 'Save Details',
                    onPressed: () {
                      setState(() {
                        //expand the animatied container
                        _containerHeight = 300;
                        _photoSize = 50;
                        _nameSize = 22;

                        //updates the Singleton object for all pages
                        for (int i = 0; i < textController.length; i++) {
                          switch (i) {
                            case 0:
                              _loggedUser.nickname = textController[i].text;
                              break;
                            case 1:
                              _loggedUser.phoneNumber =
                                  int.tryParse(textController[i].text) ??
                                  _loggedUser.phoneNumber;
                              break;
                            case 2:
                              _loggedUser.email = textController[i].text;
                              break;
                            case 3:
                              _loggedUser.password = textController[i].text;
                              break;
                            case 4:
                              _loggedUser.gender = chosenValue!;
                              break;
                            case 5:
                              _loggedUser.ewallet = int.parse(
                                textController[i].text,
                              );
                              break;
                            // Add other cases (password, gender, etc.) as needed
                          }
                        }
                      });

                      // setState(() {
                    },
                  ),
                ],
              ),
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

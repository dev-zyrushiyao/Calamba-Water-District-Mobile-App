import 'package:flutter/material.dart';
import 'package:myapp/custom-shapes/profile_border.dart';
import 'package:myapp/custom-widgets/form_editable_textfield.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/custom-widgets/profile_content_display_animation.dart';

import 'package:myapp/data-bank/account_type.dart';
import 'package:myapp/data-class/constants/enums.dart';

import 'package:flutter/services.dart';
import 'package:myapp/services/profile_service.dart';
import 'package:myapp/services/user_interface_service.dart';

import 'package:myapp/data-class/user_account.dart';

class ProfileIndex extends StatefulWidget {
  const ProfileIndex({super.key});

  @override
  State<ProfileIndex> createState() => _ProfileIndexState();
}

class _ProfileIndexState extends State<ProfileIndex> {
  //logged user account
  final _loggedUser = AccountType().owner;

  //services
  final _profileService = ProfileService();
  final _userInterfaceService = UserInterfaceService();

  //Shape container animation
  double _containerHeight = 0;
  double _photoSize = 0;
  double _nameSize = 0;

  //temporary store new values to a Map of shape animation
  Map<String, double> newSize = {};

  //list to display information from UI
  List<dynamic> _loggedUserValues = [];
  //list of profile section
  List<String> _textSection = [];

  //controller
  final List<TextEditingController> _textController = [];
  final List<DropdownMenuItem<Gender>> _dropDownItems = [];
  Gender? _chosenValue;

  //toggle editing mode
  bool _isEditing = false;

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
    _initializeDropdownInitialValue();
    _initializeTextSection();
    _initializeLoggedUserValues();
    _initializeTextControllers();
    _triggerEntranceAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    // turn the System tray color to Dark if Profile Index page is closed
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    );

    //controller dispose
    for (var item in _textController) {
      item.dispose();
    }
  }

  // ==================//
  // initState methods //
  // ==================//

  void _initializeDropdownItem() {
    //invoke at initState
    //Add Gender Enum on the Dropdownlist
    //Sample output: value = Gender.male , Text('Male')
    for (var value in Gender.values) {
      _dropDownItems.add(
        DropdownMenuItem(
          value: value,
          child: Text(_profileService.letterCapitalization(value)),
        ),
      );
    }
  }

  void _initializeDropdownInitialValue() {
    //Initial Value and changed value of dropdown
    _chosenValue = _loggedUser.gender;
  }

  void _initializeTextSection() {
    //section
    _textSection = [
      'Nickname',
      'Phone Number',
      'E-mail',
      'Password',
      'Gender',
      'E-Wallet (GCash)',
    ];
  }

  void _initializeLoggedUserValues() {
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
  }

  void _initializeTextControllers() {
    //initial value of textfield for UI Display
    for (var item in _loggedUserValues) {
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

  //Main UI
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
            builder: (context, value, _) {
              return _buildProfileContainer(value, theme);
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
                _buildEditButton(),

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
                                SizedBox(height: 20.0),
                            itemBuilder: (context, index) {
                              return _textSection[index] == 'Gender'
                                  //if index is Gender section return a dropdown list
                                  ? _buildGenderDropDownButton(index, theme)
                                  //else show TextField
                                  : _buildFormTextFields(index);
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
                            return _displayUserInformation(index, theme);
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
                      duration: Duration(milliseconds: 600),
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

  Widget _buildProfileContainer(double value, ThemeData theme) {
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
  }

  Widget _buildEditButton() {
    return Container(
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

  Widget _buildGenderDropDownButton(int index, ThemeData theme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(_textSection[index], style: theme.textTheme.bodyLarge),
          ),
          DropdownButtonFormField<Gender>(
            hint: Text(_profileService.letterCapitalization(_chosenValue!)),
            items: _dropDownItems,
            isExpanded: true,
            onSaved: (value) {
              //Saves the form values to User Object (loggedUser)
              //saves from the index [4] which is the Gender section
              if (value != null) {
                _profileService.saveFormInformationFrom(
                  _loggedUser,
                  index,
                  '',
                  value,
                );

                //re-updates the list for UI display
                _loggedUserValues[index] = value.name;
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

  Widget _buildFormTextFields(int index) {
    return FormEditableTextfield(
      loggedUserValues: _loggedUserValues[index],
      textController: _textController[index],
      textSection: _textSection[index],
      isHidden: _profileService.hideCharactersFrom(index),
      textInputType: _profileService.setInputTypeFrom(index),
      maxLength: _profileService.setMaxCharacterInputFrom(index),
      validator: (value) {
        return _profileService.validateInputFrom(value, index);
      },
      onSaved: (value) {
        //Saves the form values to User Object (loggedUser) except the Gender secton since it is a dropdown list
        //saves only from the index [0,1,2,3,5]
        if (value != null) {
          _profileService.saveFormInformationFrom(_loggedUser, index, value);

          //re-updates the display
          //_LoggedUserValues now equals to the value saved on form instead of controller text.
          _loggedUserValues[index] = value;
        }
      },
      onChanged: (_) {},
    );
  }

  Widget _displayUserInformation(int index, ThemeData theme) {
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
              '${_textSection[index]}:',
              style: theme.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        //Text Sections - value
        Flexible(
          flex: 1,
          child: switch (index) {
            //password mask
            3 => SizedBox(
              width: double.infinity,
              child: Text(
                '•' * _loggedUserValues[index].length,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            //gender
            4 => SizedBox(
              width: double.infinity,
              child: Text(
                _profileService.letterCapitalization(_chosenValue!),
                style: theme.textTheme.bodyLarge,
              ),
            ),
            //the rest of the text
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

  Widget _buildLogoutButton(double value, ThemeData theme) {
    return Container(
      decoration: const BoxDecoration(),
      clipBehavior: Clip.hardEdge,
      width: 375.0,
      padding: const EdgeInsets.all(10),
      height: value,
      child: FilledButton.icon(
        icon: _isEditing ? SizedBox.shrink() : Icon(Icons.logout),
        onPressed: () {},
        label: _isEditing ? SizedBox.shrink() : Text('Logout'),
        style: FilledButton.styleFrom(
          backgroundColor: theme.colorScheme.secondaryContainer,
          foregroundColor: theme.colorScheme.onSecondary,
        ),
      ),
    );
  }
}

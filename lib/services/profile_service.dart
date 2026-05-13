import 'package:myapp/data-class/constants/enums.dart';
import 'package:myapp/data-class/user_account.dart';
import 'package:flutter/material.dart';

class ProfileService {
  //Gender Value of User Object will be capitalized for UI Display but the value Remains Enum
  //for example _LoggedUser.gender == Gender.male -> it will be converted to Male to Display
  String letterCapitalization(Gender value) {
    return value.name == 'lgbt'
        ? value.name.toUpperCase()
        : value.name[0].toUpperCase() + value.name.substring(1);
  }

  //Shrinking Animation of Profile Container
  Map<String, double> toggleShrinkingAnimation({
    required bool toShrink,
    required double containerHeight,
    required double photoSize,
    required double nameSize,
  }) {
    switch (toShrink) {
      case true:
        return {'containerHeight': 80, 'photoSize': 10, 'nameSize': 10};
      case false:
        return {'containerHeight': 300, 'photoSize': 50, 'nameSize': 22};
    }
  }

  //Updates the profile Information , Gender as optional
  //Gender is used on DropdownForm
  //separate form value fetching from the TextFields
  void saveFormInformationFrom(
    UserAccount loggedUser,
    int index,
    String value, [
    Gender? chosenValue,
  ]) {
    switch (index) {
      case 0:
        loggedUser.nickname = value;
        break;
      case 1:
        loggedUser.phoneNumber = int.tryParse(value) ?? loggedUser.phoneNumber;
        break;
      case 2:
        loggedUser.email = value;
        break;
      case 3:
        loggedUser.password = value;
        break;
      case 4:
        loggedUser.gender = chosenValue!;
        break;
      case 5:
        loggedUser.ewallet = int.tryParse(value) ?? 0;
        break;
    }
  }

  //Asign TextInput for the textfield Form
  TextInputType setInputTypeFrom(int index) {
    return switch (index) {
      0 => TextInputType.name,
      1 || 5 => TextInputType.number,
      2 => TextInputType.emailAddress,
      _ => TextInputType.text,
    };
  }

  //Assign max input from the Looped Custom Widget: FormEditableTextfield
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

  //Validation for the Looped Custom Widget: FormEditableTextfield
  String? validateInputFrom(String? value, index) {
    //RegexTranslator: https://playground.pomsky-lang.org/
    //r'''^[!@#$%^&*()_\-+~`\[\]|;:{}'" <>?,./\\]''',
    final RegExp specialCharacter = RegExp(r'[\s!-/:-@\[-`{-~]');

    //[underscore , @ and dot] not included
    //r'''[!#$%^&*()\-+~`\[\]|;:{}'" <>?,/\\]''',
    final RegExp specialCharacterWithException = RegExp(r'[\s!-\-/:-?\[-^`|~]');
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
            : (value.startsWith(specialCharacter))
            ? 'Invalid email: cannot start with special character'
            : (value.contains(specialCharacterWithException))
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

  //Hide Character for the Looped Custom Widget: FormEditableTextfield
  bool hideCharactersFrom(int index) {
    switch (index) {
      case 3:
        return true;
      default:
        return false;
    }
  }
}

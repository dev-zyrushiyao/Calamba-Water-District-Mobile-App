import 'package:myapp/data-class/constants/gender_enum.dart';
import 'package:myapp/data-class/constants/text_section_enum.dart';
import 'package:myapp/data-class/user_account.dart';
import 'package:flutter/material.dart';

class ProfileService {
  //Gender Value of User Object will be capitalized for UI Display but the value Remains Enum
  //for example _LoggedUser.gender == Gender.male -> it will be converted to Male to Display
  //the original value of enum still remains the same
  //Execution sample: List<TextSection> -> letterCapitalization(textSection[index]) -> Display a String of modified name
  String letterCapitalization(Enum value) {
    switch (value) {
      case Gender _:
        return value.name == 'lgbt'
            ? value.name.toUpperCase()
            : value.name[0].toUpperCase() + value.name.substring(1);
      case TextSection _:
        //temporary string to edit Enum value for display only
        String enumValue = value.name;
        enumValue.split('.').last;

        //email -> E-Mail
        if (enumValue.startsWith('email')) {
          enumValue = 'e-mail';
        }
        //phoneNumber -> phone number
        if (enumValue.startsWith('phoneNumber')) {
          enumValue = 'phone number';
        }

        //ewallet -> e-Wallet (GCASH)
        if (enumValue.startsWith('eWallet')) {
          enumValue = 'e-Wallet (GCASH)';
        }

        //Capitalize the first letter as return value
        return enumValue[0].toUpperCase() + enumValue.substring(1);
      default:
        return throw ArgumentError.notNull('Null value has detected');
    }
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

  //Updates the profile Information
  //Used also on Dropdown onSave with the same form.
  //Can use textFieldValue or DropdownValue if its null it will just ignore the process of saving to the object
  //for textField (onSave) you can put null as value in dropdownValue or just simply not include it in the parameters , vise-versa with Dropdown
  //It will not result to null as it goes through the same form and validate using a key.
  //If somethings break and the textfield or dropdown has null value it will throw an Error and not process to saving process
  /* Saving Algorithm: 
     Form: 
       - TextField -> saveFormInformationFrom (textFieldValue: value , dropdownValue: null)
       - Dropdown -> saveFormInformationFrom (textFieldValue: null , dropdownValue: chosenValue)
       -> UserAccount LoggedUser = TextFieldValue & ChosenValue */
  void saveFormInformationFrom({
    required UserAccount loggedUser,
    required Enum textSection,
    String? textFieldValue,
    Gender? dropdownValue,
  }) {
    //If value is not null(Passed the validation)
    //Saves the values from the TextField (Category Nickname , PhoneNumber , Email , Password , E-Wallet)
    if (textFieldValue != null) {
      switch (textSection) {
        case TextSection.nickname:
          loggedUser.nickname = textFieldValue;
          break;
        case TextSection.phoneNumber:
          loggedUser.phoneNumber =
              int.tryParse(textFieldValue) ?? loggedUser.phoneNumber;
          break;
        case TextSection.email:
          loggedUser.email = textFieldValue;
          break;
        case TextSection.password:
          loggedUser.password = textFieldValue;
          break;
        case TextSection.eWallet:
          loggedUser.ewallet = int.tryParse(textFieldValue) ?? 0;
          break;
        default:
          null;
      }
    }
    //If chosenValue is not null(DropDown has value)
    //Saves the values from the Dropdown (Gender)
    if (dropdownValue != null) {
      switch (textSection) {
        case TextSection.gender:
          loggedUser.gender = dropdownValue;
          break;
      }
    }

    if (dropdownValue == null && textFieldValue == null) {
      debugPrint(
        'ERROR: ProfileService saveFromInformationFrom: Dropdown and TextField -> has null value',
      );
      ArgumentError.checkNotNull(dropdownValue, 'dropdownValue');
      ArgumentError.checkNotNull(textFieldValue, 'dropdownValue');
    }
  }

  //Assign TextInput for the textfield Form
  TextInputType setInputTypeFrom(TextSection textSection) {
    return switch (textSection) {
      TextSection.nickname => TextInputType.name,
      TextSection.phoneNumber || TextSection.eWallet => TextInputType.number,
      TextSection.email => TextInputType.emailAddress,
      _ => TextInputType.text,
    };
  }

  //Assign max input from the Looped Custom Widget: FormEditableTextfield [Gender dropdown not included]
  int? setMaxCharacterInputFrom(TextSection textSection) {
    return switch (textSection) {
      //index of List => maxlength Value
      TextSection.nickname => 15,
      TextSection.phoneNumber => 11,
      TextSection.email => 30,
      TextSection.password => 30,
      TextSection.eWallet => 12,
      _ => null,
    };
  }

  //Validation for the Looped Custom Widget: FormEditableTextfield
  //Dropdown has no validation because it use enum value as default
  String? validateInputFrom({
    required String? value,
    required TextSection textSection,
  }) {
    //RegexTranslator: https://playground.pomsky-lang.org/
    //r'''^[!@#$%^&*()_\-+~`\[\]|;:{}'" <>?,./\\]''', including <space>
    final RegExp specialCharacter = RegExp(r'[\s!-/:-@\[-`{-~]');

    //Any number (whole , decimal , negative , positive)
    final RegExp anyNumber = RegExp(r'[\d+\.?\d*]');

    //Special character excluding <space>
    final RegExp specialCharWithoutSpace = RegExp((r'[!-/:-@\[-`{-~]'));

    //[underscore , @ and dot] not included
    //r'''[!#$%^&*()\-+~`\[\]|;:{}'" <>?,/\\]''',
    final RegExp specialCharacterWithException = RegExp(r'[\s!-\-/:-?\[-^`|~]');
    return switch (textSection) {
      TextSection.nickname =>
        (value != null && value.length < 2)
            ? 'Please put 2 or more characters'
            : (value!.contains(specialCharWithoutSpace) ||
                  (value.contains(anyNumber)))
            ? 'Invalid Character'
            : null,
      TextSection.phoneNumber =>
        (value != null && value.length < 11)
            ? 'Invalid number'
            : value!.contains(RegExp(r'^09\d{9}$'))
            ? null
            : 'Please put your 11 digit mobile number',
      TextSection.email =>
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
      TextSection.password =>
        (value == null || value.isEmpty)
            ? 'Password is required'
            : (value.contains(RegExp(r'[\s]')))
            ? 'Password Should not include <white space>'
            : (value.length < 10)
            ? 'Not enough password character'
            : null,
      TextSection.eWallet =>
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
  bool hideCharactersFrom({
    required TextSection textSection,
    required bool isHidden,
  }) {
    switch (textSection) {
      //determines if the password has hidden or show value
      //this toggles by the ProfileIndex()._buildIconPasswordButton
      case TextSection.password:
        return isHidden ? true : false;
      default:
        return false;
    }
  }
}

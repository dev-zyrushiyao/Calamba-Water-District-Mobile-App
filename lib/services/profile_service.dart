import 'package:myapp/data-bank/deprecated-class/account_collection.dart';
import 'package:myapp/data-class/constants/gender_enum.dart';
import 'package:myapp/data-class/constants/text_section_enum.dart';
import 'package:myapp/data-class/user_account.dart';
import 'package:flutter/material.dart';

class ProfileService {
  @Deprecated(
    'Do not use it if your enum have a value constructor to extract the same value result as this method',
  )
  String letterCapitalization(Enum value) {
    //Value of Enum is capitalized for UI Display
    //for example _LoggedUser.gender == Gender.male -> it will be converted to Male to Display
    //the original value of enum still untouched
    //Execution sample: List<TextSection> -> letterCapitalization(textSection[index]) -> Display a String of modified name
    switch (value) {
      case Gender _:
        return value.name == 'lgbt'
            ? value.name.toUpperCase()
            : value.name[0].toUpperCase() + value.name.substring(1);
      case TextSection _:
        //temporary store the value to string to edit Enum value for display only
        //Get the splitted part after the [dot]
        //Alrogrithm (For example TextSection.nickname -> after split 'nickname' -> Store to string and return a uppercase first letter -> Returns 'Nickname)
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
  //return value is a new value and should be re-store to a map for toggle animation
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
  //If something break and the textfield or dropdown has null value it will throw an Error and not process to saving process
  /* Saving Algorithm: 
     Form: 
       - TextField -> saveFormInformationFrom (textFieldValue: value , dropdownValue: null)
       - Dropdown -> saveFormInformationFrom (textFieldValue: null , dropdownValue: chosenValue)
       -> UserAccount LoggedUser = TextFieldValue & ChosenValue */
  @Deprecated(
    'Used only for OOP version , use saveFormInformation() instead for Provider version',
  )
  void saveFormInformationFrom({
    required UserAccount loggedUser,
    required Enum textSection,
    String? textFieldValue,
    Gender? dropdownValue,
  }) {
    final AccountCollection accountCollection = AccountCollection();
    for (var account in accountCollection.accountDb) {
      if (account.email == loggedUser.email) {
        //If value is not null(It passed the validation)
        //Saves the values from the TextField (Category Nickname , PhoneNumber , Email , Password , E-Wallet)
        if (textFieldValue != null) {
          switch (textSection) {
            case TextSection.nickname:
              loggedUser.nickname = textFieldValue;
              account.nickname = textFieldValue;
              break;
            case TextSection.phoneNumber:
              loggedUser.phoneNumber =
                  int.tryParse(textFieldValue) ?? loggedUser.phoneNumber;
              account.phoneNumber = int.tryParse(textFieldValue) ?? 0;
              break;
            case TextSection.email:
              loggedUser.email = textFieldValue;
              account.email = textFieldValue;
              break;
            case TextSection.password:
              loggedUser.password = textFieldValue;
              account.password = textFieldValue;
              break;
            case TextSection.eWallet:
              loggedUser.ewallet = int.tryParse(textFieldValue) ?? 0;
              account.ewallet = int.tryParse(textFieldValue) ?? 0;
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
              account.gender = dropdownValue;
              break;
          }
        }
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

  @Deprecated(
    'Used only for OOP version , use setInputTypeFrom() instead for Provider version',
  )
  void saveForm({
    required Enum textSection,
    required String? textFieldValue,
    required UserAccount loggedUser,
    Gender? dropdownValue,
  }) {
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

    if (dropdownValue != null) {
      switch (textSection) {
        case TextSection.gender:
          loggedUser.gender = dropdownValue;

          break;
      }
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

import 'package:collection/collection.dart';

import 'package:myapp/data-bank/account_collection.dart';
import 'package:myapp/data-class/constants/gender_enum.dart';
import 'package:myapp/data-class/constants/text_section_enum.dart';
import 'package:myapp/data-class/user_account.dart';

class ValidatorService {
  @Deprecated(
    'This method checks the Singleton class(list of accounts). The AccountProvider already has a method similar to this',
  )
  bool verifyAccount(String? emailInput) {
    final AccountCollection accountCollection = AccountCollection();
    final listOfAccounts = accountCollection.accountDb;
    for (var account in listOfAccounts) {
      if (emailInput == account.email) {
        return true;
      }
    }
    return false;
  }

  @Deprecated(
    'This method checks the Singleton class(list of accounts). The AccountProvider already has a method similar to this',
  )
  UserAccount? retrieveAccount(String? emailInput) {
    final AccountCollection accountCollection = AccountCollection();
    final listOfAccounts = accountCollection.accountDb;
    return listOfAccounts.firstWhereOrNull(
      (accounts) => accounts.email == emailInput,
    );
  }

  //Display reset password validation
  String? resetEmailValidator(bool? isUserAccountExist) {
    if (isUserAccountExist == null) {
      return 'Account not found';
    }

    return null;
  }

  String? nicknameValidator(String? value) {
    //Any number (whole , decimal , negative , positive)
    final RegExp anyNumber = RegExp(r'[\d+\.?\d*]');

    //Special character excluding <space>
    final RegExp specialCharWithoutSpace = RegExp((r'[!-/:-@\[-`{-~]'));

    return (value != null && value.length < 2)
        ? 'Please put 2 or more characters'
        : (value!.contains(specialCharWithoutSpace) ||
              (value.contains(anyNumber)))
        ? 'Invalid Character'
        : null;
  }

  String? emailValidator(
    String? value, [
    UserAccount? userAccount,
    bool? isUserAccountExist,
  ]) {
    //r'''^[!@#$%^&*()_\-+~`\[\]|;:{}'" <>?,./\\]''', including <space>
    final RegExp specialCharacter = RegExp(r'[\s!-/:-@\[-`{-~]');

    //[underscore , @ and dot] not included
    //r'''[!#$%^&*()\-+~`\[\]|;:{}'" <>?,/\\]''',
    final RegExp specialCharacterWithException = RegExp(r'[\s!-\-/:-?\[-^`|~]');

    const emailMinimumLength = 5;

    return (value == null || value.isEmpty)
        ? 'Email is required'
        : (isUserAccountExist == true)
        ? 'This email is not available'
        : (value.length < emailMinimumLength)
        ? 'Not a valid email length'
        : (value.startsWith(specialCharacter))
        ? 'Invalid email: cannot start with special character'
        : (value.contains(specialCharacterWithException))
        ? 'Invalid character detected'
        : (!value.contains('@'))
        ? 'Email require @ symbol'
        : (value.endsWith('.com')) || (value.endsWith('.ph'))
        ? null
        : 'Invalid Email format';
  }

  String? passwordValidator(String? value) {
    return (value == null || value.isEmpty)
        ? 'Password is required'
        : (value.contains(RegExp(r'[\s]')))
        ? 'Password Should not include <white space>'
        : (value.length < 10)
        ? 'Not enough password character'
        : null;
  }

  String? phoneNumberValidator(String? value) {
    return (value != null && value.length < 11)
        ? 'Phone number is required'
        : value!.contains(RegExp(r'^09\d{9}$'))
        ? null
        : 'Please put your 11 digit mobile number';
  }

  String? eWalletValidator(String? value) {
    return (value == null || value.isEmpty)
        ? 'Please add E-Wallet account'
        : (value.length == 12 &&
              value.contains(RegExp(r'[0-9]')) &&
              (value.contains(RegExp(r'^639\d{9}$'))))
        ? null
        : 'Invalid format (Area Code without the \'+\' and 10 digit mobile number without the leading zero is required)';
  }

  String? genderValidator(Gender? value) {
    if (value == null) {
      return 'Please select a gender';
    } else {
      return null;
    }
  }

  //Validation for the Looped Custom Widget: FormEditableTextfield
  //Dropdown has no validation because it use enum value as default
  //This is invoked at ProfileIndex Page
  String? validateInputFrom({
    required String? value,
    required TextSection textSection,
    UserAccount? loggedUser,
    bool? isAccountExist,
  }) {
    return switch (textSection) {
      TextSection.nickname => nicknameValidator(value),
      TextSection.phoneNumber => phoneNumberValidator(value),
      TextSection.email => emailValidator(value, loggedUser, isAccountExist),
      TextSection.password => passwordValidator(value),
      TextSection.eWallet => eWalletValidator(value),
      _ => null,
    };
  }
}

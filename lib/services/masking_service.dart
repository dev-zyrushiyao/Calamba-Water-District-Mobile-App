class MaskingService {
  String maskEmail(String email) {
    const emailMinLength = 5;
    const domainMinLength = 9;

    final int atIndex = email.indexOf('@');
    final String username = email.substring(0, atIndex);
    final String domain = email.substring(atIndex + 1);

    String maskedUsername = '';
    String maskedDomain = '';

    if (atIndex == -1) return email;

    if (email.length < emailMinLength || email.isEmpty) {
      ArgumentError('Insufficient email length , masking process aborted');
    } else {
      maskedUsername = username[0] + ('*' * (username.length - 1));
    }

    if (domain.length < domainMinLength || domain.isEmpty) {
      ArgumentError('Insufficient email length , masking process aborted');
    } else {
      maskedDomain =
          ('*' * (domain.length - 2)) + domain.substring(domain.length - 2);
    }

    return '$maskedUsername@$maskedDomain';
  }

  String maskPhoneNumber(String phoneNumberInString) {
    //split the String character into a list (for example: "MASK" -> ['M' , 'A' , 'S' , 'K'])
    List<String> letterSplit = phoneNumberInString.split('');
    //constant values
    const int characterToMask = 8;
    const String maskingCharacter = 'X';
    const String separatorCharacter = '-';

    //Mask with 'X' the first 8 digit character of the list
    // letterSplit = ['X' , 'X' , 'X' ,'X' ,'X' ,'X' ,'X' , 'X' , 9 , 10 , 11]
    for (var i = 0; i < characterToMask; i++) {
      letterSplit[i] = maskingCharacter;
    }

    // add '-' on the 4th index , since the list grow the next iteration is 5
    //Trigger is on the 4th index and the 9th index
    // letterSplit = ['X' , 'X' , 'X' ,'X' '-' ,'X' ,'X' ,'X' , 'X' , '-' , 9 , 10 , 11]
    for (var i = 4; i < letterSplit.length; i += 5) {
      letterSplit.insert(i, separatorCharacter);
    }

    //join() is to merge the List LetterSplit into a single string
    //['X' , 'X' , 'X' ,'X' '-' ,'X' ,'X' ,'X' , 'X' , '-' , 9 , 10 , 11] -> 'XXXX-XXXX-91011
    return letterSplit.join();
  }

  //Adding a dash/hypen on the User Account Number
  String formatAccountNumber({required int accountNumber}) {
    String numberCharacter = accountNumber.toString();
    List<String> listOfCharacters = numberCharacter.split('');

    for (var i = 3; i < listOfCharacters.length; i += 4) {
      listOfCharacters.insert(i, '-');
    }

    return listOfCharacters.join('');
  }
}

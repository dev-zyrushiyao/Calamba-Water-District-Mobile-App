import 'dart:math';

class LinkAccountService {
  //method to generate number using Generic Type
  T generateNumber<T extends num>({
    required int minValue,
    required int maxValue,
  }) {
    String decimalFormat;
    double rawNum;

    switch (T) {
      case == double:
        rawNum = Random().nextDouble() * (maxValue - minValue) + minValue;
        //convert the generated double to String as 00.00 format
        decimalFormat = rawNum.toStringAsFixed(2);
        //convert back the String into double as return
        return double.parse(decimalFormat) as T;

      case == int:
        return Random().nextInt(maxValue) + minValue as T;

      default:
        throw ArgumentError("Unsupported Type");
    }
  }

  String? validateAccountNumberTextField(String? value) {
    RegExp numberOnly = RegExp(r'^\d+$');
    if (value == null || value.isEmpty) {
      return 'Please enter account number';
    }

    if (value.length != 9) {
      return 'Field must be 9 digits long';
    }

    //only accept numbers 0-9
    if (!numberOnly.hasMatch(value)) {
      return 'Field must contain only numbers';
    }

    //validation pass
    return null;
  }

  String? validateAccountNameTextField(String? value) {
    RegExp letterAndSpaceOnly = RegExp(r'^[a-zA-Z\s]+$');
    if (value == null || value.isEmpty) {
      return 'Please enter account number';
    }

    if (value.length < 2) {
      return 'Field must accepts 2 or more characters';
    }

    //only accept letters and space
    if (!letterAndSpaceOnly.hasMatch(value)) {
      return 'Invalid Character';
    }

    //validation pass
    return null;
  }
}

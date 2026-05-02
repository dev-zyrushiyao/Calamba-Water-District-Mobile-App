import 'package:myapp/data-class/linked_water_account.dart';
import 'package:myapp/data-class/constants/enums.dart';

class UserAccount {
  final String nickname;
  final int phoneNumber;
  final Gender gender; //enum
  final String email;
  final String password;
  final int ewallet;
  final List<LinkedWaterAccount>? linkedAccounts;

  UserAccount(
    this.nickname,
    this.phoneNumber,
    this.gender,
    this.email,
    this.password,
    this.ewallet,
    this.linkedAccounts,
  );

  String get image => gender.getProfileDirectory();
}

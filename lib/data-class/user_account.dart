import 'package:myapp/data-class/water_account.dart';
import 'package:myapp/data-class/constants/gender_enum.dart';

class UserAccount {
  String nickname;
  int phoneNumber;
  Gender gender; //enum
  String email;
  String password;
  int ewallet;
  List<WaterAccount> linkedAccounts;

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

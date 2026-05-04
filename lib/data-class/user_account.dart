import 'package:myapp/data-class/linked_water_account.dart';
import 'package:myapp/data-class/constants/enums.dart';

class UserAccount {
  String nickname;
  int phoneNumber;
  Gender gender; //enum
  String email;
  String password;
  int ewallet;
  List<LinkedWaterAccount>? linkedAccounts;

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

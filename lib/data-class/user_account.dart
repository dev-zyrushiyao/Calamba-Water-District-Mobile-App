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

  UserAccount copyWith({
    String? nickname,
    int? phoneNumber,
    Gender? gender,
    String? email,
    String? password,
    int? ewallet,
    List<WaterAccount>? linkedAccounts,
  }) {
    return UserAccount(
      nickname ?? this.nickname,
      phoneNumber ?? this.phoneNumber,
      gender ?? this.gender,
      email ?? this.email,
      password ?? this.password,
      ewallet ?? this.ewallet,
      linkedAccounts ?? this.linkedAccounts,
    );
  }

  //automatic fetch the image directory according to the chosen gender
  //no need to add the image to constructor
  String get image => gender.getProfileDirectory();
}

import 'package:myapp/models/constants/chat_role_enum.dart';
import 'package:myapp/models/water_account.dart';
import 'package:myapp/models/constants/gender_enum.dart';

class UserAccount {
  String nickname;
  int phoneNumber;
  Gender gender; //enum
  String email;
  String password;
  int ewallet;
  ChatRole chatRole; //enum
  List<WaterAccount> linkedAccounts;

  UserAccount({
    required this.nickname,
    required this.phoneNumber,
    required this.gender,
    required this.email,
    required this.password,
    required this.ewallet,
    this.chatRole = ChatRole.client,
    required this.linkedAccounts,
  });

  UserAccount copyWith({
    String? nickname,
    int? phoneNumber,
    Gender? gender,
    String? email,
    String? password,
    int? ewallet,
    ChatRole? chatRole,
    List<WaterAccount>? linkedAccounts,
  }) {
    return UserAccount(
      nickname: nickname ?? this.nickname,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      password: password ?? this.password,
      ewallet: ewallet ?? this.ewallet,
      chatRole: chatRole ?? this.chatRole,
      linkedAccounts: linkedAccounts ?? this.linkedAccounts,
    );
  }

  //automatic fetch the image directory according to the chosen gender
  //no need to add the image to constructor
  String get image => gender.getProfileDirectory();
}

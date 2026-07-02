import 'package:myapp/models/constants/chat_role_enum.dart';
import 'package:myapp/models/user_account.dart';
import 'package:myapp/models/constants/gender_enum.dart';

@Deprecated(
  'This class is deprecated and will be removed in future versions.  only used in OOP version 1.0.',
)
class AccountType {
  //Singleton Authentication class

  //private constructor
  AccountType._internal();

  // 2. Create the single instance
  static final AccountType _instance = AccountType._internal();

  // 3. The factory constructor always returns the SAME instance
  factory AccountType() => _instance;

  //placeholder
  UserAccount owner = UserAccount(
    nickname: 'ZyrusHiyao',
    phoneNumber: 09123456789,
    gender: Gender.female,
    email: 'myemail@email.com',
    password: 'password1234',
    ewallet: 639123456789,
    linkedAccounts: [],
    chatRole: ChatRole.client,
  );
}

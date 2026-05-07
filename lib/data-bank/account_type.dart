import 'package:myapp/data-class/user_account.dart';
import 'package:myapp/data-class/constants/enums.dart';

class AccountType {
  //private constructor
  AccountType._internal();

  // 2. Create the single instance
  static final AccountType _instance = AccountType._internal();

  // 3. The factory constructor always returns the SAME instance
  factory AccountType() => _instance;

  UserAccount owner = UserAccount(
    'Zy',
    09123456789,
    Gender.female,
    'myemail@email.com',
    'password1234',
    639123456789,
    [],
  );
}

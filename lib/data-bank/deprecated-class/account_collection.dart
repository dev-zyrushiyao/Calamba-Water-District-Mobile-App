import 'package:myapp/models/user_account.dart';

@Deprecated(
  'This class is deprecated and will be removed in future versions.  only used in OOP version 1.0.',
)
class AccountCollection {
  //Singleton Authentication class
  static final AccountCollection _instance = AccountCollection._internal();

  AccountCollection._internal();

  factory AccountCollection() {
    return _instance;
  }

  final List<UserAccount> accountDb = [];
}

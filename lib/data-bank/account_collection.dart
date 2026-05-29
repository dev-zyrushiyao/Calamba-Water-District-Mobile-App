import 'package:myapp/data-class/user_account.dart';

class AccountCollection {
  static final AccountCollection _instance = AccountCollection._internal();

  AccountCollection._internal();

  factory AccountCollection() {
    return _instance;
  }

  final List<UserAccount> accountDb = [];
}

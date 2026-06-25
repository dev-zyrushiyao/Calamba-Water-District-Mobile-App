import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/data-class/user_account.dart';

class AccountNotifier extends Notifier<Set<UserAccount>> {
  @override
  Set<UserAccount> build() {
    return {};
  }

  bool isAccountAlreadyExist(UserAccount userAccount) {
    return state.any((user) => user.email == userAccount.email);
  }

  Future<void> registerUser(UserAccount userAccount) async {
    if (!isAccountAlreadyExist(userAccount)) {
      state = {...state, userAccount};
    } else {
      throw ArgumentError.value(
        'ERR-1000',
        'Email Registration Error',
        'The email used is not available',
      );
    }
  }
}

final accountNotifierProvider =
    NotifierProvider<AccountNotifier, Set<UserAccount>>(() {
      return AccountNotifier();
    });

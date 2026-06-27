import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/data-class/user_account.dart';

class AccountNotifier extends Notifier<Set<UserAccount>> {
  @override
  Set<UserAccount> build() {
    return {};
  }

  //search email if exist on SignUp and ForgotPassword page
  UserAccount? searchEmail(String? email) {
    return state.firstWhereOrNull((account) => account.email == email);
  }

  bool isAccountExist(String email) {
    return state.any((user) => user.email == email);
  }

  //Search the Account then transfer it to AuthProvider(login() method)
  UserAccount? verifyCredentials(String email, String password) {
    return state.firstWhereOrNull(
      (account) => (account.email == email) && (account.password == password),
    );
  }

  //find the email and replace the set with a updated account Object from AuthProvider
  // continue iteration until it reach the end then put it back as a Set
  void updateAccountFromDatabase(UserAccount updatedUser) {
    state = state.map((account) {
      return account.email == updatedUser.email ? updatedUser : account;
    }).toSet();
  }

  Future<void> registerUser(UserAccount userAccount) async {
    final bool isAccountAlreadyExist = state.any(
      (user) => user.email == userAccount.email,
    );

    if (!isAccountAlreadyExist) {
      state = {...state, userAccount};
    } else {
      throw ArgumentError.value(
        userAccount.email,
        'UserAccount userAccount',
        'The email used is not available (ERR-A1000)',
      );
    }
  }
}

final accountNotifierProvider =
    NotifierProvider<AccountNotifier, Set<UserAccount>>(() {
      return AccountNotifier();
    });

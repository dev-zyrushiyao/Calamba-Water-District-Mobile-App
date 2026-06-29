import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/data-class/constants/gender_enum.dart';
import 'package:myapp/data-class/user_account.dart';
import 'package:myapp/data-class/water_account.dart';
import 'package:myapp/providers/account_provider.dart';

class AuthNotifier extends Notifier<UserAccount?> {
  @override
  UserAccount? build() {
    return UserAccount(
      'Zy',
      09151234567,
      Gender.male,
      'zy@email.com',
      '1234567890',
      639151234567,
      [],
    );
    // return null;
  }

  bool login(String email, String password) {
    final user = ref
        .read(accountNotifierProvider.notifier)
        .verifyCredentials(email, password);

    if (user != null) {
      state = user;
      return true;
    }

    //wrong credentials
    return false;
  }

  void logout() {
    state = null;
  }

  void updateLinkedAccount(WaterAccount waterAccount) {
    final currentUser = state;

    if (currentUser == null) {
      ArgumentError.notNull('$currentUser');
      return;
    }

    //find the target item in the list
    final updatedList = List<WaterAccount>.from(currentUser.linkedAccounts);
    final targetIndex = updatedList.indexWhere(
      (account) => account.accountNumber == waterAccount.accountNumber,
    );

    if (targetIndex == -1) return;

    //replace the value with a new object
    updatedList[targetIndex] = waterAccount;

    //modify the current user object with updatedlist
    final updatedUser = currentUser.copyWith(linkedAccounts: updatedList);
    //update the Auth and the simulation Database with the new object user
    //this will trigger rebuild account since its a new object inserted to the state.
    updateAccountFromSession(updatedUser);
  }

  void updateLinkedAccountNameAtIndex(int index, String value) {
    final currentUser = state;

    if (currentUser == null) return;

    final updatedList = List<WaterAccount>.from(currentUser.linkedAccounts);
    updatedList[index] = updatedList[index].copyWith(accountName: value);

    final updatedUser = currentUser.copyWith(linkedAccounts: updatedList);
    updateAccountFromSession(updatedUser);
  }

  void removeAccountAtIndex(int index) {
    final currentUser = state;

    //guard clause
    if (currentUser == null) return;

    //guard clause - aborts the method if the index reached -1 or above the length of the list
    if (index < 0 || index >= currentUser.linkedAccounts.length) return;

    final updatedList = List<WaterAccount>.from(currentUser.linkedAccounts);
    updatedList.removeAt(index);

    final updatedUser = currentUser.copyWith(linkedAccounts: updatedList);
    updateAccountFromSession(updatedUser);
  }

  void addLinkedAccount(WaterAccount waterAccount) {
    final currentUser = state;

    if (currentUser == null) return;

    final updatedList = List<WaterAccount>.from(currentUser.linkedAccounts)
      ..add(waterAccount);

    final updatedUser = currentUser.copyWith(linkedAccounts: updatedList);
    updateAccountFromSession(updatedUser);
  }

  void updateAccountFromSession(UserAccount updatedUser) {
    if (state == null) return;
    state = updatedUser;

    ref
        .read(accountNotifierProvider.notifier)
        .updateAccountFromDatabase(updatedUser);
  }
}

final authNotifierProvider = NotifierProvider<AuthNotifier, UserAccount?>(
  () => AuthNotifier(),
);

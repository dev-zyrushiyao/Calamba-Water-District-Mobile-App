import 'package:myapp/models/constants/chat_role_enum.dart';
import 'package:myapp/models/constants/gender_enum.dart';
import 'package:myapp/models/user_account.dart';
import 'package:myapp/models/water_account.dart';
import 'package:myapp/providers/account_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  UserAccount? build() {
    return UserAccount(
      nickname: 'Zy',
      phoneNumber: 09151234567,
      gender: Gender.male,
      email: 'zyrus@example.com',
      password: '1234567890',
      ewallet: 639123456789,
      chatRole: ChatRole.client,
      linkedAccounts: [],
    );
    // return null;
  }

  bool login(String email, String password) {
    final user = ref
        .read(accountProvider.notifier)
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

    ref.read(accountProvider.notifier).updateAccountFromDatabase(updatedUser);
  }
}

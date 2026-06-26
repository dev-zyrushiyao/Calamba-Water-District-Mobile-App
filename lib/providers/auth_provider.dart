import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/data-class/constants/gender_enum.dart';
import 'package:myapp/data-class/user_account.dart';
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

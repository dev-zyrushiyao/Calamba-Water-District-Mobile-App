import 'package:myapp/data-class/user_account.dart';
import 'package:myapp/data-class/constants/enums.dart';

class AccountType {
  // static const profileImage = gender[0]
  //     ? 'assets/avatar/male.png'
  //     : 'assets/avatar/female.png';

  UserAccount owner = UserAccount(
    'Zy',
    123456789,
    Gender.female,
    'myemail@email.com',
    'password1234',
    12344321,
    [],
  );
}

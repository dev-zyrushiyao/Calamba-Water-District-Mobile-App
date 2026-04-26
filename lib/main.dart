import 'package:flutter/material.dart';
import 'package:myapp/pages/01-login/login_page.dart';
import 'package:myapp/pages/02-signup/signup_page.dart';
import 'package:myapp/pages/02-signup/account_verification_page.dart';
import 'package:myapp/pages/02-signup/register_result_page.dart';
import 'package:myapp/pages/03-forgot-password/forgot_password_page.dart';
import 'package:myapp/pages/03-forgot-password/recovery_result_page.dart';
import 'package:myapp/pages/04-on-boarding/boarding_page_one.dart';
import 'package:myapp/design-system/design_system.dart';
import 'package:myapp/pages/home_page.dart';

void main() {
  //RunApp calling the myApp Class
  runApp(const MyApp());
}

//myApp - calling widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Figma Design System
    final DesignSystem designSystem = DesignSystem();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: designSystem.cwdThemeColor().surface,
          foregroundColor: designSystem.cwdThemeColor().onPrimary,
          scrolledUnderElevation: 4.0,
          shadowColor: designSystem.cwdThemeColor().primary,
          surfaceTintColor: designSystem.cwdThemeColor().primary,
        ),
        useMaterial3: true,
        textTheme: designSystem.cwdTypography(
          designSystem.primaryFont,
          designSystem.secondaryFont,
        ),
        colorScheme: designSystem.cwdThemeColor(),
      ),
      initialRoute: '/home',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/accountverification': (context) => const AccountVerificationPage(),
        '/signupresult': (context) => const RegisterResultPage(),
        '/forgotpassword': (context) => const ForgotPasswordPage(),
        '/forgotpasswordresult': (context) => const RecoveryResultPage(),
        '/boarding_page_one': (context) => const BoardingPageOne(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}

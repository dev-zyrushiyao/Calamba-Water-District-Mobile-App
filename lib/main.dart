import 'package:flutter/material.dart';
import 'package:myapp/pages/account_verification_page.dart';
import 'design-system/design_system.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';

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
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/accountverification': (context) => const AccountVerificationPage(),
      },
    );
  }
}

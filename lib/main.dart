import 'package:flutter/material.dart';
import 'design_system.dart';
import 'login_page.dart';
import 'signup_page.dart';

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

    //Pages
    //LoginPage();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFE0E1FE),
          foregroundColor: designSystem.cwdThemeColor().onPrimary,
        ),
        useMaterial3: true,
        textTheme: designSystem.cwdTypography(
          designSystem.primaryFont,
          designSystem.secondaryFont,
        ),
        colorScheme: designSystem.cwdThemeColor(),
      ),
      home: LoginPage(),

      routes: {'/signup': (context) => const SignupPage()},
    );
  }
}

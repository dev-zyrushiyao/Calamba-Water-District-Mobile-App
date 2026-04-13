import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          backgroundColor: designSystem.cwdThemeColor().surface,
          foregroundColor: designSystem.cwdThemeColor().onPrimary,
          scrolledUnderElevation: 4.0,
          shadowColor: designSystem.cwdThemeColor().primary,
          surfaceTintColor: designSystem.cwdThemeColor().primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.directional(
              bottomStart: Radius.circular(15.0),
              bottomEnd: Radius.circular(15.0),
            ),
          ),
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

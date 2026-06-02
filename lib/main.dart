import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:myapp/pages/01-login/login_page.dart';
import 'package:myapp/pages/02-signup/signup_page.dart';
import 'package:myapp/pages/02-signup/account_verification_page.dart';
import 'package:myapp/pages/02-signup/register_result_page.dart';
import 'package:myapp/pages/03-forgot-password/forgot_password_page.dart';
import 'package:myapp/pages/03-forgot-password/recovery_result_page.dart';
import 'package:myapp/pages/04-on-boarding/boarding_page.dart';
import 'package:myapp/design-system/design_system.dart';
import 'package:myapp/pages/05-home-page/home_page.dart';
import 'package:myapp/pages/05-home-page/index/account/account_information_page.dart';
import 'package:myapp/pages/05-home-page/index/account/billing_content_page.dart';
import 'package:myapp/pages/05-home-page/index/account/billing_page.dart';
import 'package:myapp/pages/05-home-page/index/account/link_account_page.dart';
import 'package:myapp/pages/05-home-page/index/account/payment_confirmation.dart';
import 'package:myapp/pages/05-home-page/index/account/payment_page.dart';
import 'package:myapp/pages/05-home-page/index/account/payment_result_page.dart';
import 'package:myapp/pages/05-home-page/index/account/receipt_content_page.dart';
import 'package:myapp/pages/05-home-page/index/account/receipt_page.dart';
import 'package:myapp/pages/05-home-page/index/account/ticket_content.dart';
import 'package:myapp/pages/05-home-page/index/account/ticket_page.dart';
import 'package:myapp/pages/05-home-page/index/news_content_page.dart';
import 'package:myapp/pages/05-home-page/index/support/support_email_result_page.dart';
import 'package:myapp/pages/05-home-page/index/support/support_index.dart';
import 'package:myapp/pages/05-home-page/index/support/support_result_page.dart';

void main() async {
  // 1. Mandatory for native platform calls before runApp
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Lock the orientation to portrait
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
    final designSystemColor = designSystem.themeColor();
    final designSystemTypography = designSystem.themeTypography();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: designSystemColor.surface,
          foregroundColor: designSystemColor.onPrimary,
          scrolledUnderElevation: 4.0,
          shadowColor: designSystemColor.primary,
          surfaceTintColor: designSystemColor.primary,
        ),
        useMaterial3: true,
        textTheme: designSystemTypography,
        colorScheme: designSystemColor,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        //Sign up page
        '/signup': (context) => const SignupPage(),
        '/accountverification': (context) => const AccountVerificationPage(),
        '/signupresult': (context) => const RegisterResultPage(),
        //Forgot password page
        '/forgotpassword': (context) => const ForgotPasswordPage(),
        '/forgotpasswordresult': (context) => const RecoveryResultPage(),
        //Boarding page
        '/boarding': (context) => const BoardingPageOne(),
        //Home Index
        '/home': (context) => const HomePage(),
        //News Index
        '/newscontent': (context) => const NewsContentPage(),
        //Account Index
        '/linkaccount': (context) => const LinkAccountPage(),
        '/accountinformation': (context) => const AccountInformationPage(),
        '/billing': (context) => const BillingPage(),
        '/billingcontent': (context) => const BillingContentPage(),
        '/receipt': (context) => const ReceiptPage(),
        '/receiptcontent': (context) => const ReceiptContentPage(), //pending
        '/payment': (context) => const PaymentPage(),
        '/paymentconfirmation': (context) => PaymentConfirmation(),
        '/paymentresult': (context) => const PaymentResultPage(),
        '/ticket': (context) => const TicketPage(),
        '/ticketcontent': (context) => const TicketContent(),
        //Support Index
        '/support': (context) => const SupportIndex(),
        '/supportresult': (context) => const SupportResultPage(),
        '/supportemailresult': (context) => const SupportEmailResultPage(),
      },
    );
  }
}

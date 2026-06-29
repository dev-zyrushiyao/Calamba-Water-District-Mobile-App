import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/data-class/news_information.dart';
import 'package:myapp/data-class/ticket.dart';
import 'package:myapp/data-class/user_account.dart';
import 'package:myapp/pages/00-How-to/get_started_page.dart';
import 'package:myapp/pages/00-How-to/guide_page.dart';

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
import 'package:myapp/pages/05-home-page/index/news/news_content_page.dart';
import 'package:myapp/pages/05-home-page/index/support/support_email_result_page.dart';
import 'package:myapp/pages/05-home-page/index/support/support_result_page.dart';

void main() async {
  // 1. Mandatory for native platform calls before runApp
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Lock the orientation to portrait
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //RunApp calling the myApp Class
  runApp(const ProviderScope(child: CalambaWaterDistrict()));
}

//myApp - calling widget
class CalambaWaterDistrict extends StatelessWidget {
  const CalambaWaterDistrict({super.key});

  //router

  @override
  Widget build(BuildContext context) {
    //Figma Design System
    final designSystem = DesignSystem();
    final designSystemColor = designSystem.themeColor();
    final designSystemTypography = designSystem.themeTypography();

    return MaterialApp.router(
      title: 'Calamba Water District Unofficial Demo App',
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
      routerConfig: _router,
    );
  }
}

//Go Router Config
//Indexes doesnt have GoRoute as its handled by BottomNavigationBar of HomePage() /home
final _router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    // Intro - Child Route
    GoRoute(
      path: '/getstarted',
      builder: (context, state) => const GetStartedPage(),
      routes: [
        GoRoute(path: 'guide', builder: (context, state) => const GuidePage()),
      ],
    ),

    // Authentication - Child Route
    GoRoute(
      path: '/', // Kept as /login to match your redirect logic
      builder: (context, state) => const LoginPage(),
      routes: [
        //Sign up
        GoRoute(
          path: 'signup',
          builder: (context, state) => const SignupPage(),
          routes: [
            GoRoute(
              path: 'accountverification',
              builder: (context, state) {
                final data = state.extra as UserAccount?;

                return AccountVerificationPage(newUser: data);
              },
              routes: [
                GoRoute(
                  path: 'result',
                  builder: (context, state) => const RegisterResultPage(),
                ),
              ],
            ),
          ],
        ),
        // Forgot Password
        GoRoute(
          path: 'forgotpassword',
          builder: (context, state) => const ForgotPasswordPage(),
          routes: [
            GoRoute(
              path: 'recovery',
              builder: (context, state) {
                final data = state.extra as String?;

                return RecoveryResultPage(emailToReset: data);
              },
            ),
          ],
        ),
        //boarding
        GoRoute(
          path: '/boarding',
          builder: (context, state) => const BoardingPageOne(),
        ),
      ],
    ),

    // Home (indexes) & Core Content
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'accountinformation',
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>?;
            return AccountInformationPage(linkedAccountData: data);
          },
        ),
      ],
    ),

    //Link account section
    GoRoute(
      path: '/linkaccount',
      builder: (context, state) => const LinkAccountPage(),
    ),

    //News section
    GoRoute(
      path: '/newscontent',
      builder: (context, state) {
        final data = state.extra as NewsInformation?;

        return NewsContentPage(newsInformation: data);
      },
    ),

    //Payment section
    GoRoute(
      path: '/payment',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>?;
        return PaymentPage(linkedAccountData: data);
      },
      routes: [
        GoRoute(
          path: 'paymentconfirmation',
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>?;
            return PaymentConfirmation(paymentData: data);
          },
          routes: [
            GoRoute(
              path: 'paymentresult',
              builder: (context, state) {
                final data = state.extra as Map<String, dynamic>?;
                return PaymentResultPage(receiptData: data);
              },
            ),
          ],
        ),
      ],
    ),

    //Bill section
    GoRoute(
      path: '/billing',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>?;

        return BillingPage(linkedAccountData: data);
      },
      routes: [
        GoRoute(
          path: 'billcontent',
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>?;

            return BillingContentPage(billData: data);
          },
        ),
      ],
    ),

    //Receipt section
    GoRoute(
      path: '/receipt',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return ReceiptPage(linkedAccountData: data);
      },
      routes: [
        GoRoute(
          path: 'receiptcontent',
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;
            return ReceiptContentPage(receiptData: data);
          },
        ),
      ],
    ),

    // Tickets
    GoRoute(
      path: '/ticket',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>?;
        return TicketPage(ticketData: data);
      },
      routes: [
        GoRoute(
          path: 'ticketcontent',
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;
            return TicketContent(ticketData: data);
          },
        ),
      ],
    ),

    GoRoute(
      path: '/supportresult',
      builder: (context, state) {
        final data = state.extra as Ticket?;
        return SupportResultPage(supportTicket: data);
      },
    ),

    GoRoute(
      path: '/supportemailresult',
      builder: (context, state) {
        final data = state.extra as int?;

        return SupportEmailResultPage(supportTicket: data);
      },
    ),
  ],
);

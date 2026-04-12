import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'DesignSystem.dart';

void main() {
  //RunApp calling the myApp Class
  runApp(const MyApp());
}

//myApp - calling widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //added Design Systen Class instance
    //from import 'DesignSystem.dart';
    final DesignSystem designSystem = DesignSystem();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: designSystem.cwdTypography(
          designSystem.primaryFont,
          designSystem.secondaryFont,
        ),
        colorScheme: designSystem.cwdThemeColor(),
      ),

      home: const MyWidget(),
    );
  }
}

//home-widget
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

//login page
class _MyWidgetState extends State<MyWidget> {
  //controller variable
  final TextEditingController _textController = TextEditingController();
  bool isHidden = true;

  //login textbox consistent size
  static const double _textFieldWidth = 288.00;
  static const double _textFieldHeight = 56.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        //Logo Email & Password TextField
        child: Container(
          padding: const EdgeInsetsDirectional.only(top: 50.00),
          color: Theme.of(context).colorScheme.surface,
          height: double.infinity,
          child: Center(
            child: Column(
              spacing: 27.00,
              mainAxisAlignment: MainAxisAlignment.center,
              children: ([
                //logo
                SvgPicture.asset(
                  semanticsLabel: 'Calamba Water District Logo',
                  fit: BoxFit.contain,
                  'assets/login-logo.svg',
                ),

                SizedBox(
                  width: _textFieldWidth,
                  height: _textFieldHeight,
                  child: TextField(
                    style: Theme.of(context).textTheme.bodyLarge,
                    keyboardType: TextInputType.emailAddress,
                    controller: _textController,
                    decoration: InputDecoration(
                      label: Text('E-Mail'),
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.email_outlined),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _textController.clear();
                        },
                        icon: Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),

                //Password TextField
                SizedBox(
                  width: _textFieldWidth,
                  height: _textFieldHeight,
                  child: TextField(
                    style: Theme.of(context).textTheme.bodyLarge,
                    obscureText: isHidden,
                    decoration: InputDecoration(
                      // border: OutlineInputBorder(),
                      label: Text('Password'),
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (isHidden == true) {
                              isHidden = false;
                            } else {
                              isHidden = true;
                            }
                          });
                        },
                        icon: Icon(
                          isHidden ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                ),

                //Forgot Password Text
                SizedBox(
                  width: _textFieldWidth,
                  child: Text(
                    textAlign: TextAlign.right,

                    //Custom TextStyle for 'Forgot Password?' link
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.00,
                      fontFamily: DesignSystem().primaryFont.fontFamily,
                    ),

                    'Forgot Password?',
                  ),
                ),

                SizedBox(height: 5.0),

                //login CTA
                SizedBox(
                  height: 60,
                  width: _textFieldWidth,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.secondaryContainer,
                      foregroundColor: Theme.of(
                        context,
                      ).colorScheme.onSecondary,
                      textStyle: Theme.of(context).textTheme.labelLarge,
                      elevation: 8.0,
                      shadowColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(4.0),
                        ),
                      ),
                    ),
                    child: Text('Login'),
                  ),
                ),

                //other methods
                SizedBox(
                  width: _textFieldWidth,
                  child: Column(
                    spacing: 20,
                    children: [
                      //Divider '------OR------'
                      Row(
                        spacing: 13.0,
                        children: [
                          Expanded(
                            child: Divider(
                              color: Color(0xFF6C6C6C),
                              thickness: 2.0, // Height of the line
                            ),
                          ),
                          Text(
                            style: TextStyle(
                              color: Color(0xFF6C6C6C),
                              fontSize: 13.00,
                              fontFamily: DesignSystem().primaryFont.fontFamily,
                              letterSpacing: DesignSystem()
                                  .letterSpacingConverter(13.00, 1.5),
                            ),
                            'OR',
                          ),
                          Expanded(
                            child: Divider(
                              color: Color(0xFF6C6C6C),
                              thickness: 2.0, // Height of the line
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //other-method sign in
                Column(
                  spacing: 18.0,
                  children: [
                    //Sign-in with Google
                    SizedBox(
                      width: _textFieldWidth,
                      height: 46,
                      child: Center(
                        child: FilledButton.icon(
                          onPressed: () {},
                          label: Text('Sign in with Google'),
                          icon: Image.asset(
                            height: 24,
                            width: 24,
                            semanticLabel: 'Google Logo',
                            'assets/mobile-app/signin-assets/google logo.png',
                          ),
                          style: FilledButton.styleFrom(
                            backgroundColor: Color(0xFFFFFFFF),
                            textStyle: GoogleFonts.lexend(
                              fontSize: 14.00,
                              fontWeight: FontWeight.normal,
                            ),
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.onPrimary,
                            minimumSize: const Size(284, 46),
                            padding: EdgeInsets.only(right: 0.00),
                            side: BorderSide(
                              color: Color(0xFF747775),
                              width: 1.0,
                              style: BorderStyle.solid,
                              strokeAlign: BorderSide.strokeAlignInside,
                            ),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.all(
                                Radius.circular(4.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Sign-in with Facebook
                    SizedBox(
                      width: _textFieldWidth,
                      height: 46,
                      child: Center(
                        child: FilledButton.icon(
                          onPressed: () {},
                          label: const Text('Sign in with Facebook'),
                          icon: Image.asset(
                            width: 24.0,
                            height: 24.0,
                            semanticLabel: 'Facebook Logo',
                            'assets/mobile-app/signin-assets/250px-2023_Facebook_icon.png',
                          ),
                          style: FilledButton.styleFrom(
                            backgroundColor: Color(0xFFFFFFFF),
                            textStyle: GoogleFonts.outfit(
                              fontSize: 14.00,
                              fontWeight: FontWeight.normal,
                            ),
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.onPrimary,
                            minimumSize: const Size(284, 46),
                            side: BorderSide(
                              color: Color(0xFF747775),
                              width: 1.0,
                              style: BorderStyle.solid,
                              strokeAlign: BorderSide.strokeAlignInside,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.all(
                                Radius.circular(4.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    style: Theme.of(context).textTheme.labelSmall,
                    children: <TextSpan>[
                      TextSpan(
                        style: TextStyle(color: Color(0xFF5E5E5E)),
                        text: 'Don’t have account?',
                      ),
                      TextSpan(text: '  '),
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outlineVariant,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

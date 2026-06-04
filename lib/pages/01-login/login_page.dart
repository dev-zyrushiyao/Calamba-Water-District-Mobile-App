import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/custom-widgets/secondary_button.dart';
import 'package:myapp/data-bank/account_collection.dart';
import 'package:myapp/data-bank/account_type.dart';
import 'package:myapp/data-class/user_account.dart';
import '../../design-system/design_system.dart'; //home-widget

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

//login page
class _LoginPageState extends State<LoginPage> {
  //controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //Password character
  bool _isHidden = true;

  //Account simulation DB
  final AccountCollection _accountCollection = AccountCollection();
  final AccountType _accountType = AccountType();

  //validation
  bool? _isCorrectLogin;

  //login textbox consistent size
  final double _textFieldWidth = 288.00;
  final double _textFieldHeight = 56.00;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> loggedTheUser(UserAccount account) async {
    //Direct change values
    _accountType.owner.nickname = account.nickname;
    _accountType.owner.phoneNumber = account.phoneNumber;
    _accountType.owner.gender = account.gender;
    _accountType.owner.email = account.email;
    _accountType.owner.password = account.password;
    _accountType.owner.ewallet = account.ewallet;
    _accountType.owner.linkedAccounts = account.linkedAccounts;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        //Logo Email & Password TextField
        child: Container(
          padding: const EdgeInsetsDirectional.only(top: 50.00),
          color: theme.colorScheme.surface,
          height: deviceHeight,
          width: deviceWidth,
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

                if (_isCorrectLogin != null)
                  if (_isCorrectLogin != true)
                    Text(
                      'Login information is incorrect',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.red,
                      ),
                    ),

                _buildEmailField(theme, _emailController),

                _buildPasswordField(theme, _passwordController),

                //Forgot Password Text
                SizedBox(
                  width: _textFieldWidth,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/forgotpassword');
                    },
                    child: _buildForgotPasswordText(theme),
                  ),
                ),

                //login CTA
                SecondaryButton(
                  label: 'Login',
                  height: _textFieldHeight,
                  width: _textFieldWidth,
                  onPressed: () async {
                    if (_accountCollection.accountDb.isEmpty) {
                      debugPrint('the DB is empty');
                      //display a incorrect login if there is no registered account
                      setState(() {
                        _isCorrectLogin = false;
                      });
                    } else {
                      for (var account in _accountCollection.accountDb) {
                        if ((account.email == _emailController.text) &&
                            (account.password == _passwordController.text)) {
                          setState(() {
                            _isCorrectLogin = true;
                          });

                          await loggedTheUser(account);

                          await Future.delayed(Duration(milliseconds: 500), () {
                            if (!context.mounted) return;
                            FocusScope.of(context).unfocus();
                          });

                          if (!context.mounted) return;
                          Navigator.popAndPushNamed(context, '/boarding');
                          break;
                        } else {
                          setState(() {
                            _isCorrectLogin = false;
                          });
                        }
                      }
                    }
                  },
                ),

                _buildLoginDivider(theme),

                //other-method sign in
                Column(
                  spacing: 18.0,
                  children: [
                    _buildGoogleButton(theme),
                    _buildFacebookButton(theme),
                  ],
                ),

                const SizedBox(height: 10),

                _buildSignupTextSpan(theme),

                Column(
                  children: [
                    const Text('Version 1.0.0'),
                    const Text(
                      'Developed by Zyrus Hiyao',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupTextSpan(ThemeData theme) {
    return Text.rich(
      TextSpan(
        style: theme.textTheme.labelSmall,
        children: <TextSpan>[
          const TextSpan(
            style: TextStyle(color: Color(0xFF5E5E5E)),
            text: 'Don’t have account?',
          ),
          const TextSpan(text: '  '),
          TextSpan(
            style: TextStyle(
              color: theme.colorScheme.outlineVariant,
              fontWeight: FontWeight.w900,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, '/signup');
              },
            text: 'Sign Up',
          ),
        ],
      ),
    );
  }

  Widget _buildFacebookButton(ThemeData theme) {
    return SizedBox(
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
            backgroundColor: const Color(0xFFFFFFFF),
            textStyle: GoogleFonts.outfit(
              fontSize: 14.00,
              fontWeight: FontWeight.normal,
            ),
            foregroundColor: theme.colorScheme.onPrimary,
            minimumSize: const Size(284, 46),
            side: const BorderSide(
              color: Color(0xFF747775),
              width: 1.0,
              style: BorderStyle.solid,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(4.0)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleButton(ThemeData theme) {
    return SizedBox(
      width: _textFieldWidth,
      height: 46,
      child: Center(
        child: FilledButton.icon(
          onPressed: () {},
          label: const Text('Sign in with Google'),
          icon: Image.asset(
            height: 24,
            width: 24,
            semanticLabel: 'Google Logo',
            'assets/mobile-app/signin-assets/google logo.png',
          ),
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFFFFFFFF),
            textStyle: GoogleFonts.lexend(
              fontSize: 14.00,
              fontWeight: FontWeight.normal,
            ),
            foregroundColor: theme.colorScheme.onPrimary,
            minimumSize: const Size(284, 46),
            padding: const EdgeInsets.only(right: 0.00),
            side: const BorderSide(
              color: Color(0xFF747775),
              width: 1.0,
              style: BorderStyle.solid,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(4.0)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginDivider(ThemeData theme) {
    return //other methods
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
                  color: theme.colorScheme.onPrimaryFixedVariant,
                  thickness: 2.0, // Height of the line
                ),
              ),
              Text(
                style: theme.textTheme.labelSmall!.copyWith(
                  color: theme.colorScheme.onPrimaryFixedVariant,
                ),
                'OR',
              ),
              Expanded(
                child: Divider(
                  color: theme.colorScheme.onPrimaryFixedVariant,
                  thickness: 2.0, // Height of the line
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordText(ThemeData theme) {
    return Text(
      textAlign: TextAlign.right,
      //Custom TextStyle for 'Forgot Password?' link
      style: TextStyle(
        color: theme.colorScheme.outlineVariant,
        fontWeight: FontWeight.bold,
        fontSize: 15.00,
        fontFamily: DesignSystem().primaryFont.fontFamily,
      ),
      'Forgot Password?',
    );
  }

  Widget _buildPasswordField(
    ThemeData theme,
    TextEditingController controller,
  ) {
    return SizedBox(
      width: _textFieldWidth,
      height: _textFieldHeight,
      child: TextFormField(
        style: theme.textTheme.bodyLarge,
        obscureText: _isHidden,
        controller: controller,
        decoration: InputDecoration(
          label: const Text('Password'),
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                if (_isHidden == true) {
                  _isHidden = false;
                } else {
                  _isHidden = true;
                }
              });
            },
            icon: Icon(_isHidden ? Icons.visibility_off : Icons.visibility),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(ThemeData theme, TextEditingController controller) {
    return SizedBox(
      width: _textFieldWidth,
      height: _textFieldHeight,
      child: TextFormField(
        style: theme.textTheme.bodyLarge,
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        decoration: InputDecoration(
          label: const Text('E-Mail'),
          hintText: 'Enter your email',
          prefixIcon: const Icon(Icons.email_outlined),
          suffixIcon: IconButton(
            onPressed: () {
              controller.clear();
            },
            icon: const Icon(Icons.clear),
          ),
        ),
      ),
    );
  }
}

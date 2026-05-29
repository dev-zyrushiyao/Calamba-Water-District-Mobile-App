import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

//Widget tree structure
//Scaffold
//-Appbar
//--Column [sizedBox , container-TextHeader , sizedBox , center-container-Column(Column[Label,TextForm)) ]
// Mobile no. section container-column (text (row[text-textfield]))

class _SignupPageState extends State<SignupPage> {
  bool _isHidden = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic> registeredForm = {
    'nickname': null,
    'email': null,
    'password': null,
    'phoneNumber': null,
    'ewallet': null,
  };

  String? _nicknameValidator(String? value) {
    return (value != null && value.contains(RegExp(r'[0-9!@#$%^&*()]')))
        ? 'Invalid character '
        : null;
  }

  String? _emailValidator(String? value) {
    //r'''^[!@#$%^&*()_\-+~`\[\]|;:{}'" <>?,./\\]''', including <space>
    final RegExp specialCharacter = RegExp(r'[\s!-/:-@\[-`{-~]');

    //[underscore , @ and dot] not included
    //r'''[!#$%^&*()\-+~`\[\]|;:{}'" <>?,/\\]''',
    final RegExp specialCharacterWithException = RegExp(r'[\s!-\-/:-?\[-^`|~]');

    return (value == null || value.isEmpty)
        ? 'Email is required'
        : (value.startsWith(specialCharacter))
        ? 'Invalid email: cannot start with special character'
        : (value.contains(specialCharacterWithException))
        ? 'Invalid character detected'
        : (!value.contains('@'))
        ? 'Email require @ symbol'
        : (value.endsWith('.com')) || (value.endsWith('.ph'))
        ? null
        : 'Invalid Email format';
  }

  String? _passwordValidator(String? value) {
    return (value == null || value.isEmpty)
        ? 'Password is required'
        : (value.contains(RegExp(r'[\s]')))
        ? 'Password Should not include <white space>'
        : (value.length < 10)
        ? 'Not enough password character'
        : null;
  }

  String? _phoneNumberValidator(String? value) {
    return (value != null && value.length < 11)
        ? 'Invalid number'
        : value!.contains(RegExp(r'^09\d{9}$'))
        ? null
        : 'Please put your 11 digit mobile number';
  }

  String? _eWalletValidator(String? value) {
    return (value == null || value.isEmpty)
        ? 'Please add E-Wallet account'
        : (value.length == 12 &&
              value.contains(RegExp(r'[0-9]')) &&
              (value.contains(RegExp(r'^639\d{9}$'))))
        ? null
        : 'Invalid format (needs Area Code without the \'+\' and 11 digit mobile number)';
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(title: const Text('Sign up')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
        children: [
          //spacing
          const SizedBox(height: 10),

          //header text
          const Headline(
            headline: 'Create Account',
            subHeadline: 'Sign up to get started',
          ),

          //spacing
          const SizedBox(height: 42),

          //Form
          Form(
            key: _formKey,
            child: Container(
              width: 356.0,
              padding: const EdgeInsets.symmetric(horizontal: 30.00),
              child: Column(
                spacing: 35.00,
                children: [
                  //nickname
                  _buildTextField(
                    title: 'Nickname',
                    textInputType: TextInputType.name,
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'Enter your nickname',
                    maxLength: 15,
                    validator: (value) {
                      return _nicknameValidator(value);
                    },
                    onSaved: (value) => registeredForm['nickname'] = value,
                    theme: theme,
                  ),

                  _buildTextField(
                    title: 'Email',
                    textInputType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.mail),
                    hintText: 'Enter valid E-mail',
                    maxLength: 30,
                    validator: (value) {
                      return _emailValidator(value);
                    },
                    onSaved: (value) => registeredForm['email'] = value,
                    theme: theme,
                  ),

                  _buildTextField(
                    title: 'Password',
                    textInputType: TextInputType.visiblePassword,
                    obscureText: _isHidden,
                    maxLength: 30,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isHidden ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isHidden = !_isHidden;
                        });
                      },
                    ),
                    hintText: 'Enter password',
                    validator: (value) {
                      return _passwordValidator(value);
                    },
                    onSaved: (value) => registeredForm['password'] = value,
                    theme: theme,
                  ),

                  _buildTextField(
                    title: 'Mobile No.',
                    textInputType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    prefixIcon: const Icon(Icons.phone_android),
                    hintText: '09123456789',
                    maxLength: 11,
                    validator: (value) {
                      return _phoneNumberValidator(value);
                    },
                    onSaved: (value) =>
                        registeredForm['phoneNumber'] = int.tryParse(value!),
                    theme: theme,
                  ),

                  _buildTextField(
                    title: 'E-Wallet.',
                    textInputType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    prefixIcon: const Icon(Icons.credit_card),
                    hintText: '639123456789',
                    maxLength: 12,
                    validator: (value) {
                      return _eWalletValidator(value);
                    },
                    onSaved: (value) =>
                        registeredForm['ewallet'] = int.tryParse(value!),
                    theme: theme,
                  ),

                  PrimaryButton(
                    label: 'Create Account',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.pushNamed(
                          context,
                          '/accountverification',
                          arguments: registeredForm,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          //spacing
          SizedBox(height: 28),

          //other methods
          SizedBox(
            width: 288.00,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: _buildDivider(theme),
            ),
          ),

          SizedBox(height: 13),

          Align(
            alignment: Alignment.center,
            child: Text(
              'Sign up with',
              style: TextStyle(color: Color(0xFF747775)),
            ),
          ),

          SizedBox(height: 13),

          Center(
            child: Wrap(
              spacing: 18,
              children: [
                _buildGoogleButton(theme),
                _buildFacebookButton(theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(ThemeData theme) {
    return Column(
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
    );
  }

  Widget _buildFacebookButton(ThemeData theme) {
    return SizedBox(
      width: 167.5,
      height: 46,
      child: FilledButton.icon(
        onPressed: () {},
        label: const Text('Facebook'),
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
          foregroundColor: theme.colorScheme.onPrimary,
          minimumSize: const Size(284, 46),
          side: BorderSide(
            color: Color(0xFF747775),
            width: 1.0,
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(4.0)),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleButton(ThemeData theme) {
    return SizedBox(
      width: 167.5,
      height: 46,
      child: FilledButton.icon(
        onPressed: () {},
        label: Text('Google'),
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
          foregroundColor: theme.colorScheme.onPrimary,
          minimumSize: const Size(284, 46),
          padding: EdgeInsets.only(right: 0.00),
          side: BorderSide(
            color: Color(0xFF747775),
            width: 1.0,
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(4.0)),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String title,
    TextInputType? textInputType,
    bool obscureText = false,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? hintText,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    Function(String? value)? onSaved,
    String? Function(String? value)? validator,
    required ThemeData theme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          style: theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
          title,
        ),
        TextFormField(
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          keyboardType: textInputType,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            counterStyle: theme.textTheme.labelSmall,
            errorMaxLines: 2,
            hintStyle: TextStyle(
              color: theme.colorScheme.onPrimaryFixedVariant,
            ),
            errorStyle: theme.textTheme.labelSmall!.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
          onSaved: onSaved,
          maxLength: maxLength,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
        ),
      ],
    );
  }
}

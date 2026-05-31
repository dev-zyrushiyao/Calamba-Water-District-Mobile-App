import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/data-class/constants/gender_enum.dart';

import 'package:myapp/services/validator_service.dart';

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
  //service
  final ValidatorService _validatorService = ValidatorService();

  //boolean trigger for obscure text
  bool _isHidden = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _registeredForm = {
    'nickname': null,
    'email': null,
    'gender': null,
    'password': null,
    'phoneNumber': null,
    'ewallet': null,
  };

  final List<DropdownMenuItem<Gender>> _dropdownItems = [];

  @override
  void initState() {
    super.initState();
    _addDropdown();
  }

  void _addDropdown() {
    for (var item in Gender.values) {
      _dropdownItems.add(
        DropdownMenuItem(value: item, child: Text(item.value)),
      );
    }
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
                      return _validatorService.nicknameValidator(value);
                    },
                    onSaved: (value) => _registeredForm['nickname'] = value,
                    theme: theme,
                  ),

                  _buildTextField(
                    title: 'Email',
                    textInputType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.mail),
                    hintText: 'Enter valid E-mail',
                    maxLength: 30,
                    validator: (value) {
                      return _validatorService.emailValidator(value);
                    },
                    onSaved: (value) => _registeredForm['email'] = value,
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
                      return _validatorService.passwordValidator(value);
                    },
                    onSaved: (value) => _registeredForm['password'] = value,
                    theme: theme,
                  ),

                  _buildDropdown(theme),

                  _buildTextField(
                    title: 'Mobile No.',
                    textInputType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    prefixIcon: const Icon(Icons.phone_android),
                    hintText: '09123456789',
                    maxLength: 11,
                    validator: (value) {
                      return _validatorService.phoneNumberValidator(value);
                    },
                    onSaved: (value) =>
                        _registeredForm['phoneNumber'] = int.tryParse(value!),
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
                      return _validatorService.eWalletValidator(value);
                    },
                    onSaved: (value) =>
                        _registeredForm['ewallet'] = int.tryParse(value!),
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
                          arguments: _registeredForm,
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

  Widget _buildDropdown(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          style: theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
          'Gender',
        ),
        DropdownButtonFormField(
          items: _dropdownItems,
          onChanged: (_) {},
          decoration: InputDecoration(
            errorStyle: theme.textTheme.labelSmall?.copyWith(color: Colors.red),
          ),
          validator: (value) {
            return _validatorService.genderValidator(value);
          },
          onSaved: (value) => _registeredForm['gender'] = value,
        ),
      ],
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
          autovalidateMode: AutovalidateMode.onUserInteractionIfError,
          validator: validator,
        ),
      ],
    );
  }
}

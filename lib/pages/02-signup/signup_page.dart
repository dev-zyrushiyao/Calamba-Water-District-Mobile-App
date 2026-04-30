import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: Text('Sign up')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          //spacing
          SizedBox(height: 29),

          //header text
          Headline(
            headline: 'Create Account',
            subHeadline: 'Sign up to get started',
          ),

          //spacing
          SizedBox(height: 42),

          //Form
          Container(
            width: 356.0,
            padding: const EdgeInsets.symmetric(horizontal: 30.00),
            child: Column(
              spacing: 35.00,
              children: [
                //TextField-Nickname
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      'Nickname',
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        helperText: 'Please input alphabet characters only',
                        helperStyle: Theme.of(context).textTheme.labelSmall,
                        hintText: 'Enter your nickname',
                        hintStyle: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryFixedVariant,
                        ),

                        //error style for validator property (InputDecoration)
                        errorStyle: Theme.of(context).textTheme.labelSmall!
                            .copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      ),
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      maxLength: 15,
                      enableSuggestions: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        return (value != null &&
                                value.contains(RegExp(r'[0-9!@#$%^&*()]')))
                            ? 'Invalid character '
                            : null;
                      },
                    ),
                  ],
                ),

                //TextField - Email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        helperStyle: Theme.of(context).textTheme.labelSmall,
                        hintText: 'Enter valid E-mail',
                        hintStyle: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryFixedVariant,
                        ),
                        //error style for validator property (InputDecoration)
                        errorStyle: Theme.of(context).textTheme.labelSmall!
                            .copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      ),
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      enableSuggestions: true,
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        //email validation that requires the user to enter a valid email
                        //that contains '@' + '.com' OR '.ph'
                        if (value.contains('@') &&
                            value.endsWith('.com') ^ value.endsWith('.ph')) {
                          return null;
                        } else {
                          return 'Invalid email';
                        }
                      },
                    ),
                  ],
                ),

                //TextField - Password
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isHidden = !_isHidden;
                              debugPrint(_isHidden.toString());
                            });
                          },
                          icon: Icon(
                            _isHidden ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                        helperStyle: Theme.of(context).textTheme.labelSmall,
                        hintText: 'Enter password',
                        hintStyle: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryFixedVariant,
                        ),
                        //error style for validator property (InputDecoration)
                        errorStyle: Theme.of(context).textTheme.labelSmall!
                            .copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      ),
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                    ),
                  ],
                ),

                //TextField - Mobile Number
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 35,
                  children: [
                    Text(
                      'Mobile No.',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      spacing: 20.00,
                      children: [
                        Text(
                          '+63',
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight(700)),
                        ),
                        Flexible(
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              helperStyle: Theme.of(
                                context,
                              ).textTheme.labelSmall!,
                              hintText: '9123456789',
                              hintStyle: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryFixedVariant,
                              ),
                              //error style for validator property (InputDecoration)
                              errorStyle: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                            ),
                            onSaved: (String? value) {
                              // This optional block of code can be used to run
                              // code when the user saves the form.
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                PrimaryButton(
                  label: 'Create Account',
                  onPressed: () =>
                      Navigator.pushNamed(context, '/accountverification'),
                ),
              ],
            ),
          ),

          //spacing
          SizedBox(height: 28),

          //other methods
          SizedBox(
            width: 288.00,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                spacing: 20,
                children: [
                  //Divider '------OR------'
                  Row(
                    spacing: 13.0,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryFixedVariant,
                          thickness: 2.0, // Height of the line
                        ),
                      ),
                      Text(
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryFixedVariant,
                        ),
                        'OR',
                      ),
                      Expanded(
                        child: Divider(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryFixedVariant,
                          thickness: 2.0, // Height of the line
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                SizedBox(
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
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
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

                //Sign-in with Facebook
                SizedBox(
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
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

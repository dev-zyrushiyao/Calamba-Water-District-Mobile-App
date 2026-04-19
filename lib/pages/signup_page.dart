import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';

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
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Sign up'), centerTitle: true),
      body: ListView(
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
                      obscureText: isHidden,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isHidden = !isHidden;
                              debugPrint(isHidden.toString());
                            });
                          },
                          icon: Icon(
                            isHidden ? Icons.visibility_off : Icons.visibility,
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
                  width: 356.00,
                  height: 60,
                  label: 'Create Account',
                  onPressed: () => debugPrint('Pressed from Sign up Page'),
                ),
              ],
            ),
          ),

          //TextField - E-mail
        ],
      ),
    );
  }
}

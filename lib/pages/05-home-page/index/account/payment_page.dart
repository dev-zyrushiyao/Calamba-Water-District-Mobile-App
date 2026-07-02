import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/models/constants/payment_method_enum.dart';
import 'package:myapp/models/user_account.dart';
import 'package:myapp/models/water_account.dart';
import 'package:myapp/providers/auth_provider.dart';

class PaymentPage extends ConsumerStatefulWidget {
  const PaymentPage({super.key, required this.linkedAccountData});

  final Map<String, dynamic>? linkedAccountData;

  @override
  ConsumerState<PaymentPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<PaymentPage> {
  //used for textfield hint
  final String _defaultAmount = '0';
  TextEditingController? _amountController;
  bool isEnabled = false;
  String? inputAmount;

  //form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController?.dispose();
    super.dispose();
  }

  String? _validateAmountTextfield(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please input amount';
    }
    if (value.contains(RegExp(r'^\d*\.?\d*$'))) {
      return null;
    } else {
      return 'Invalid input';
    }
  }

  void _storeValue(String? value) {
    inputAmount = value;
  }

  void _textFieldToggleSwitch(String value) {
    final double? parsedAmount = double.tryParse(value);
    setState(() {
      isEnabled = parsedAmount != null && parsedAmount > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loggedUser = ref.watch(authProvider);

    //Data passed through Account Index to Account InformationPage
    final data = widget.linkedAccountData;

    if (loggedUser == null || data == null) {
      return DisplayNoData();
    }

    final waterAccount = data['waterAccount'] as WaterAccount?;

    if (waterAccount == null) {
      return DisplayNoData();
    }

    final ThemeData theme = Theme.of(context);
    //Philippine Peso sign
    final String currencySign = '\u20B1';

    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: SizedBox(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            const SizedBox(height: 20),
            _buildTextField(waterAccount, currencySign, theme),
            const SizedBox(height: 50),
            _buildPaymentMethod(loggedUser, theme),
            const SizedBox(height: 60),

            _buildBigbox(theme),
            const SizedBox(height: 25),
            PrimaryButton(
              label: 'Proceed',
              width: double.infinity,
              onPressed: isEnabled
                  ? () {
                      if (_formKey.currentState!.validate()) {
                        //pass the value of onSave to inputAmount (String)
                        _formKey.currentState?.save();

                        final input = inputAmount;

                        if (input == null) return;

                        // passes 2 arguments
                        // TextInput
                        // WaterAccount
                        context.push(
                          '/payment/paymentconfirmation',
                          extra: {
                            'inputAmount': double.tryParse(input),
                            'waterAccount': waterAccount,
                          },
                        );

                        Future.delayed(Duration(seconds: 1), () {
                          //clear the value of controller
                          _amountController?.clear();
                        });
                      }
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBigbox(ThemeData theme) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(top: -40, child: _buildTransactioNotice(theme)),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(27),

          decoration: BoxDecoration(
            color: const Color(0xFF5456A7),
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: Text(
            'Please be advised that all digital payments require 24 to 48 hours to be officially posted to your account.\n'
            'You will receive a notification once the transaction has been verified and your updated balance is reflected on the dashboard.\n'
            'We recommend keeping your digital receipt for your records until the payment is fully visible in your billing history.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactioNotice(ThemeData theme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: theme.colorScheme.tertiary,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            const Icon(Icons.warning_amber_rounded),
            Text('Transaction Notice', style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(UserAccount loggedUser, ThemeData theme) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Method', style: theme.textTheme.titleLarge),
        SizedBox(
          child: Row(
            spacing: 30,
            children: [
              SizedBox(
                child: Row(
                  spacing: 5,
                  children: [
                    SvgPicture.asset(
                      height: 44,
                      width: 44,
                      'assets/mobile-app/onboarding/gcash-vector-logo-seeklogo/gcash-seeklogo-2.svg',
                    ),
                    Text(
                      PaymentMethod.gCash.value,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      '${loggedUser.ewallet}',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      loggedUser.nickname,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    WaterAccount waterAccount,
    String currencySign,
    ThemeData theme,
  ) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 200,
        child: Column(
          spacing: 25,
          children: [
            Text('Enter amount:', style: theme.textTheme.headlineMedium),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                cursorColor: theme.colorScheme.primary,
                autovalidateMode: AutovalidateMode.onUserInteractionIfError,
                onChanged: (value) {
                  _textFieldToggleSwitch(value);
                },
                validator: (value) {
                  return _validateAmountTextfield(value);
                },
                onSaved: (value) {
                  _storeValue(value);
                },
                decoration: InputDecoration(
                  hintText: _defaultAmount,
                  errorStyle: theme.textTheme.labelSmall!.copyWith(
                    color: theme.colorScheme.error,
                  ),
                  helper: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Balance: ',
                          style: theme.textTheme.labelSmall,
                        ),
                        TextSpan(
                          text:
                              '$currencySign ${waterAccount.balance.toStringAsFixed(2)}',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: const Color(0xFF664D03),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: const Color(0xFF664D03),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

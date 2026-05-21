import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/custom-widgets/primary_button.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PaymentPage> {
  String defaultAmount = '0';

  TextEditingController? _amountController;

  @override
  initState() {
    super.initState();
    _amountController = TextEditingController(text: defaultAmount);
  }

  @override
  void dispose() {
    _amountController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Payment')),
      body: SizedBox(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            const SizedBox(height: 20),
            _buildTextField(theme),
            const SizedBox(height: 50),
            _buildPaymentMethod(theme),
            const SizedBox(height: 25),
            _buildTransactioNotice(theme),
            _buildBigbox(theme),
            const SizedBox(height: 25),
            PrimaryButton(label: 'Proceed'),
          ],
        ),
      ),
    );
  }

  Widget _buildBigbox(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(27),
      decoration: BoxDecoration(
        color: Color(0xFF5456A7),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Text(
        'Please be advised that all digital payments require 24 to 48 hours to be officially posted to your account.'
        'You will receive a notification once the transaction has been verified and your updated balance is reflected on the dashboard.'
        'We recommend keeping your digital receipt for your records until the payment is fully visible in your billing history.',
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSecondary,
        ),
      ),
    );
  }

  Widget _buildTransactioNotice(ThemeData theme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 250,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: theme.colorScheme.tertiary,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Icon(Icons.warning_amber_rounded),
            Text('Transaction Notice', style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(ThemeData theme) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Method', style: theme.textTheme.titleLarge),
        SizedBox(
          child: Row(
            spacing: 10,
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
                    Text('GCash', style: theme.textTheme.bodyLarge),
                  ],
                ),
              ),
              Text('XXXX-XXXXX-21324', style: theme.textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(ThemeData theme) {
    //Philippine Peso sign
    final String currencySign = '\u20B1';
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 200,
        child: Column(
          spacing: 25,
          children: [
            Text('Amount', style: theme.textTheme.headlineMedium),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              cursorColor: theme.colorScheme.primary,
              decoration: InputDecoration(
                hintText: defaultAmount,
                helper: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Balance: ',
                        style: theme.textTheme.labelSmall,
                      ),
                      TextSpan(
                        text: '$currencySign 5000',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Color(0xFF664D03),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Color(0xFF664D03),
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

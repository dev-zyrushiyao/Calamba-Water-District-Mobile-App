import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/custom-widgets/appbar_custom_header.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/data-class/bill.dart';
import 'package:myapp/providers/auth_provider.dart';

class BillingContentPage extends ConsumerStatefulWidget {
  const BillingContentPage({super.key, required this.bill});

  final Bill? bill;

  @override
  ConsumerState<BillingContentPage> createState() => BillingContenttState();
}

class BillingContenttState extends ConsumerState<BillingContentPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final data = widget.bill;

    final _ = ref.watch(authNotifierProvider);

    if (data == null) {
      return DisplayNoData();
    }

    return Scaffold(
      appBar: AppBar(
        title: AppbarCustomHeader(
          title: 'Receipt Number: ${data.receiptNumber}',
          subtitle: '${data.monthName} 2026 Bill',
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.all(16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: 800,
            child: Column(
              children: [
                Text('Billing Notice', style: theme.textTheme.headlineSmall),

                const SizedBox(height: 5),

                //head section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    // color: Colors.amber,
                    border: BoxBorder.all(
                      color: theme.colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                  child: _buildHeadSection(
                    accountNickname: 'Customer',
                    accountNumber: '${data.accountNumber}',
                    month: data.monthName,
                    theme: theme,
                  ),
                ),

                //Second Layer
                Container(
                  decoration: BoxDecoration(
                    border: BoxBorder.all(
                      color: theme.colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      //Box Reading Rate
                      Expanded(
                        child: _buildBoxSection(
                          category: 'READING RATE',
                          content: data.readingRate,
                          theme: theme,
                        ),
                      ),
                      //Box Due Date
                      Expanded(
                        child: _buildBoxSection(
                          category: 'DUE DATE',
                          content: data.dueDate,
                          theme: theme,
                        ),
                      ),
                      //Box Meter No.
                      Expanded(
                        child: _buildBoxSection(
                          category: 'METER NO.',
                          content: '${data.meterNumber}',
                          theme: theme,
                        ),
                      ),
                    ],
                  ),
                ),

                //3rd Layer
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: BoxBorder.all(
                      color: theme.colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Period',
                          style: theme.textTheme.labelSmall,
                        ),
                      ),
                      Text(
                        '${data.period['start']} - ${data.period['end']}',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),

                // 4th container
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 500),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: _buildDoubleBoxHeader(
                                        headTitle: 'READINGS',
                                        theme: theme,
                                        boxSection: [
                                          Expanded(
                                            child: _buildBoxSection(
                                              category: 'PRESENT',
                                              content: '${data.presentReading}',
                                              theme: theme,
                                            ),
                                          ),
                                          Expanded(
                                            child: _buildBoxSection(
                                              category: 'PREVIOUS',
                                              content:
                                                  '${data.previousReading}',
                                              theme: theme,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: _buildDoubleBoxHeader(
                                        headTitle: 'CUM',
                                        boxSection: [
                                          Expanded(
                                            child: _buildBoxSection(
                                              category: 'USED',
                                              content:
                                                  '${data.usedCubicMeters}',
                                              theme: theme,
                                            ),
                                          ),
                                        ],
                                        theme: theme,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Expanded(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minHeight: 70,
                                  ),
                                  child: _buildSingleBoxHeader(
                                    'FRANCHISE TAX',
                                    theme,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minHeight: 70,
                                  ),
                                  child: _buildSingleBoxHeader(
                                    'SEPTAGE MANAGEMENT FEE',
                                    theme,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minHeight: 70,
                                  ),
                                  child: _buildSingleBoxHeader(
                                    'ARREARS',
                                    theme,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minHeight: 70,
                                  ),
                                  child: _buildSingleBoxHeader(
                                    'TOTAL AMOUNT',
                                    theme,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minHeight: 70,
                                  ),
                                  child: _buildSingleBoxHeader(
                                    'DUE AFTER',
                                    theme,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Amount
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: double.infinity,
                            child: _buildAmountSection(
                              category: 'AMOUNT',
                              content: [
                                '${data.amount}',
                                '${data.franchiseTax}',
                                '${data.septageManagementFee}',
                                '${data.arrears}',
                                '${data.totalAmount}',
                                '${data.dueAfter}',
                              ],
                              theme: theme,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeadSection({
    required String accountNickname,
    required String accountNumber,
    required String month,
    required ThemeData theme,
  }) {
    return Column(
      spacing: 20,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(accountNickname, style: theme.textTheme.bodyLarge),
            Text(month, style: theme.textTheme.bodyLarge),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(accountNumber, style: theme.textTheme.bodyLarge),
        ),
      ],
    );
  }

  Widget _buildSingleBoxHeader(String header, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      decoration: BoxDecoration(
        border: BoxBorder.all(color: theme.colorScheme.primary, width: 1),
      ),
      child: Text(header, style: theme.textTheme.bodyLarge),
    );
  }

  Widget _buildDoubleBoxHeader({
    required String headTitle,
    required List<Widget> boxSection,
    required ThemeData theme,
  }) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5.0),

          decoration: BoxDecoration(
            border: BoxBorder.all(color: theme.colorScheme.primary, width: 1),
          ),
          child: Text(
            headTitle,
            style: theme.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(children: boxSection), //items of the list should be Expanded
      ],
    );
  }

  Widget _buildAmountSection({
    required String category,
    required List<String> content,
    required ThemeData theme,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: BoxBorder.all(color: theme.colorScheme.primary),
      ),
      child: Column(
        children: [
          Container(
            height: 80,
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: BoxBorder.fromSTEB(
                bottom: BorderSide(color: theme.colorScheme.primary, width: 1),
              ),
            ),
            child: Text(
              category,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5.0),
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                physics: NeverScrollableScrollPhysics(),
                itemCount: content.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          content[index],
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoxSection({
    required String category,
    required String content,
    required ThemeData theme,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: BoxBorder.all(color: theme.colorScheme.primary),
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEFA),
              border: BoxBorder.fromSTEB(
                bottom: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 0.5,
                ),
              ),
            ),
            child: Text(
              category,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 80,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5.0),
            child: Text(content, style: theme.textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}

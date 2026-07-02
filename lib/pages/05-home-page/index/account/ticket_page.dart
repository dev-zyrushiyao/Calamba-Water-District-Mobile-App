import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/models/water_account.dart';
import 'package:myapp/providers/auth_provider.dart';

class TicketPage extends ConsumerWidget {
  const TicketPage({super.key, this.ticketData});

  final Map<String, dynamic>? ticketData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //provider
    final _ = ref.watch(authProvider);
    final data = ticketData;

    final ThemeData theme = Theme.of(context);

    if (data == null) {
      return const DisplayNoData();
    }

    final waterAccount = data['waterAccount'] as WaterAccount?;

    if (waterAccount == null) {
      return const DisplayNoData();
    }

    final reversedTicketList = waterAccount.ticket.reversed.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Ticket')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 90),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                decoration: BoxDecoration(
                  border: BoxBorder.fromLTRB(bottom: BorderSide()),
                ),
                child: const Headline(headline: 'Ticket'),
              ),
            ),
            const SizedBox(height: 23),
            SizedBox(
              height: 600,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: reversedTicketList.length,
                itemBuilder: (context, index) {
                  return TextButton(
                    onPressed: () {
                      context.push(
                        '/ticket/ticketcontent',
                        extra: {
                          'ticketNumber':
                              reversedTicketList[index].ticketNumber,
                          'waterAccount': waterAccount,
                        },
                      );
                    },
                    child: Row(
                      spacing: 10,
                      children: [
                        const Text('•'),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: reversedTicketList[index].statusColor,
                            border: Border.all(
                              width: 0.7,
                              color: theme.colorScheme.onPrimaryFixedVariant,
                            ),
                            borderRadius: BorderRadius.circular(13),
                          ),

                          child: Text(
                            reversedTicketList[index].reportStatus.value,
                          ),
                        ),
                        Text(
                          'Ticket No. ${reversedTicketList[index].ticketNumber}',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

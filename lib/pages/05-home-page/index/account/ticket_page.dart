import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/data-class/ticket.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as List<Ticket>?;

    final ThemeData theme = Theme.of(context);

    if (data == null) {
      return const DisplayNoData();
    }

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
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/ticketcontent',
                        arguments: data[index],
                      );
                    },
                    child: Row(
                      spacing: 10,
                      children: [
                        const Text('•'),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: data[index].statusColor,
                            border: Border.all(
                              width: 0.7,
                              color: theme.colorScheme.onPrimaryFixedVariant,
                            ),
                            borderRadius: BorderRadius.circular(13),
                          ),

                          child: const Text('•'),
                        ),
                        Text(
                          'Ticket No. ${data[index].ticketNumber}',
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

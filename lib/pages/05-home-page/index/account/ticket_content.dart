import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/separation_divider.dart';
import 'package:myapp/data-class/chat_support.dart';
import 'package:myapp/data-class/constants/chat_role_enum.dart';
import 'package:myapp/data-class/ticket.dart';
import 'package:myapp/services/user_interface_service.dart';

class TicketContent extends StatelessWidget {
  const TicketContent({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Ticket?;

    //theme
    final ThemeData theme = Theme.of(context);

    //service
    final UserInterfaceService userInterfaceService = UserInterfaceService();

    if (data == null) {
      return DisplayNoData();
    }

    String dateTicketCreated = userInterfaceService.convertToCalendarDateFormat(
      data.report.dateTicketCreated,
    );
    String dateOccurence = userInterfaceService.convertToCalendarDateFormat(
      data.report.dateOccurence,
    );

    List<ChatSupport> chatSupport = data.report.chatHistory;

    return Scaffold(
      appBar: AppBar(title: Text('Ticket No. ${data.ticketNumber}')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Category: ${data.report.supportCategory.description}',
                      style: theme.textTheme.headlineSmall,
                    ),
                    Text(
                      'Ticket Created at: $dateTicketCreated',
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      'Date Occurence: $dateOccurence',
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            SeparationDivider(),
            Container(
              height: 500,
              // color: Colors.amber,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 30),
                itemCount: chatSupport.length,
                itemBuilder: (context, index) {
                  return _buildChatBubble(
                    chatSupportIndex: chatSupport[index],
                    datePosted: userInterfaceService
                        .convertToCalendarDateFormat(
                          chatSupport[index].date,
                          true,
                        ),
                    theme: theme,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble({
    required ChatSupport chatSupportIndex,
    required String datePosted,
    required ThemeData theme,
  }) {
    return Column(
      //chat bubble alginment
      crossAxisAlignment: chatSupportIndex.role == ChatRole.staff
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Column(
          spacing: 7,
          //date alignment
          crossAxisAlignment: chatSupportIndex.role == ChatRole.staff
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(datePosted),
            //chat bubble
            Container(
              padding: EdgeInsets.all(17),
              width: 250,
              decoration: BoxDecoration(
                color: chatSupportIndex.role == ChatRole.staff
                    ? Color(0xFFFFE69C)
                    : Color(0xFFDBDBF0),
                border: BoxBorder.all(
                  color: theme.colorScheme.onPrimaryFixedVariant,
                ),
                borderRadius: BorderRadius.circular(13.0),
              ),
              child: Column(
                //content inside chatbubble
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 7.0,
                children: [
                  Text(
                    chatSupportIndex.senderName,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    chatSupportIndex.message,
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/separation_divider.dart';
import 'package:myapp/data-bank/account_type.dart';
import 'package:myapp/data-class/chat_support.dart';
import 'package:myapp/data-class/constants/chat_role_enum.dart';
import 'package:myapp/data-class/ticket.dart';
import 'package:myapp/data-class/user_account.dart';
import 'package:myapp/services/user_interface_service.dart';

class TicketContent extends StatefulWidget {
  const TicketContent({super.key});

  @override
  State<TicketContent> createState() => _TicketContentState();
}

class _TicketContentState extends State<TicketContent> {
  final UserAccount _loggedUser = AccountType().owner;
  //service
  final UserInterfaceService _userInterfaceService = UserInterfaceService();

  String? dateTicketCreated;
  String? dateOccurence;

  List<ChatSupport>? chatSupport;

  //use in datetime for chatsupport
  late DateTime currentDateTime = _userInterfaceService.getManilaTimezone();

  //controller
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollToBottom();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Ticket?;

    //theme
    final ThemeData theme = Theme.of(context);

    if (data == null) {
      return DisplayNoData();
    }

    dateTicketCreated = _userInterfaceService.convertToCalendarDateFormat(
      data.report.dateTicketCreated,
    );
    dateOccurence = _userInterfaceService.convertToCalendarDateFormat(
      data.report.dateOccurence,
    );

    chatSupport = data.report.chatHistory;

    return Scaffold(
      appBar: AppBar(title: Text('Ticket No. ${data.ticketNumber}')),
      body: SizedBox(
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Category: ${data.report.supportCategory.description}',
                      style: theme.textTheme.headlineSmall,
                    ),
                    Text(
                      'Ticket Created: $dateTicketCreated',
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      'Date Occurence: $dateOccurence',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SeparationDivider(),
                  ],
                ),
              ),
            ),

            Expanded(
              //cacheExtent to prevent the chat history to showing the bottom scroll element
              child: ListView.separated(
                controller: _scrollController,
                cacheExtent: 99999,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 13.0,
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 30),
                itemCount: chatSupport!.length,
                itemBuilder: (context, index) {
                  return _buildChatBubble(
                    chatSupportIndex: chatSupport![index],
                    datePosted: _userInterfaceService
                        .convertToCalendarDateFormat(
                          chatSupport![index].date,
                          true,
                        ),
                    theme: theme,
                  );
                },
              ),
            ),

            _buildTextField(
              ticketData: data,
              loggedUser: _loggedUser,
              currentDate: currentDateTime,
              theme: theme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required Ticket ticketData,
    required UserAccount loggedUser,
    required DateTime currentDate,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      height: 100,
      alignment: Alignment.topCenter,
      color: const Color(0xFFCDDDE9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 13,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7.0),
                border: BoxBorder.all(
                  color: const Color(0xFF767676),
                  width: 1.0,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
              child: TextField(
                controller: _textController,
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                style: theme.textTheme.bodyLarge,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.attachment_outlined,
                        semanticLabel: 'attachment logo',
                      ),
                    ),
                  ),
                  hintText: 'Reply here',
                  hintStyle: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onPrimaryFixedVariant,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                ticketData.report.chatHistory.add(
                  ChatSupport(
                    senderName: loggedUser.nickname,
                    message: _textController.text,
                    date: currentDate,
                    role: ChatRole.client,
                  ),
                );
              });

              FocusScope.of(context).unfocus();

              _textController.clear();

              _scrollToBottom();
            },
            child: Container(
              height: 55,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF66B9DD),
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: const Icon(Icons.send_rounded),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble({
    required ChatSupport chatSupportIndex,
    required String datePosted,
    required ThemeData theme,
  }) {
    return Column(
      //chat bubble alginment for (both client and staff)
      crossAxisAlignment: chatSupportIndex.role == ChatRole.staff
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Container(
          //main container of individual date and bubble
          constraints: const BoxConstraints(maxWidth: 250),
          child: Column(
            //individual bubble pop up
            crossAxisAlignment: chatSupportIndex.role == ChatRole.staff
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            spacing: 10,
            children: [
              Container(
                //Alignment of the Date
                alignment: chatSupportIndex.role == ChatRole.staff
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                width: double.infinity,

                child: Text(
                  datePosted,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //chat bubble content
              Container(
                padding: const EdgeInsets.all(17),
                // constraints: const BoxConstraints(maxWidth: 250),
                // width: 250,
                decoration: BoxDecoration(
                  color: chatSupportIndex.role == ChatRole.staff
                      ? const Color(0xFFFFE69C)
                      : const Color(0xFFDBDBF0),
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
        ),
      ],
    );
  }
}

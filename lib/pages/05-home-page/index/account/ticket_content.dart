import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/separation_divider.dart';
import 'package:myapp/data-class/chat_support.dart';
import 'package:myapp/data-class/constants/chat_role_enum.dart';
import 'package:myapp/data-class/ticket.dart';
import 'package:myapp/data-class/user_account.dart';
import 'package:myapp/data-class/water_account.dart';
import 'package:myapp/providers/auth_provider.dart';
import 'package:myapp/services/user_interface_service.dart';

class TicketContent extends ConsumerStatefulWidget {
  const TicketContent({super.key, this.ticketData});

  final Map<String, dynamic>? ticketData;

  @override
  ConsumerState<TicketContent> createState() => _TicketContentState();
}

class _TicketContentState extends ConsumerState<TicketContent> {
  //service
  final UserInterfaceService _userInterfaceService = UserInterfaceService();

  String? dateTicketCreated;
  String? dateOccurence;

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
    //theme
    final ThemeData theme = Theme.of(context);

    //provider
    final loggedUser = ref.watch(authNotifierProvider);
    final data = widget.ticketData;

    if (loggedUser == null || data == null) {
      return DisplayNoData();
    }

    final ticketNumber = data['ticketNumber'] as int?;
    final waterAccount = data['waterAccount'] as WaterAccount?;

    if (ticketNumber == null || waterAccount == null) {
      return DisplayNoData();
    }

    final ticket = waterAccount.ticket.firstWhere(
      (ticket) => ticket.ticketNumber == ticketNumber,
    );

    final chatSupport = ticket.report.chatHistory;

    dateTicketCreated = _userInterfaceService.convertToCalendarDateFormat(
      ticket.report.dateTicketCreated,
    );
    dateOccurence = _userInterfaceService.convertToCalendarDateFormat(
      ticket.report.dateOccurence,
    );

    return Scaffold(
      appBar: AppBar(title: Text('Ticket No. ${ticket.ticketNumber}')),
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
                      'Category: ${ticket.report.supportCategory.description}',
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
                scrollCacheExtent: ScrollCacheExtent.pixels(99999),
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 13.0,
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 30),
                itemCount: chatSupport.length,
                itemBuilder: (context, index) {
                  return _buildChatBubble(
                    chatSupportIndex: chatSupport[index],
                    datePosted: _userInterfaceService
                        .convertToCalendarDateFormat(
                          chatSupport[index].date,
                          true,
                        ),
                    theme: theme,
                  );
                },
              ),
            ),

            _buildTextField(
              ticket: ticket,
              loggedUser: loggedUser,
              waterAccount: waterAccount,
              theme: theme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required Ticket ticket,
    required UserAccount loggedUser,
    required WaterAccount waterAccount,

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
              if (_textController.text.isEmpty) {
                return;
              }

              //use in datetime for chatsupport
              DateTime currentDateTime = _userInterfaceService
                  .getManilaTimezone();

              ticket.report.chatHistory.add(
                ChatSupport(
                  senderName: loggedUser.nickname,
                  message: _textController.text,
                  date: currentDateTime,
                  role: loggedUser.chatRole,
                ),
              );

              //find the index of the ticket in the list
              final targetIndex = waterAccount.ticket.indexWhere(
                (ticketData) => ticketData.ticketNumber == ticket.ticketNumber,
              );

              if (targetIndex == -1) return;

              //copy WaterAccount ticket list
              final updatedTicketList = List<Ticket>.from(waterAccount.ticket);

              //replace the ticket in the list with the updated ticket
              updatedTicketList[targetIndex] = ticket;

              // //create a new WaterAccount with the updated ticket list
              final updatedWaterAccount = waterAccount.copyWith(
                ticket: updatedTicketList,
              );

              ref
                  .read(authNotifierProvider.notifier)
                  .updateLinkedAccount(updatedWaterAccount);

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

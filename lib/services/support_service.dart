import 'dart:math';

import 'package:myapp/data-class/chat_support.dart';
import 'package:myapp/data-class/constants/chat_role_enum.dart';
import 'package:myapp/data-class/constants/report_status_enum.dart';
import 'package:myapp/data-class/report.dart';
import 'package:myapp/data-class/ticket.dart';
import 'package:myapp/data-class/user_account.dart';

class SupportService {
  int generateTicketNumber() {
    int min = 10_000_000;
    int max = 80_000_000;
    int value = Random().nextInt(max) + min;

    return value;
  }

  Future<Ticket?> retrieveTicket(
    int generatedTicketNumber,
    UserAccount loggedUser,
  ) async {
    for (var linkedAccount in loggedUser.linkedAccounts) {
      for (var ticket in linkedAccount.ticket) {
        if (ticket.ticketNumber == generatedTicketNumber) {
          return ticket;
        }
      }
    }

    return null;
  }

  Future<Ticket> createTicketSupport({
    required int generatedTicketNumber,
    required UserAccount loggedUser,
    required DateTime manilaTime,
    required DateTime selectedDate,
    required Map<String, dynamic> supportInput,
  }) async {
    return Ticket(
      ticketNumber: generatedTicketNumber,
      report: Report(
        supportCategory: supportInput['supportCategory'],
        affectedAccountNumber: supportInput['affectedAccountNumber'],
        dateOccurence: selectedDate,
        dateTicketCreated: manilaTime,
        reportedBy: loggedUser.nickname,
        reportContext:
            supportInput['reportContext'] ?? 'Report Context Not Found',
        chatHistory: [
          createChatMessage(
            loggedUser.nickname,
            supportInput['reportContext'],
            manilaTime,
            ChatRole.client,
          ),
          createChatMessage(
            'Stell',
            supportInput['reportContext'],
            manilaTime,
            ChatRole.staff,
          ),
        ],
      ),
      reportStatus: ReportStatus.inProgress,
    );
  }

  ChatSupport createChatMessage(
    String senderName,
    String? reportContext,
    DateTime dateTime,
    ChatRole role,
  ) {
    switch (role) {
      case ChatRole.client:
        return ChatSupport(
          senderName: senderName,
          message: reportContext ?? 'Report Context Not Found',
          date: dateTime,
          role: role,
        );
      case ChatRole.staff:
        //default
        return ChatSupport(
          senderName: 'Stell - Support',
          message:
              'We apologize for the inconvenience regarding your balance; \n'
              'please allow 24 to 48 hours for your mobile payment to sync with our system. \n'
              'If the issue persists after this period, kindly send a screenshot of your receipt \n'
              'so we can manually verify and update your account.',
          date: dateTime,
          role: role,
        );
    }
  }
}

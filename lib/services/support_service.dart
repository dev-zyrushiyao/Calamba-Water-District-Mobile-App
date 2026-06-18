import 'dart:math';

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
}

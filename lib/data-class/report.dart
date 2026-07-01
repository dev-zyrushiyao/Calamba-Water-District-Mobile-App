import 'package:myapp/data-class/chat_support.dart';
import 'package:myapp/data-class/constants/support_category_enum.dart';

class Report {
  final SupportCategory supportCategory;
  final int affectedAccountNumber;
  final DateTime dateOccurence;
  final DateTime dateTicketCreated;
  final String reportedBy;
  final String reportContext;
  final List<ChatSupport> chatHistory;

  Report({
    required this.supportCategory,
    required this.affectedAccountNumber,
    required this.dateOccurence,
    required this.dateTicketCreated,
    required this.reportedBy,
    required this.reportContext,
    required this.chatHistory,
  });

  Report copyWith({
    SupportCategory? supportCategory,
    int? affectedAccountNumber,
    DateTime? dateOccurence,
    DateTime? dateTicketCreated,
    String? reportedBy,
    String? reportContext,
    List<ChatSupport>? chatHistory,
  }) {
    return Report(
      supportCategory: supportCategory ?? this.supportCategory,
      affectedAccountNumber:
          affectedAccountNumber ?? this.affectedAccountNumber,
      dateOccurence: dateOccurence ?? this.dateOccurence,
      dateTicketCreated: dateTicketCreated ?? this.dateTicketCreated,
      reportedBy: reportedBy ?? this.reportedBy,
      reportContext: reportContext ?? this.reportContext,
      chatHistory: chatHistory ?? this.chatHistory,
    );
  }
}

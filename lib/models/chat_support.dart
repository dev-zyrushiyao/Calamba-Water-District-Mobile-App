import 'package:myapp/models/constants/chat_role_enum.dart';

class ChatSupport {
  final String senderName;
  final String message;
  final DateTime date;
  final ChatRole role;

  const ChatSupport({
    required this.senderName,
    required this.message,
    required this.date,
    required this.role,
  });
}

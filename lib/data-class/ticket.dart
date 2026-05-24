import 'package:myapp/data-class/constants/report_status_enum.dart';
import 'package:myapp/data-class/report.dart';

class Ticket {
  final int ticketNumber;
  final Report report;
  final ReportStatus reportStatus;

  const Ticket({
    required this.ticketNumber,
    required this.report,
    required this.reportStatus,
  });
}

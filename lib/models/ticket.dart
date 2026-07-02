import 'dart:ui';

import 'package:myapp/models/constants/report_status_enum.dart';
import 'package:myapp/models/report.dart';

class Ticket {
  final int ticketNumber;
  final Report report;
  final ReportStatus reportStatus;

  const Ticket({
    required this.ticketNumber,
    required this.report,
    required this.reportStatus,
  });

  Ticket copyWith({
    int? ticketNumber,
    Report? report,
    ReportStatus? reportStatus,
  }) {
    return Ticket(
      ticketNumber: ticketNumber ?? this.ticketNumber,
      report: report ?? this.report,
      reportStatus: reportStatus ?? this.reportStatus,
    );
  }

  Color get statusColor => reportStatus.getReportStatusColor();
}

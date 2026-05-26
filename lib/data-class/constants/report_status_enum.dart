import 'package:flutter/material.dart';

enum ReportStatus {
  resolved('Resolved'),
  inProgress('In Progress'),
  cancelled('Cancelled');

  final String value;

  const ReportStatus(this.value);

  Color getReportStatusColor() {
    switch (this) {
      case ReportStatus.resolved:
        return Colors.green;
      case ReportStatus.inProgress:
        return Colors.yellow;
      case ReportStatus.cancelled:
        return Colors.grey;
    }
  }
}

enum ReportStatus {
  resolved('Resolved'),
  inProgress('In Progress'),
  cancelled('Cancelled');

  final String value;

  const ReportStatus(this.value);
}

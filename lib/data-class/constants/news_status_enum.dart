enum NewsStatus {
  ongoing('On Going Repair'),
  resolved('Issue Resolved'),
  monitoring('Currently Monitoring');

  final String value;

  const NewsStatus(this.value);
}

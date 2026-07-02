enum WaterAccountStatus {
  active(true, 'Active'),
  inactive(false, 'Inactive');

  final bool value;
  final String text;
  const WaterAccountStatus(this.value, this.text);
}

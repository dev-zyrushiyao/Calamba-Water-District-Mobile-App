enum SupportCategory {
  issueLeak('Report a leak'),
  issueBill('Billing Issue'),
  issueAccount('Account Issue'),
  issueApp('App Bug');

  final String value;

  const SupportCategory(this.value);
}

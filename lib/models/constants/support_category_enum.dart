enum SupportCategory {
  issueLeak('Report a leak', 'Leak issue'),
  issueBill('Billing Issue', 'Billing related concern'),
  issueAccount('Account Issue', 'Account concern'),
  issueApp('App Bug', 'App concern');

  final String value;
  final String description;

  const SupportCategory(this.value, this.description);
}

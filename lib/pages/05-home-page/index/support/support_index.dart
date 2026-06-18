import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/data-bank/account_type.dart';
import 'package:myapp/data-class/chat_support.dart';
import 'package:myapp/data-class/constants/chat_role_enum.dart';
import 'package:myapp/data-class/constants/report_status_enum.dart';
import 'package:myapp/data-class/constants/support_category_enum.dart';
import 'package:myapp/data-class/report.dart';
import 'package:myapp/data-class/ticket.dart';
import 'package:myapp/data-class/user_account.dart';
import 'package:myapp/services/masking_service.dart';
import 'package:myapp/services/support_service.dart';
import 'package:myapp/services/user_interface_service.dart';

class SupportIndex extends StatefulWidget {
  const SupportIndex({super.key});

  @override
  State<SupportIndex> createState() => _SupportIndexState();
}

class _SupportIndexState extends State<SupportIndex> {
  //user
  final UserAccount _loggedUser = AccountType().owner;

  //service
  final SupportService _supportService = SupportService();
  final UserInterfaceService _userInterfaceService = UserInterfaceService();
  final MaskingService _maskingService = MaskingService();

  final List<DropdownMenuEntry<dynamic>> _categoryDropDownItem = [];
  final TextEditingController _categoryController = TextEditingController();

  final List<DropdownMenuEntry<dynamic>> _accountDropDownItem = [];
  final TextEditingController _accountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  String? _formatDateValue;
  bool _enableAccountDropdown = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _supportInput = {
    'supportCategory': null,
    'affectedAccountNumber': null,
    'reportContext': null,
  };

  @override
  void initState() {
    super.initState();
    _addDropdownItems();
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _accountController.dispose();
    super.dispose();
  }

  void _addDropdownItems() {
    for (var category in SupportCategory.values) {
      _categoryDropDownItem.add(
        DropdownMenuEntry(value: category, label: category.value),
      );
    }

    if (_loggedUser.linkedAccounts.isNotEmpty) {
      for (var account in _loggedUser.linkedAccounts) {
        _accountDropDownItem.add(
          DropdownMenuEntry(
            value: account.accountNumber,
            label:
                '${account.accountName} (${_maskingService.formatAccountNumber(accountNumber: account.accountNumber)}) ',
          ),
        );
      }
    }
  }

  void _initializeFormatDateValue() {
    // invoke at build method , this require refresh page every time it change value
    // refrain from invoking it at initState method
    _formatDateValue = _userInterfaceService.convertToCalendarDateFormat(
      _selectedDate,
    );
  }

  ChatSupport createChatMessage(
    String senderName,
    String? reportContext,
    DateTime dateTime,
    ChatRole role,
  ) {
    switch (role) {
      case ChatRole.client:
        return ChatSupport(
          senderName: senderName,
          message: reportContext ?? 'Report Context Not Found',
          date: dateTime,
          role: role,
        );
      case ChatRole.staff:
        //default
        return ChatSupport(
          senderName: 'Stell - Support',
          message:
              'We apologize for the inconvenience regarding your balance; \n'
              'please allow 24 to 48 hours for your mobile payment to sync with our system. \n'
              'If the issue persists after this period, kindly send a screenshot of your receipt \n'
              'so we can manually verify and update your account.',
          date: dateTime,
          role: role,
        );
    }
  }

  Future<void> createTicketSupport(int generatedTicketNumber) async {
    //Search the affected account under the LoggedUser
    for (var linkedAccount in _loggedUser.linkedAccounts) {
      //when the user is found create a receipt
      if (linkedAccount.accountNumber ==
          _supportInput['affectedAccountNumber']) {
        DateTime manilaTime = _userInterfaceService.getManilaTimezone();

        linkedAccount.ticket.add(
          Ticket(
            ticketNumber: generatedTicketNumber,
            report: Report(
              supportCategory: _supportInput['supportCategory'],
              affectedAccountNumber: _supportInput['affectedAccountNumber'],
              dateOccurence: _selectedDate,
              dateTicketCreated: manilaTime,
              reportedBy: _loggedUser.nickname,
              reportContext:
                  _supportInput['reportContext'] ?? 'Report Context Not Found',
              chatHistory: [
                createChatMessage(
                  _loggedUser.nickname,
                  _supportInput['reportContext'],
                  manilaTime,
                  ChatRole.client,
                ),
                createChatMessage(
                  'Stell',
                  _supportInput['reportContext'],
                  manilaTime,
                  ChatRole.staff,
                ),
              ],
            ),
            reportStatus: ReportStatus.inProgress,
          ),
        );
        debugPrint('NOTE: Ticket has been Created');
        break;
      }
    }
  }

  void _refreshValues() {
    setState(() {
      _formKey.currentState?.reset(); // Clears form validation & FormFields
      _categoryController.clear(); // Clears Category Text
      _accountController.clear(); // Clears Account Text
      _selectedDate = DateTime.now(); // Resets calendar date
      _enableAccountDropdown = false; // Hides the conditional dropdown
      _supportInput.updateAll((key, value) => null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    //format date every page refresh
    _initializeFormatDateValue();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            children: [
              const SizedBox(height: 85.0),

              Headline(
                headline: 'File a Report',
                subHeadline:
                    'Let us know about issues with your water service connection.',
              ),

              const SizedBox(height: 30),

              _buildDropdownButton(
                title: 'Category',
                controller: _categoryController,
                dropDownItem: _categoryDropDownItem,
                theme: theme,
              ),

              const SizedBox(height: 30),

              if (_enableAccountDropdown)
                _buildDropdownButton(
                  title: 'Affected Account',
                  controller: _accountController,
                  dropDownItem: _accountDropDownItem,
                  theme: theme,
                ),

              const SizedBox(height: 30),

              _buildCalendarButton(_formatDateValue!, theme),

              const SizedBox(height: 30),

              TextFormField(
                textInputAction: TextInputAction.done,
                maxLength: 500,
                maxLines: null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  errorMaxLines: 2,
                  errorStyle: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.red,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please describe your problem in the text field provided.';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _supportInput['reportContext'] = value;
                },
              ),

              const SizedBox(height: 30),

              PrimaryButton(
                width: double.infinity,
                label: 'Submit Report',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog.adaptive(
                          title: Text('Submit report?'),
                          content: Text(
                            'Confirming this submission will automatically generate a support ticket for your reported issue.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                //generate ticketNumber
                                int generatedTicketNumber = _supportService
                                    .generateTicketNumber();

                                //close the dialogbox
                                Navigator.pop(context);

                                switch (_supportInput['supportCategory']) {
                                  case SupportCategory.issueLeak ||
                                      SupportCategory.issueBill:

                                    //create ticket
                                    await createTicketSupport(
                                      generatedTicketNumber,
                                    );

                                    Ticket? searchedReceipt =
                                        await _supportService.retrieveTicket(
                                          generatedTicketNumber,
                                          _loggedUser,
                                        );

                                    //guard clause
                                    if (!context.mounted) return;

                                    if (searchedReceipt != null) {
                                      await Navigator.pushNamed(
                                        context,
                                        '/supportresult',
                                        arguments: searchedReceipt,
                                      );
                                      //refresh the value when the user go back at SupportIndex after creating ticket
                                      _refreshValues();
                                    } else {
                                      debugPrint(
                                        'searched ticket value : $searchedReceipt , no ticket found',
                                      );
                                    }
                                    break;
                                  case SupportCategory.issueApp ||
                                      SupportCategory.issueAccount:
                                    //Not saved in Receipt object because its an account issue
                                    //Receipt only issued in LinkedAccount
                                    //For account level and app issue proceed to email support instead
                                    //arguments just return an integer generated number
                                    //Display a separate page that display just a generated number imitating ticket is saved
                                    await Navigator.pushNamed(
                                      context,
                                      '/supportemailresult',
                                      arguments: generatedTicketNumber,
                                    );
                                    //refresh the value when the user go back at SupportIndex after creating ticket
                                    _refreshValues();
                                    break;
                                  default:
                                    debugPrint(
                                      'switch case value (SupportCategory) is not found.',
                                    );
                                }
                              },
                              child: Text('Submit'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarButton(String formatDateValue, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          'Occurrence Date:',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () => _selectDatePopup(),
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              spacing: 10,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.calendar_month_sharp,
                      color: theme.colorScheme.onSecondary,
                    ),
                  ),
                ),
                Text(
                  formatDateValue,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _selectDatePopup() async {
    //Note: save the value of pickedDate to Receipt
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2026, 12, 31),
      builder: (context, child) {
        //overrite the ThemeData only affect the calendar
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2E3092),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Widget _buildDropdownButton({
    required String title,
    required List<DropdownMenuEntry<dynamic>> dropDownItem,
    required TextEditingController controller,
    required ThemeData theme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownMenuFormField(
          requestFocusOnTap: false,
          controller: controller,
          width: double.infinity,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputDecorationTheme: InputDecorationTheme(
            errorStyle: theme.textTheme.labelSmall?.copyWith(color: Colors.red),
          ),
          enabled: dropDownItem.isNotEmpty,
          dropdownMenuEntries: dropDownItem.isNotEmpty ? dropDownItem : [],
          alignmentOffset: const Offset(0, 7),
          hintText: 'Please Select',
          onSelected: (value) {
            setState(() {
              //this is used to hide the affected Account Dropdown
              _enableAccountDropdown =
                  !(value == SupportCategory.issueApp ||
                      value == SupportCategory.issueAccount);
            });
          },
          validator: (value) {
            if (value == null) {
              return 'Incomplete form';
            } else {
              return null;
            }
          },
          onSaved: (value) {
            //switch will run on each textField
            //cycle 1: save SupportCategory
            //cycle 2: save int
            switch (value) {
              case SupportCategory _:
                _supportInput['supportCategory'] = value;
                break;
              case int _:
                _supportInput['affectedAccountNumber'] = value;
                break;
              default:
                debugPrint(
                  'OnSaved value: $value (${value.runtimeType}) failed to save',
                );
            }
          },
          trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded),
          selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up_rounded),
          menuStyle: MenuStyle(
            maximumSize: WidgetStateProperty<Size>.fromMap({
              WidgetState.any: Size(350, 300),
            }),
            visualDensity: VisualDensity(vertical: 4),
            backgroundColor: WidgetStateColor.fromMap({
              WidgetState.any: Color(0xFFEEEEFA),
            }),
            shape: WidgetStateOutlinedBorder.fromMap({
              WidgetState.any: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Color(0xFF2E3092)),
              ),
            }),
          ),
        ),
      ],
    );
  }
}

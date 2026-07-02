import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/page_logo.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/models/constants/support_category_enum.dart';
import 'package:myapp/models/water_account.dart';
import 'package:myapp/providers/auth_provider.dart';
import 'package:myapp/services/masking_service.dart';
import 'package:myapp/services/support_service.dart';
import 'package:myapp/services/user_interface_service.dart';

class SupportIndex extends ConsumerStatefulWidget {
  const SupportIndex({super.key});

  @override
  ConsumerState<SupportIndex> createState() => _SupportIndexState();
}

class _SupportIndexState extends ConsumerState<SupportIndex> {
  //user
  // final UserAccount _loggedUser = AccountType().owner;

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
    final loggedUser = ref.read(authProvider);
    if (loggedUser == null) return;

    for (var category in SupportCategory.values) {
      _categoryDropDownItem.add(
        DropdownMenuEntry(value: category, label: category.value),
      );
    }

    if (loggedUser.linkedAccounts.isNotEmpty) {
      for (var account in loggedUser.linkedAccounts) {
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

    final loggedUser = ref.watch(authProvider);

    if (loggedUser == null) {
      return DisplayNoData();
    }

    //format date every page refresh
    _initializeFormatDateValue();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 10),
            children: [
              PageLogo(),

              const SizedBox(height: 38),

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
                                context.pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                //generate ticketNumber
                                int generatedTicketNumber = _supportService
                                    .generateTicketNumber();

                                //manilaTime
                                DateTime manilaTime = _userInterfaceService
                                    .getManilaTimezone();

                                // close the dialogbox
                                // it wont appear again after going ticket submission to SupportIndex
                                context.pop();

                                switch (_supportInput['supportCategory']) {
                                  case SupportCategory.issueLeak ||
                                      SupportCategory.issueBill:

                                    //create ticket
                                    final ticket = await _supportService
                                        .createTicketSupport(
                                          generatedTicketNumber:
                                              generatedTicketNumber,
                                          loggedUser: loggedUser,
                                          manilaTime: manilaTime,
                                          selectedDate: _selectedDate,
                                          supportInput: _supportInput,
                                        );

                                    //copy of list
                                    final copyOfList = List<WaterAccount>.from(
                                      loggedUser.linkedAccounts,
                                    );
                                    //find target index
                                    final targetIndex = copyOfList.indexWhere(
                                      (account) =>
                                          account.accountNumber ==
                                          _supportInput['affectedAccountNumber'],
                                    );

                                    if (targetIndex == -1) return;

                                    //fetch the water account and inject a new ticket from its ticket list
                                    final targetAccount =
                                        copyOfList[targetIndex];
                                    targetAccount.ticket.add(ticket);

                                    //save the changes to the provider
                                    ref
                                        .read(authProvider.notifier)
                                        .updateLinkedAccount(targetAccount);

                                    // //guard clause
                                    if (!context.mounted) return;

                                    await context.push(
                                      '/supportresult',
                                      extra: ticket,
                                    );

                                    break;
                                  case SupportCategory.issueApp ||
                                      SupportCategory.issueAccount:
                                    //Not saved in Ticket object because its an account issue
                                    //Ticket only issued in LinkedAccount
                                    //For account level and app issue proceed to email support instead (simulation)
                                    //arguments just return an integer generated number(generatedTicketNumber)
                                    //Display a separate page that display just a generated number imitating ticket is saved
                                    //guard clause
                                    if (!context.mounted) return;
                                    await context.push(
                                      '/supportemailresult',
                                      extra: generatedTicketNumber,
                                    );

                                    break;
                                  default:
                                    debugPrint(
                                      'switch case value (SupportCategory) is not found.',
                                    );
                                }

                                //refresh the value when the user go back at SupportIndex after creating ticket
                                _refreshValues();
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

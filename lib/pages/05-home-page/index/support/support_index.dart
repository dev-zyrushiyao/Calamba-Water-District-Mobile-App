import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/primary_button.dart';
import 'package:myapp/data-bank/account_type.dart';
import 'package:myapp/data-class/constants/support_category_enum.dart';
import 'package:myapp/data-class/user_account.dart';
import 'package:myapp/services/user_interface_service.dart';

class SupportIndex extends StatefulWidget {
  const SupportIndex({super.key});

  @override
  State<SupportIndex> createState() => _SupportIndexState();
}

class _SupportIndexState extends State<SupportIndex> {
  //user
  final UserAccount _loggedUser = AccountType().owner;

  final List<DropdownMenuEntry<dynamic>> _categoryDropDownItem = [];
  final TextEditingController _categoryController = TextEditingController();

  final List<DropdownMenuEntry<dynamic>> _accountDropDownItem = [];
  final TextEditingController _accountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  final UserInterfaceService _userInterfaceService = UserInterfaceService();

  String? _formatDateValue;

  bool _enableButton = false;

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

  void _addDropdownItems() async {
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
                '${account.accountName} (${_userInterfaceService.formatAccountNumber(accountNumber: account.accountNumber)}) ',
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    _formatDateValue = _userInterfaceService.convertToCalendarDateFormat(
      _selectedDate,
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
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
            if (_enableButton)
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
              decoration: InputDecoration(labelText: 'Message'),
            ),

            const SizedBox(height: 30),

            PrimaryButton(label: 'Submit Report'),
          ],
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
          controller: controller,
          width: double.infinity,
          enabled: dropDownItem.isNotEmpty,
          dropdownMenuEntries: dropDownItem.isNotEmpty ? dropDownItem : [],
          alignmentOffset: const Offset(0, 7),
          hintText: 'Please Select',
          onSelected: (value) {
            setState(() {
              //this is used to hide the Account section TextFormField
              _enableButton = (value != SupportCategory.issueApp);
            });
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

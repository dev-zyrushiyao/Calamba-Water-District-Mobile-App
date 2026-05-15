import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myapp/custom-widgets/colored_container.dart';

import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/separation_divider.dart';
import 'package:myapp/custom-widgets/silver_dotted_border.dart';
import 'package:myapp/data-bank/account_type.dart';
import 'package:myapp/data-class/user_account.dart';
import 'package:myapp/data-class/water_account.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:myapp/services/user_interface_service.dart';

class AccountIndex extends StatefulWidget {
  const AccountIndex({super.key});

  @override
  State<AccountIndex> createState() => _AccountIndexState();
}

class _AccountIndexState extends State<AccountIndex>
    with TickerProviderStateMixin {
  //User Account
  final UserAccount _loggedUser = AccountType().owner;

  //service
  final UserInterfaceService _userInterfaceService = UserInterfaceService();

  //controller
  final List<SlidableController> _slidableController = [];

  //slider value
  // double _actionExtent = 0.0;
  final List<double> _slidingValue = [];

  //rotation value for drag icon
  double? rotation;

  @override
  void initState() {
    super.initState();

    //Parallel List linkedAccounts, _slidableController, and _slidingValue
    _createSlidingController();
    // _addSliderInitialValue();
    // _getTheSlidingValue();

    debugPrint(
      'the length of the LinkedUser is ${_loggedUser.linkedAccounts.length}',
    );
  }

  @override
  void dispose() {
    super.dispose();
    _disposeSlidingController();
  }

  // ==================//
  // initState methods //
  // ==================//

  void _createSlidingController() {
    //add sliding controller of linked accounts

    if (_loggedUser.linkedAccounts.isNotEmpty) {
      //if user has liked accounts -> create a controller
      // if target is 5 and current is 2, it will add 3 controllers
      while (_slidableController.length < _loggedUser.linkedAccounts.length) {
        _slidableController.add(SlidableController(this));
      }
    }
  }

  @Deprecated(
    'This method is no longer available: the method is prone to RangeError (index): Index out of range: no indices are valid: 0'
    'The Parallel List approach List<SlidableController> creating a value for List<double> slidingValue to be used on List<WaterAccount>\n'
    'is risky for a index get out of sync when the page rebuilds\n'
    'please use _slidableController[index].animation.value directly for the AnimatedRotation (turn property) instead ',
  )
  void _addSliderInitialValue() {
    //Add initial values of Sliders
    //to prevent RangeError (index): Index out of range: no indices are valid: 0
    if (_slidableController.isNotEmpty) {
      for (var i = 0; i < _loggedUser.linkedAccounts.length; i++) {
        _slidingValue.add(0.0);
      }
    }
  }

  @Deprecated(
    'The Parallel List approach List<SlidableController> creating a value for List<double> slidingValue to be used on List<WaterAccount>\n'
    'is risky for a index get out of sync when the page rebuilds\n'
    'please use _slidableController[index].animation.value directly for the AnimatedRotation (turn property) instead ',
  )
  void _getTheSlidingValue() {
    //The _slidingValue list have a default value of 0.0
    //when a sliding animation happens it overrite the default value of Slidable controller animation value
    if (_slidableController.isNotEmpty) {
      for (var i = 0; i < _loggedUser.linkedAccounts.length; i++) {
        _slidableController[i].animation.addListener(() {
          setState(() {
            _slidingValue[i] = _slidableController[i].animation.value;
          });
        });
      }
    }
  }

  // ==================//
  // dispose methods   //
  // ==================//

  void _disposeSlidingController() {
    //dispose all the sliding controller of linked accounts
    if (_slidableController.isNotEmpty) {
      for (var i = 0; i < _slidableController.length; i++) {
        _slidableController[i].dispose();
      }
    }
  }

  Widget _buildSlider({
    required List<WaterAccount> linkedAccounts,
    required int index,
    required ThemeData theme,
  }) {
    return Slidable(
      key: ValueKey(index),
      controller: _slidableController[index],
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog.adaptive(
                    icon: Icon(Icons.delete),
                    title: Text('Unlink this account?'),
                    content: Text(
                      'Local transaction history for this account will be removed from this device.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            linkedAccounts.removeAt(index);
                            Navigator.pop(context);
                          });
                        },
                        child: Text('Unlink'),
                      ),
                    ],
                  );
                },
              );
            },
            backgroundColor: const Color(0xFFC50014),
            foregroundColor: theme.colorScheme.onSecondary,
            icon: Icons.delete,
            label: 'Unlink',
          ),
          SlidableAction(
            onPressed: (context) {
              debugPrint('$context');
            },
            backgroundColor: const Color(0xFF0392CF),
            foregroundColor: theme.colorScheme.onSecondary,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: ListTile(
        // contentPadding: EdgeInsets.zero,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 7,
                  children: [
                    Text(
                      _userInterfaceService.formatAccountNumber(
                        accountNumber:
                            _loggedUser.linkedAccounts[index].accountNumber,
                      ),
                      style: theme.textTheme.titleLarge,
                    ),
                    Container(
                      padding: EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(
                          color: Color(0xFFE3E3E3),
                          width: 1.0,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Text(
                        linkedAccounts[index].isActive ? 'Active' : 'Inactive',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  linkedAccounts[index].accountName,
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
            _buildRotatingIcon(index),
          ],
        ),
      ),
    );
  }

  Widget _buildRotatingIcon(int index) {
    return AnimatedBuilder(
      animation: _slidableController[index].animation,
      builder: (context, child) {
        return AnimatedRotation(
          //Used a Unary Minus Operator (-double) to rotate the icon counter clockwise
          //_slidingvalue[index] || _slidingController[index].animation.value as turns property value
          //_getTheSlidingValue is now Deprecated, please use _slidingController[index].animation.value directly on turns as dynamic double
          turns: (-_slidableController[index].animation.value / 2),
          duration: Duration(microseconds: 500),
          curve: Curves.easeIn,
          child: Icon(Icons.drag_handle),
        );
      },
    );
  }

  Widget _buildLinkButton(ThemeData theme) {
    return Align(
      alignment: _loggedUser.linkedAccounts.isEmpty
          ? Alignment.center
          : Alignment.centerRight,
      child: FilledButton.icon(
        onPressed: () async {
          //wait for the user to finish linking account
          await Navigator.pushNamed(context, '/linkaccount');

          //when the user press back, rebuild the page
          setState(() {
            _createSlidingController();
          });
        },
        style: FilledButton.styleFrom(
          padding: EdgeInsetsGeometry.all(20.0),
          backgroundColor: theme.colorScheme.primaryContainer,
        ),
        icon: Icon(Icons.add_circle_outline_rounded),
        label: Text('Link Account', style: theme.textTheme.labelLarge),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 85.0),

            Align(
              alignment: Alignment.bottomLeft,
              child: Headline(
                headline: 'My Account',
                subHeadline:
                    'Manage your active water connections and service details',
              ),
            ),

            const SizedBox(height: 30),

            //Outer Container
            if (_loggedUser.linkedAccounts.isEmpty)
              SilverDottedBorder(
                message: Text(
                  'Link your service connection to view bills and check consumption',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ),
                button: _buildLinkButton(theme),
              )
            else
              //Display linked accounts
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ColoredContainer(
                    child: Column(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemCount: _loggedUser.linkedAccounts.length,
                            separatorBuilder: (context, index) => Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  child: SizedBox(
                                    child: SeparationDivider(thickness: 1.0),
                                  ),
                                ),
                              ],
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.zero,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surface,
                                  border: BoxBorder.all(
                                    color: const Color(0xFFB4B5DB),
                                    strokeAlign: BorderSide.strokeAlignInside,
                                  ),
                                  borderRadius: BorderRadius.circular(13.0),
                                ),
                                child: _buildSlider(
                                  linkedAccounts: _loggedUser.linkedAccounts,
                                  index: index,
                                  theme: theme,
                                ),
                              );
                            },
                          ),
                        ),
                        _buildLinkButton(theme),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

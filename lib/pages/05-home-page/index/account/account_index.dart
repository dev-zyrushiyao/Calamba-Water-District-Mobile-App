import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myapp/custom-widgets/colored_container.dart';

import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/separation_divider.dart';
import 'package:myapp/custom-widgets/silver_dotted_border.dart';
import 'package:myapp/custom-widgets/status_indicator.dart';
import 'package:myapp/data-bank/account_type.dart';
import 'package:myapp/data-class/user_account.dart';
import 'package:myapp/data-class/water_account.dart';

import 'package:myapp/services/link_account_service.dart';

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

  //form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //text contorller - for updating name
  final TextEditingController _dialogTextfieldController =
      TextEditingController();

  //service
  final UserInterfaceService _userInterfaceService = UserInterfaceService();
  final LinkAccountService _linkAccountService = LinkAccountService();

  //controller
  final List<SlidableController> _slidableController = [];

  //textField has value
  bool _isSaveEnabled = false;

  @override
  void initState() {
    super.initState();
    _createSlidingController();
  }

  @override
  void dispose() {
    _disposeSlidingController();
    _dialogTextfieldController.dispose();
    super.dispose();
  }

  // ==================//
  // initState methods //
  // ==================//

  void _createSlidingController() {
    //add sliding controller of linked accounts

    if (_loggedUser.linkedAccounts.isNotEmpty) {
      //if user has linked accounts -> create a controller
      // if target is 5 and current is 2, it will add 3 controllers
      while (_slidableController.length < _loggedUser.linkedAccounts.length) {
        _slidableController.add(SlidableController(this));
      }
    }
  }

  //==================//
  // dispose methods  //
  //==================//

  void _disposeSlidingController() {
    //dispose all the sliding controller of linked accounts
    if (_slidableController.isNotEmpty) {
      for (var i = 0; i < _slidableController.length; i++) {
        _slidableController[i].dispose();
      }
    }
  }

  // ==================//
  // private methods   //
  // ==================//

  void _closeDialoge(BuildContext context) {
    return Navigator.pop(context);
  }

  Future<dynamic> _buildUnlinkDialoguBox(
    BuildContext context,
    int index,
    List<WaterAccount> linkedAccounts,
  ) {
    return showDialog(
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
  }

  Future<dynamic> _buildEditDialogBox(
    BuildContext context,
    int index,
    List<WaterAccount> linkedAccounts,
    ThemeData theme,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, StateSetter setDialogState) {
            //StateSetter setDialogue work the same as setState
            //setDialogState only refresh the dialog box
            return AlertDialog(
              title: Text('Update Name'),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 20,
                  children: [
                    TextFormField(
                      validator: (value) => _linkAccountService
                          .validateAccountNameTextField(value),
                      maxLength: 15,
                      controller: _dialogTextfieldController,
                      keyboardType: TextInputType.name,
                      onSaved: (newValue) {
                        if (newValue != null) {
                          _loggedUser.linkedAccounts[index].accountName =
                              newValue;
                        }
                      },
                      onChanged: (value) {
                        setDialogState(() {
                          if (value.isEmpty) {
                            _isSaveEnabled = false;
                          } else {
                            _isSaveEnabled = true;
                          }
                        });
                      },
                      decoration: InputDecoration(
                        counterStyle: theme.textTheme.labelSmall,
                        hintText: linkedAccounts[index].accountName,
                        errorStyle: theme.textTheme.labelSmall!.copyWith(
                          color: Colors.red,
                        ),
                        errorMaxLines: 2,
                      ),
                    ),
                    Row(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            //close the dialogbox when the button is pressed
                            _closeDialoge(context);

                            Future.delayed(Duration(seconds: 1), () {
                              //clear the textvalue of controller
                              _dialogTextfieldController.clear();
                            });
                          },
                          child: Text('Cancel'),
                        ),

                        TextButton(
                          onPressed: _isSaveEnabled
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      //update the LinkedAccount name
                                      _formKey.currentState!.save();
                                      //close the dialogbox after saving
                                      _closeDialoge(context);
                                      //clear the textvalue of controller
                                      _dialogTextfieldController.clear();
                                    });
                                  }
                                }
                              : null,
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  //Main UI
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

  // ==========================//
  // PRIVATE UI HELPER METHODS //
  // ==========================//

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
              _buildUnlinkDialoguBox(
                context,
                index,
                _loggedUser.linkedAccounts,
              );
            },
            backgroundColor: const Color(0xFFC50014),
            foregroundColor: theme.colorScheme.onSecondary,
            icon: Icons.delete,
            label: 'Unlink',
          ),
          SlidableAction(
            onPressed: (context) {
              setState(() {
                //build dialog
                _buildEditDialogBox(
                  context,
                  index,
                  _loggedUser.linkedAccounts,
                  theme,
                );
              });
            },
            backgroundColor: const Color(0xFF0392CF),
            foregroundColor: theme.colorScheme.onSecondary,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  //Push to AccountInformationPage and return a triggerable String stored in result variable
                  final result = await Navigator.pushNamed(
                    context,
                    '/accountinformation',
                    arguments: _loggedUser.linkedAccounts[index],
                  );

                  //When the Account Information Page pressed the delete button it will return
                  //a 'delete string to a variable result'
                  //if the condition is met this will delete the current linked account on the list , the slidable controller on the list
                  //and dispose the controller that has been removed from the SlidableController
                  if (result == 'delete') {
                    setState(() {
                      //removed the target UserLinked LinkedAccount
                      _loggedUser.linkedAccounts.removeAt(index);

                      //dispose the current Linked Account controller
                      final targetController = _slidableController.removeAt(
                        index,
                      );
                      targetController.dispose();

                      //after it successfully the item on the list and dipose the controller
                      //the List of LinkedAccount length and the Slidable Controller will be updated
                    });
                  }
                },
                child: Container(
                  //used transparent to expand the box for Gesture Detector , without the color the onTap won't fire
                  color: Colors.transparent,
                  height: 70,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 7,
                        children: [
                          Text(
                            _userInterfaceService.formatAccountNumber(
                              accountNumber: _loggedUser
                                  .linkedAccounts[index]
                                  .accountNumber,
                            ),
                            style: theme.textTheme.titleLarge,
                          ),
                          StatusIndicator(
                            isActive: linkedAccounts[index].isActive,
                          ),
                        ],
                      ),
                      Text(
                        linkedAccounts[index].accountName,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
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

          //when the user press back, rebuild the page and create sliding controller
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
}

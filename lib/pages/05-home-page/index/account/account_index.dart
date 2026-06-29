import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/custom-widgets/colored_container.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';

import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/custom-widgets/separation_divider.dart';
import 'package:myapp/custom-widgets/silver_dotted_border.dart';
import 'package:myapp/custom-widgets/status_indicator.dart';
import 'package:myapp/data-class/constants/custom_action_enum.dart';

import 'package:myapp/data-class/water_account.dart';

import 'package:myapp/providers/auth_provider.dart';

import 'package:myapp/services/link_account_service.dart';
import 'package:myapp/services/masking_service.dart';

class AccountIndex extends ConsumerStatefulWidget {
  const AccountIndex({super.key});

  @override
  ConsumerState<AccountIndex> createState() => _AccountIndexState();
}

class _AccountIndexState extends ConsumerState<AccountIndex>
    with TickerProviderStateMixin {
  //form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //text contorller - for updating name
  final TextEditingController _dialogTextfieldController =
      TextEditingController();

  //service
  final LinkAccountService _linkAccountService = LinkAccountService();
  final MaskingService _maskingService = MaskingService();

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
    //create the controller only when user visit the AccountIndex

    final loggedUser = ref.read(authNotifierProvider);

    if (loggedUser == null) {
      throw ArgumentError.notNull('loggedUser');
    }

    if (loggedUser.linkedAccounts.isNotEmpty) {
      //if user has linked accounts -> create a controller
      // if target is 5 and current is 2, it will add 3 controllers
      while (_slidableController.length < loggedUser.linkedAccounts.length) {
        _slidableController.add(SlidableController(this));
      }
    } else {
      debugPrint('Linked accounts is empty');
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
    } else {
      debugPrint('Slidable Controller is empty');
    }
  }

  // ==================//
  // private methods   //
  // ==================//

  void _unlinkAccount({required int targetIndex, required bool hasDialogBox}) {
    debugPrint('Unlink Triggered');
    //reference only for debugPrinting
    final removedAccount = ref
        .read(authNotifierProvider)
        ?.linkedAccounts[targetIndex];

    //after it successfully removed the item from the list and dipose the controller
    //the List of LinkedAccount length and the Slidable Controller will be adjusted
    final targetContoller = _slidableController.removeAt(targetIndex);
    targetContoller.dispose();

    //Remove the dialogbox
    if (hasDialogBox) {
      context.pop();
    }

    //execute the methond to remove the linked account after the page finish rebuilding
    //(pop page-rebuild-recalculate layout-repaint-execute addPostFrameCallback)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint(
        'Linked Account (${removedAccount?.accountName} / ${removedAccount?.accountNumber} ) and its scrollable controller ($targetContoller) has been removed from the list',
      );

      //remove the linked account and update the authenticated logged account and the simulated database
      ref.read(authNotifierProvider.notifier).removeAccountAtIndex(targetIndex);
    });
  }

  Future<dynamic> _buildUnlinkDialogBox(
    BuildContext context,
    int index,
    List<WaterAccount> linkedAccounts,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          icon: const Icon(Icons.delete),
          title: Text('Unlink ${linkedAccounts[index].accountName}?'),
          content: const Text(
            'Local transaction history for this account will be removed from this device.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _unlinkAccount(targetIndex: index, hasDialogBox: true);
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
              title: const Text('Update Name'),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 20,
                  children: [
                    TextFormField(
                      validator: (value) {
                        return _linkAccountService.validateAccountNameTextField(
                          value,
                        );
                      },
                      maxLength: 15,
                      controller: _dialogTextfieldController,
                      keyboardType: TextInputType.name,
                      onSaved: (value) {
                        if (value == null || value.trim().isEmpty) return;

                        ref
                            .read(authNotifierProvider.notifier)
                            .updateLinkedAccountNameAtIndex(index, value);
                      },
                      onChanged: (value) {
                        setDialogState(() {
                          _isSaveEnabled = value.isNotEmpty;
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
                            context.pop();

                            Future.delayed(Duration(seconds: 1), () {
                              //clear the textvalue of controller
                              _dialogTextfieldController.clear();
                            });
                          },
                          child: const Text('Cancel'),
                        ),

                        TextButton(
                          onPressed: _isSaveEnabled
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      //update the LinkedAccount name
                                      _formKey.currentState!.save();
                                      //close the dialogbox after saving
                                      context.pop();
                                      //clear the textvalue of controller
                                      _dialogTextfieldController.clear();
                                      //flip back the boolean to false to make the button disabled again
                                      _isSaveEnabled = !_isSaveEnabled;
                                    });
                                  }
                                }
                              : null,
                          child: const Text('Save'),
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
    final ThemeData theme = Theme.of(context);

    final loggedUser = ref.watch(authNotifierProvider);

    if (loggedUser == null) {
      return DisplayNoData();
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 85.0),

            const Align(
              alignment: Alignment.bottomLeft,
              child: Headline(
                headline: 'My Account',
                subHeadline:
                    'Manage your active water connections and service details',
              ),
            ),

            const SizedBox(height: 30),

            //Outer Container
            if (loggedUser.linkedAccounts.isEmpty)
              SilverDottedBorder(
                message: Text(
                  'Link your service connection to view bills and check consumption',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ),
                button: _buildLinkButton(
                  theme,
                  context,
                  loggedUser.linkedAccounts,
                ),
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
                            itemCount: loggedUser.linkedAccounts.length,
                            separatorBuilder: (context, index) => Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
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
                                  linkedAccounts: loggedUser.linkedAccounts,
                                  index: index,
                                  theme: theme,
                                ),
                              );
                            },
                          ),
                        ),
                        _buildLinkButton(
                          theme,
                          context,
                          loggedUser.linkedAccounts,
                        ),
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
      key: ValueKey(linkedAccounts[index].accountNumber),
      controller: _slidableController[index],
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            key: ValueKey(linkedAccounts[index].accountNumber),
            onPressed: (context) {
              _buildUnlinkDialogBox(context, index, linkedAccounts);
            },
            backgroundColor: const Color(0xFFC50014),
            foregroundColor: theme.colorScheme.onSecondary,
            icon: Icons.delete,
            label: 'Unlink',
          ),
          SlidableAction(
            onPressed: (context) {
              //build dialog
              _buildEditDialogBox(context, index, linkedAccounts, theme);
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
                  final result = await context.push(
                    '/home/accountinformation',
                    extra: {'waterAccount': linkedAccounts[index]},
                  );

                  //When the Account Information Page pressed the delete button it will return
                  //a enum delete to variable result
                  //if the condition is met this will delete the current linked account on the list , the slidable controller on the list
                  //and dispose the controller that has been removed from the SlidableController
                  if (result == CustomAction.delete) {
                    debugPrint(
                      'Custom Action ${CustomAction.delete.value} is Triggered',
                    );
                    _unlinkAccount(targetIndex: index, hasDialogBox: false);
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
                            _maskingService.formatAccountNumber(
                              accountNumber:
                                  linkedAccounts[index].accountNumber,
                            ),
                            style: theme.textTheme.titleLarge,
                          ),
                          StatusIndicator(waterAccount: linkedAccounts[index]),
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
          duration: const Duration(microseconds: 500),
          curve: Curves.easeIn,
          child: const Icon(Icons.drag_handle),
        );
      },
    );
  }

  Widget _buildLinkButton(
    ThemeData theme,
    BuildContext context,
    List<WaterAccount> linkedAccounts,
  ) {
    return Align(
      alignment: linkedAccounts.isEmpty
          ? Alignment.center
          : Alignment.centerRight,
      child: FilledButton.icon(
        onPressed: () async {
          //wait for the user to finish linking account
          // await Navigator.pushNamed(context, '/linkaccount');
          await context.push('/linkaccount');

          //when the user press back, rebuild the page and create sliding controller
          setState(() {
            _createSlidingController();
          });
        },
        style: FilledButton.styleFrom(
          padding: const EdgeInsetsGeometry.all(20.0),
          backgroundColor: theme.colorScheme.primaryContainer,
        ),
        icon: const Icon(Icons.add_circle_outline_rounded),
        label: Text('Link Account', style: theme.textTheme.labelLarge),
      ),
    );
  }
}

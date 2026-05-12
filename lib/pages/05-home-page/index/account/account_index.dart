import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/data-bank/account_type.dart';

class AccountIndex extends StatefulWidget {
  const AccountIndex({super.key});

  @override
  State<AccountIndex> createState() => _AccountIndexState();
}

class _AccountIndexState extends State<AccountIndex>
    with SingleTickerProviderStateMixin {
  final _loggedUser = AccountType().owner;

  late final _controller = SlidableController(this);
  double _actionExtent = 0.0;

  double? rotation;

  @override
  void initState() {
    super.initState();

    //sliderAnimation
    _controller.animation.addListener(() {
      setState(() {
        _actionExtent = _controller.animation.value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              decoration: BoxDecoration(
                color: Color(0xFFEEEEFA),
                border: BoxBorder.all(
                  color: const Color(0xFFC8C8E5),
                  width: 3,
                  strokeAlign: -1.0,
                ),
                borderRadius: BorderRadius.circular(13.0),
              ),
              //Inner Container
              child: Container(
                padding: EdgeInsets.zero,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  border: BoxBorder.all(
                    color: Color(0xFFB4B5DB),
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                  borderRadius: BorderRadius.circular(13.0),
                ),
                child: Column(
                  children: [
                    Slidable(
                      key: const ValueKey(0),
                      controller: _controller,
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              debugPrint('$context');
                            },
                            backgroundColor: Color(0xFFC50014),
                            foregroundColor: theme.colorScheme.onSecondary,
                            icon: Icons.delete,
                            label: 'Remove',
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              debugPrint('$context');
                            },
                            backgroundColor: Color(0xFF0392CF),
                            foregroundColor: Colors.white,
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
                                      '591-482-637',
                                      style: theme.textTheme.titleLarge,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        border: Border.all(
                                          color: Color(0xFFE3E3E3),
                                          width: 1.0,
                                          strokeAlign:
                                              BorderSide.strokeAlignInside,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          3.0,
                                        ),
                                      ),
                                      child: Text(
                                        'Active',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text('Zyrus', style: theme.textTheme.bodyLarge),
                              ],
                            ),
                            AnimatedRotation(
                              //Used a Unary Minus Operator (-) to rotate the icon counter clockwise
                              turns: (-_actionExtent / 2),
                              duration: Duration(microseconds: 500),
                              curve: Curves.easeIn,
                              child: Icon(Icons.drag_handle),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/linkaccount');
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateColor.fromMap(
                    <WidgetStatesConstraint, Color>{
                      WidgetState.any: theme.colorScheme.primaryContainer,
                    },
                  ),
                ),
                icon: Icon(Icons.add_circle_outline_rounded),
                label: Text('Link Account', style: theme.textTheme.labelLarge),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

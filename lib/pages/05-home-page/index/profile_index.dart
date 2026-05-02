import 'package:flutter/material.dart';
import 'package:myapp/custom-shapes/profile_border.dart';

import 'package:myapp/custom-widgets/headline.dart';
import 'package:myapp/data-bank/account_type.dart';

class ProfileIndex extends StatefulWidget {
  const ProfileIndex({super.key});

  @override
  State<ProfileIndex> createState() => _ProfileIndexState();
}

class _ProfileIndexState extends State<ProfileIndex> {
  final _loggedUser = AccountType().owner;
  double _containerHeight = 0;
  double _textOpacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      // Check if the widget is still in the tree before calling setState
      if (mounted) {
        setState(() {
          _containerHeight = 300;
          _textOpacity = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipPath(
          clipper: ProfileBorder(),
          clipBehavior: Clip.hardEdge,
          child: AnimatedContainer(
            color: theme.colorScheme.primary,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOut,
            width: MediaQuery.of(context).size.width,
            height: _containerHeight,
            child: _containerHeight < 150
                ? const SizedBox.shrink()
                : Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      Positioned(
                        bottom: 30,
                        left: 160,
                        child: Column(
                          spacing: 20,
                          children: [
                            TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0, end: 50),
                              duration: Duration(seconds: 1),
                              curve: Curves.easeOut,
                              builder: (context, value, child) {
                                return CircleAvatar(
                                  radius: value,
                                  backgroundImage: AssetImage(
                                    _loggedUser.image,
                                  ),
                                );
                              },
                            ),

                            TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0, end: 22),
                              duration: Duration(seconds: 1),
                              curve: Curves.linear,
                              builder: (context, value, child) {
                                return _containerHeight < 150
                                    ? SizedBox.shrink()
                                    : Text(
                                        _loggedUser.nickname,
                                        style: theme.textTheme.headlineMedium!
                                            .copyWith(
                                              color:
                                                  theme.colorScheme.onSecondary,
                                              fontSize: value,
                                            ),
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),

        Text('Phone Number'),
        Text('Phone Number'),
        Text('Phone Number'),
        Text('Phone Number'),
      ],
    );
  }
}

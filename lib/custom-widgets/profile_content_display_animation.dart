import 'package:flutter/material.dart';
import 'package:myapp/data-class/user_account.dart';

class ProfileContentDisplayAnimation extends StatefulWidget {
  const ProfileContentDisplayAnimation({
    super.key,
    required this.loggedUser,
    required this.containerHeight,
    required this.photoSize,
    required this.nameSize,
  });

  final UserAccount loggedUser;
  final double containerHeight;
  final double photoSize;
  final double nameSize;

  @override
  State<ProfileContentDisplayAnimation> createState() =>
      _ProfileContentDisplayAnimationState();
}

class _ProfileContentDisplayAnimationState
    extends State<ProfileContentDisplayAnimation> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 1, end: widget.photoSize),
              duration: Duration(seconds: 1),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return CircleAvatar(
                  radius: value,
                  backgroundImage: AssetImage(widget.loggedUser.image),
                );
              },
            ),

            const SizedBox(height: 20),

            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 1, end: widget.nameSize),
              duration: const Duration(seconds: 1),
              curve: Curves.linear,
              builder: (context, value, child) {
                return widget.containerHeight < 150
                    ? const SizedBox.shrink()
                    : Text(
                        widget.loggedUser.nickname,
                        style: theme.textTheme.headlineMedium!.copyWith(
                          color: theme.colorScheme.onSecondary,
                          fontSize: value,
                        ),
                      );
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

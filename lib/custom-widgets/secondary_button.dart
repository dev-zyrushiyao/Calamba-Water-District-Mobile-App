import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    this.width = 375.00,
    this.height = 60.00,
    this.onPressed,
  });

  final String label;
  final double height;
  final double width;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: Size(width, height),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        textStyle: Theme.of(context).textTheme.labelLarge,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      child: Text(label),
    );
  }
}

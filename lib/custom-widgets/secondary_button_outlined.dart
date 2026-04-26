import 'package:flutter/material.dart';

class SecondaryButtonOutlined extends StatelessWidget {
  const SecondaryButtonOutlined({
    super.key,
    required this.label,
    this.width = 180,
    this.height = 60,
    this.onPressed,
  });

  final double width;
  final double height;
  final String label;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        side: BorderSide(
          width: 1,
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
      ),
    );
  }
}

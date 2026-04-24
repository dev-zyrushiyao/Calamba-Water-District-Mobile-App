import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.width = 375.00,
    this.height = 60.00,
    required this.label,
    this.onPressed,
  });

  final double width;
  final double height;
  final String label;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: Size(width, height),
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      child: Ink(
        height: height,
        width: width,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          gradient: LinearGradient(
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Color(0x993A9AC4),
            ],
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Text(label, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

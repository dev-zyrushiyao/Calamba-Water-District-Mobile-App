import 'package:flutter/material.dart';

class ColoredContainer extends StatefulWidget {
  const ColoredContainer({super.key, this.child});

  final Widget? child;

  @override
  State<ColoredContainer> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ColoredContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: widget.child,
    );
  }
}

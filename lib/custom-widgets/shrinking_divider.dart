import 'package:flutter/material.dart';

class ShrinkingDivider extends StatefulWidget {
  const ShrinkingDivider({super.key, required this.activeDivider});

  final bool activeDivider;

  @override
  State<ShrinkingDivider> createState() => _ShrinkingDividerState();
}

class _ShrinkingDividerState extends State<ShrinkingDivider> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment.centerRight,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutBack,
      width: widget.activeDivider ? 60 : 20,
      decoration: BoxDecoration(
        border: BoxBorder.all(
          color: widget.activeDivider
              ? Theme.of(context).colorScheme.primary
              : Color(0xFFC8C8E5),
          width: 5,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: null,
    );
  }
}

import 'package:flutter/material.dart';

class SeparationDivider extends StatefulWidget {
  const SeparationDivider({super.key, this.thickness});
  final double? thickness;

  @override
  State<SeparationDivider> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SeparationDivider> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Divider(
      color: theme.colorScheme.onPrimaryFixedVariant,
      thickness: widget.thickness,
    );
  }
}

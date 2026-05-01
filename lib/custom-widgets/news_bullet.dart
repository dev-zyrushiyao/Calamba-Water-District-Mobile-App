import 'package:flutter/material.dart';

class NewsBullet extends StatelessWidget {
  const NewsBullet({
    super.key,
    required this.bulletList,
    this.bulletFormat = false,
  });

  final List<String> bulletList;
  final bool bulletFormat;

  String formatList({required List<String> items}) {
    final buffer = StringBuffer();

    for (var item in items) {
      bulletFormat ? buffer.writeln("• $item") : buffer.writeln(item);
      buffer.writeln("");
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      child: Text(
        formatList(items: bulletList),
        style: theme.textTheme.bodyLarge,
      ),
    );
  }
}

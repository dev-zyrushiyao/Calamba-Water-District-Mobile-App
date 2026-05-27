import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';

class SilverDottedBorder extends StatelessWidget {
  const SilverDottedBorder({
    super.key,
    required this.message,
    this.button,
    this.height = 550,
  });

  final Widget? button;
  final Text? message;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: DottedBorder(
            options: RoundedRectDottedBorderOptions(
              color: Colors.grey[400]!,
              strokeWidth: 4,
              radius: const Radius.circular(13.0),
              dashPattern: [20, 10],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 25,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: message,
                ),
                button ?? SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

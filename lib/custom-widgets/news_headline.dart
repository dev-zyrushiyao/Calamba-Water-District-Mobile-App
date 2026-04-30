import 'package:flutter/material.dart';

class NewsHeadline extends StatelessWidget {
  const NewsHeadline({super.key, required this.data});

  final Map<String?, String?> data;

  @override
  Widget build(BuildContext context) {
    String? headline = data["headline"];
    String? subheadline = data["subheadline"];

    return Column(
      children: [
        if (headline != null) Text(headline),
        if (subheadline != null) Text(subheadline),
      ],
    );
  }
}

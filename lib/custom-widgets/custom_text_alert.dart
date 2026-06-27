import 'package:flutter/material.dart';

class CustomTextAlert extends StatelessWidget {
  const CustomTextAlert({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
      ),
    );
  }
}

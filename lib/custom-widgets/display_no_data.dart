import 'package:flutter/material.dart';

class DisplayNoData extends StatefulWidget {
  const DisplayNoData({super.key});

  @override
  State<DisplayNoData> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DisplayNoData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('404 Data not found')),
    );
  }
}

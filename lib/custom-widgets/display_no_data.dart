import 'package:flutter/material.dart';

class DisplayNoData extends StatefulWidget {
  const DisplayNoData({super.key});

  @override
  State<DisplayNoData> createState() => _DisplayNoData();
}

class _DisplayNoData extends State<DisplayNoData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('404 Data not found')),
    );
  }
}

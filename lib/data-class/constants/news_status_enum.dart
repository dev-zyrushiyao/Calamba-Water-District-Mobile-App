import 'package:flutter/material.dart';

enum NewsStatus {
  ongoing('On Going Repair'),
  resolved('Issue Resolved'),
  monitoring('Currently Monitoring');

  final String value;
  const NewsStatus(this.value);

  Color get color {
    switch (this) {
      case NewsStatus.ongoing:
        return Colors.yellow;
      case NewsStatus.resolved:
        return Colors.green;
      case NewsStatus.monitoring:
        return Colors.pink;
    }
  }
}

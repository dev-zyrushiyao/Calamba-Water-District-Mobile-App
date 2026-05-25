import 'package:flutter/material.dart';

class SupportShape3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = Color(0xffC8C8E5);
    path = Path();
    path.lineTo(size.width * 1.11, size.height * 0.95);
    path.cubicTo(
      size.width * 1.11,
      size.height * 0.97,
      size.width * 1.11,
      size.height * 0.98,
      size.width * 1.11,
      size.height,
    );
    path.cubicTo(
      size.width * 1.1,
      size.height * 1.05,
      size.width * 1.05,
      size.height * 1.1,
      size.width,
      size.height * 1.11,
    );
    path.cubicTo(
      size.width * 0.98,
      size.height * 1.11,
      size.width * 0.97,
      size.height * 1.11,
      size.width * 0.95,
      size.height * 1.11,
    );
    path.cubicTo(
      size.width * 0.95,
      size.height * 1.11,
      size.width * 0.28,
      size.height * 1.11,
      size.width * 0.28,
      size.height * 1.11,
    );
    path.cubicTo(
      size.width * 0.26,
      size.height * 1.11,
      size.width / 4,
      size.height * 1.11,
      size.width * 0.24,
      size.height * 1.11,
    );
    path.cubicTo(
      size.width * 0.17,
      size.height * 1.1,
      size.width * 0.12,
      size.height * 1.05,
      size.width * 0.11,
      size.height,
    );
    path.cubicTo(
      size.width * 0.11,
      size.height * 0.98,
      size.width * 0.11,
      size.height * 0.97,
      size.width * 0.11,
      size.height * 0.95,
    );
    path.cubicTo(
      size.width * 0.11,
      size.height * 0.95,
      size.width * 0.11,
      size.height * 0.61,
      size.width * 0.11,
      size.height * 0.61,
    );
    path.cubicTo(
      size.width * 0.11,
      size.height * 0.34,
      size.width * 0.34,
      size.height * 0.11,
      size.width * 0.61,
      size.height * 0.11,
    );
    path.cubicTo(
      size.width * 0.89,
      size.height * 0.11,
      size.width * 1.11,
      size.height * 0.34,
      size.width * 1.11,
      size.height * 0.61,
    );
    path.cubicTo(
      size.width * 1.11,
      size.height * 0.61,
      size.width * 1.11,
      size.height * 0.95,
      size.width * 1.11,
      size.height * 0.95,
    );
    path.cubicTo(
      size.width * 1.11,
      size.height * 0.95,
      size.width * 1.11,
      size.height * 0.95,
      size.width * 1.11,
      size.height * 0.95,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

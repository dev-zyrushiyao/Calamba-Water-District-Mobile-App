import 'package:flutter/material.dart';

class SupportShape5 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = Color(0xffDBDBF0);
    path = Path();
    path.lineTo(size.width * 0.07, size.height / 2);
    path.cubicTo(
      size.width * 0.03,
      size.height * 0.45,
      0,
      size.height * 0.38,
      0,
      size.height * 0.3,
    );
    path.cubicTo(
      0,
      size.height * 0.14,
      size.width * 0.14,
      0,
      size.width * 0.3,
      0,
    );
    path.cubicTo(
      size.width * 0.38,
      0,
      size.width * 0.45,
      size.height * 0.03,
      size.width / 2,
      size.height * 0.07,
    );
    path.cubicTo(
      size.width * 0.55,
      size.height * 0.03,
      size.width * 0.62,
      0,
      size.width * 0.7,
      0,
    );
    path.cubicTo(
      size.width * 0.86,
      0,
      size.width,
      size.height * 0.14,
      size.width,
      size.height * 0.3,
    );
    path.cubicTo(
      size.width,
      size.height * 0.38,
      size.width * 0.97,
      size.height * 0.45,
      size.width * 0.93,
      size.height / 2,
    );
    path.cubicTo(
      size.width * 0.97,
      size.height * 0.55,
      size.width,
      size.height * 0.62,
      size.width,
      size.height * 0.7,
    );
    path.cubicTo(
      size.width,
      size.height * 0.86,
      size.width * 0.86,
      size.height,
      size.width * 0.7,
      size.height,
    );
    path.cubicTo(
      size.width * 0.62,
      size.height,
      size.width * 0.55,
      size.height * 0.97,
      size.width / 2,
      size.height * 0.93,
    );
    path.cubicTo(
      size.width * 0.45,
      size.height * 0.97,
      size.width * 0.38,
      size.height,
      size.width * 0.3,
      size.height,
    );
    path.cubicTo(
      size.width * 0.14,
      size.height,
      0,
      size.height * 0.86,
      0,
      size.height * 0.7,
    );
    path.cubicTo(
      0,
      size.height * 0.62,
      size.width * 0.03,
      size.height * 0.55,
      size.width * 0.07,
      size.height / 2,
    );
    path.cubicTo(
      size.width * 0.07,
      size.height / 2,
      size.width * 0.07,
      size.height / 2,
      size.width * 0.07,
      size.height / 2,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

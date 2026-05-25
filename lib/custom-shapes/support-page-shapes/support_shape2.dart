import 'package:flutter/material.dart';

class SupportShape2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = Color(0xffA1A2D0);
    path = Path();
    path.lineTo(size.width * 0.86, size.height * 0.22);
    path.cubicTo(
      size.width * 0.9,
      size.height * 0.22,
      size.width * 0.91,
      size.height * 0.22,
      size.width * 0.92,
      size.height * 0.22,
    );
    path.cubicTo(
      size.width * 0.94,
      size.height * 0.23,
      size.width * 0.96,
      size.height / 4,
      size.width * 0.96,
      size.height * 0.26,
    );
    path.cubicTo(
      size.width * 0.97,
      size.height * 0.28,
      size.width * 0.97,
      size.height * 0.29,
      size.width * 0.97,
      size.height * 0.32,
    );
    path.cubicTo(
      size.width * 0.97,
      size.height * 0.32,
      size.width * 0.98,
      size.height * 0.39,
      size.width * 0.98,
      size.height * 0.39,
    );
    path.cubicTo(
      size.width * 0.98,
      size.height * 0.41,
      size.width * 0.98,
      size.height * 0.41,
      size.width * 0.98,
      size.height * 0.42,
    );
    path.cubicTo(
      size.width * 0.98,
      size.height * 0.43,
      size.width,
      size.height * 0.44,
      size.width,
      size.height * 0.44,
    );
    path.cubicTo(
      size.width,
      size.height * 0.45,
      size.width,
      size.height * 0.45,
      size.width,
      size.height * 0.46,
    );
    path.cubicTo(
      size.width,
      size.height * 0.46,
      size.width * 1.05,
      size.height * 0.52,
      size.width * 1.05,
      size.height * 0.52,
    );
    path.cubicTo(
      size.width * 1.07,
      size.height * 0.54,
      size.width * 1.08,
      size.height * 0.55,
      size.width * 1.09,
      size.height * 0.56,
    );
    path.cubicTo(
      size.width * 1.1,
      size.height * 0.58,
      size.width * 1.1,
      size.height * 0.6,
      size.width * 1.09,
      size.height * 0.62,
    );
    path.cubicTo(
      size.width * 1.08,
      size.height * 0.64,
      size.width * 1.07,
      size.height * 0.65,
      size.width * 1.05,
      size.height * 0.67,
    );
    path.cubicTo(
      size.width * 1.05,
      size.height * 0.67,
      size.width,
      size.height * 0.72,
      size.width,
      size.height * 0.72,
    );
    path.cubicTo(
      size.width,
      size.height * 0.73,
      size.width,
      size.height * 0.74,
      size.width,
      size.height * 0.74,
    );
    path.cubicTo(
      size.width,
      size.height * 0.75,
      size.width * 0.98,
      size.height * 0.76,
      size.width * 0.98,
      size.height * 0.77,
    );
    path.cubicTo(
      size.width * 0.98,
      size.height * 0.77,
      size.width * 0.98,
      size.height * 0.78,
      size.width * 0.98,
      size.height * 0.79,
    );
    path.cubicTo(
      size.width * 0.98,
      size.height * 0.79,
      size.width * 0.97,
      size.height * 0.86,
      size.width * 0.97,
      size.height * 0.86,
    );
    path.cubicTo(
      size.width * 0.97,
      size.height * 0.9,
      size.width * 0.97,
      size.height * 0.91,
      size.width * 0.96,
      size.height * 0.92,
    );
    path.cubicTo(
      size.width * 0.96,
      size.height * 0.94,
      size.width * 0.94,
      size.height * 0.96,
      size.width * 0.92,
      size.height * 0.96,
    );
    path.cubicTo(
      size.width * 0.91,
      size.height * 0.97,
      size.width * 0.9,
      size.height * 0.97,
      size.width * 0.86,
      size.height * 0.97,
    );
    path.cubicTo(
      size.width * 0.86,
      size.height * 0.97,
      size.width * 0.79,
      size.height * 0.98,
      size.width * 0.79,
      size.height * 0.98,
    );
    path.cubicTo(
      size.width * 0.78,
      size.height * 0.98,
      size.width * 0.77,
      size.height * 0.98,
      size.width * 0.77,
      size.height * 0.98,
    );
    path.cubicTo(
      size.width * 0.76,
      size.height * 0.98,
      size.width * 0.75,
      size.height,
      size.width * 0.74,
      size.height,
    );
    path.cubicTo(
      size.width * 0.74,
      size.height,
      size.width * 0.73,
      size.height,
      size.width * 0.72,
      size.height,
    );
    path.cubicTo(
      size.width * 0.72,
      size.height,
      size.width * 0.67,
      size.height * 1.05,
      size.width * 0.67,
      size.height * 1.05,
    );
    path.cubicTo(
      size.width * 0.65,
      size.height * 1.07,
      size.width * 0.64,
      size.height * 1.08,
      size.width * 0.62,
      size.height * 1.09,
    );
    path.cubicTo(
      size.width * 0.6,
      size.height * 1.1,
      size.width * 0.58,
      size.height * 1.1,
      size.width * 0.56,
      size.height * 1.09,
    );
    path.cubicTo(
      size.width * 0.55,
      size.height * 1.08,
      size.width * 0.54,
      size.height * 1.07,
      size.width * 0.52,
      size.height * 1.05,
    );
    path.cubicTo(
      size.width * 0.52,
      size.height * 1.05,
      size.width * 0.46,
      size.height,
      size.width * 0.46,
      size.height,
    );
    path.cubicTo(
      size.width * 0.45,
      size.height,
      size.width * 0.45,
      size.height,
      size.width * 0.44,
      size.height,
    );
    path.cubicTo(
      size.width * 0.44,
      size.height,
      size.width * 0.43,
      size.height * 0.98,
      size.width * 0.42,
      size.height * 0.98,
    );
    path.cubicTo(
      size.width * 0.41,
      size.height * 0.98,
      size.width * 0.41,
      size.height * 0.98,
      size.width * 0.39,
      size.height * 0.98,
    );
    path.cubicTo(
      size.width * 0.39,
      size.height * 0.98,
      size.width * 0.32,
      size.height * 0.97,
      size.width * 0.32,
      size.height * 0.97,
    );
    path.cubicTo(
      size.width * 0.29,
      size.height * 0.97,
      size.width * 0.28,
      size.height * 0.97,
      size.width * 0.26,
      size.height * 0.96,
    );
    path.cubicTo(
      size.width / 4,
      size.height * 0.96,
      size.width * 0.23,
      size.height * 0.94,
      size.width * 0.22,
      size.height * 0.92,
    );
    path.cubicTo(
      size.width * 0.22,
      size.height * 0.91,
      size.width * 0.22,
      size.height * 0.9,
      size.width * 0.22,
      size.height * 0.86,
    );
    path.cubicTo(
      size.width * 0.22,
      size.height * 0.86,
      size.width / 5,
      size.height * 0.79,
      size.width / 5,
      size.height * 0.79,
    );
    path.cubicTo(
      size.width / 5,
      size.height * 0.78,
      size.width / 5,
      size.height * 0.77,
      size.width / 5,
      size.height * 0.77,
    );
    path.cubicTo(
      size.width / 5,
      size.height * 0.76,
      size.width / 5,
      size.height * 0.75,
      size.width / 5,
      size.height * 0.74,
    );
    path.cubicTo(
      size.width * 0.19,
      size.height * 0.74,
      size.width * 0.19,
      size.height * 0.73,
      size.width * 0.18,
      size.height * 0.72,
    );
    path.cubicTo(
      size.width * 0.18,
      size.height * 0.72,
      size.width * 0.13,
      size.height * 0.67,
      size.width * 0.13,
      size.height * 0.67,
    );
    path.cubicTo(
      size.width * 0.11,
      size.height * 0.65,
      size.width * 0.1,
      size.height * 0.64,
      size.width * 0.1,
      size.height * 0.62,
    );
    path.cubicTo(
      size.width * 0.09,
      size.height * 0.6,
      size.width * 0.09,
      size.height * 0.58,
      size.width * 0.1,
      size.height * 0.56,
    );
    path.cubicTo(
      size.width * 0.1,
      size.height * 0.55,
      size.width * 0.11,
      size.height * 0.54,
      size.width * 0.13,
      size.height * 0.52,
    );
    path.cubicTo(
      size.width * 0.13,
      size.height * 0.52,
      size.width * 0.18,
      size.height * 0.46,
      size.width * 0.18,
      size.height * 0.46,
    );
    path.cubicTo(
      size.width * 0.19,
      size.height * 0.45,
      size.width * 0.19,
      size.height * 0.45,
      size.width / 5,
      size.height * 0.44,
    );
    path.cubicTo(
      size.width / 5,
      size.height * 0.44,
      size.width / 5,
      size.height * 0.43,
      size.width / 5,
      size.height * 0.42,
    );
    path.cubicTo(
      size.width / 5,
      size.height * 0.41,
      size.width / 5,
      size.height * 0.41,
      size.width / 5,
      size.height * 0.39,
    );
    path.cubicTo(
      size.width / 5,
      size.height * 0.39,
      size.width * 0.22,
      size.height * 0.32,
      size.width * 0.22,
      size.height * 0.32,
    );
    path.cubicTo(
      size.width * 0.22,
      size.height * 0.29,
      size.width * 0.22,
      size.height * 0.28,
      size.width * 0.22,
      size.height * 0.26,
    );
    path.cubicTo(
      size.width * 0.23,
      size.height / 4,
      size.width / 4,
      size.height * 0.23,
      size.width * 0.26,
      size.height * 0.22,
    );
    path.cubicTo(
      size.width * 0.28,
      size.height * 0.22,
      size.width * 0.29,
      size.height * 0.22,
      size.width * 0.32,
      size.height * 0.22,
    );
    path.cubicTo(
      size.width * 0.32,
      size.height * 0.22,
      size.width * 0.39,
      size.height / 5,
      size.width * 0.39,
      size.height / 5,
    );
    path.cubicTo(
      size.width * 0.41,
      size.height / 5,
      size.width * 0.41,
      size.height / 5,
      size.width * 0.42,
      size.height / 5,
    );
    path.cubicTo(
      size.width * 0.43,
      size.height / 5,
      size.width * 0.44,
      size.height / 5,
      size.width * 0.44,
      size.height / 5,
    );
    path.cubicTo(
      size.width * 0.45,
      size.height * 0.19,
      size.width * 0.45,
      size.height * 0.19,
      size.width * 0.46,
      size.height * 0.18,
    );
    path.cubicTo(
      size.width * 0.46,
      size.height * 0.18,
      size.width * 0.52,
      size.height * 0.13,
      size.width * 0.52,
      size.height * 0.13,
    );
    path.cubicTo(
      size.width * 0.54,
      size.height * 0.11,
      size.width * 0.55,
      size.height * 0.1,
      size.width * 0.56,
      size.height * 0.1,
    );
    path.cubicTo(
      size.width * 0.58,
      size.height * 0.09,
      size.width * 0.6,
      size.height * 0.09,
      size.width * 0.62,
      size.height * 0.1,
    );
    path.cubicTo(
      size.width * 0.64,
      size.height * 0.1,
      size.width * 0.65,
      size.height * 0.11,
      size.width * 0.67,
      size.height * 0.13,
    );
    path.cubicTo(
      size.width * 0.67,
      size.height * 0.13,
      size.width * 0.72,
      size.height * 0.18,
      size.width * 0.72,
      size.height * 0.18,
    );
    path.cubicTo(
      size.width * 0.73,
      size.height * 0.19,
      size.width * 0.74,
      size.height * 0.19,
      size.width * 0.74,
      size.height / 5,
    );
    path.cubicTo(
      size.width * 0.75,
      size.height / 5,
      size.width * 0.76,
      size.height / 5,
      size.width * 0.77,
      size.height / 5,
    );
    path.cubicTo(
      size.width * 0.77,
      size.height / 5,
      size.width * 0.78,
      size.height / 5,
      size.width * 0.79,
      size.height / 5,
    );
    path.cubicTo(
      size.width * 0.79,
      size.height / 5,
      size.width * 0.86,
      size.height * 0.22,
      size.width * 0.86,
      size.height * 0.22,
    );
    path.cubicTo(
      size.width * 0.86,
      size.height * 0.22,
      size.width * 0.86,
      size.height * 0.22,
      size.width * 0.86,
      size.height * 0.22,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

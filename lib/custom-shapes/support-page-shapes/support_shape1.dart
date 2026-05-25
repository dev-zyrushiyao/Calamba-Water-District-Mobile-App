import 'package:flutter/material.dart';

//https://www.flutterclutter.dev/tools/svg-to-flutter-path-converter/

class SupportShape1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = Color(0xff252675);
    path = Path();
    path.lineTo(size.width * 0.77, size.height * 0.12);
    path.cubicTo(
      size.width * 0.8,
      size.height * 0.12,
      size.width * 0.82,
      size.height * 0.12,
      size.width * 0.83,
      size.height * 0.13,
    );
    path.cubicTo(
      size.width * 0.85,
      size.height * 0.14,
      size.width * 0.86,
      size.height * 0.15,
      size.width * 0.87,
      size.height * 0.17,
    );
    path.cubicTo(
      size.width * 0.88,
      size.height * 0.18,
      size.width * 0.88,
      size.height / 5,
      size.width * 0.88,
      size.height * 0.23,
    );
    path.cubicTo(
      size.width * 0.88,
      size.height * 0.23,
      size.width * 0.88,
      size.height * 0.3,
      size.width * 0.88,
      size.height * 0.3,
    );
    path.cubicTo(
      size.width * 0.88,
      size.height * 0.31,
      size.width * 0.88,
      size.height * 0.32,
      size.width * 0.89,
      size.height / 3,
    );
    path.cubicTo(
      size.width * 0.89,
      size.height / 3,
      size.width * 0.89,
      size.height * 0.34,
      size.width * 0.9,
      size.height * 0.35,
    );
    path.cubicTo(
      size.width * 0.9,
      size.height * 0.36,
      size.width * 0.9,
      size.height * 0.36,
      size.width * 0.91,
      size.height * 0.37,
    );
    path.cubicTo(
      size.width * 0.91,
      size.height * 0.37,
      size.width * 0.96,
      size.height * 0.42,
      size.width * 0.96,
      size.height * 0.42,
    );
    path.cubicTo(
      size.width * 0.98,
      size.height * 0.45,
      size.width,
      size.height * 0.46,
      size.width,
      size.height * 0.47,
    );
    path.cubicTo(
      size.width,
      size.height * 0.49,
      size.width,
      size.height * 0.51,
      size.width,
      size.height * 0.53,
    );
    path.cubicTo(
      size.width,
      size.height * 0.54,
      size.width * 0.98,
      size.height * 0.55,
      size.width * 0.96,
      size.height * 0.58,
    );
    path.cubicTo(
      size.width * 0.96,
      size.height * 0.58,
      size.width * 0.91,
      size.height * 0.63,
      size.width * 0.91,
      size.height * 0.63,
    );
    path.cubicTo(
      size.width * 0.9,
      size.height * 0.64,
      size.width * 0.9,
      size.height * 0.64,
      size.width * 0.9,
      size.height * 0.65,
    );
    path.cubicTo(
      size.width * 0.89,
      size.height * 0.66,
      size.width * 0.89,
      size.height * 0.67,
      size.width * 0.89,
      size.height * 0.67,
    );
    path.cubicTo(
      size.width * 0.88,
      size.height * 0.68,
      size.width * 0.88,
      size.height * 0.69,
      size.width * 0.88,
      size.height * 0.7,
    );
    path.cubicTo(
      size.width * 0.88,
      size.height * 0.7,
      size.width * 0.88,
      size.height * 0.77,
      size.width * 0.88,
      size.height * 0.77,
    );
    path.cubicTo(
      size.width * 0.88,
      size.height * 0.8,
      size.width * 0.88,
      size.height * 0.82,
      size.width * 0.87,
      size.height * 0.83,
    );
    path.cubicTo(
      size.width * 0.86,
      size.height * 0.85,
      size.width * 0.85,
      size.height * 0.86,
      size.width * 0.83,
      size.height * 0.87,
    );
    path.cubicTo(
      size.width * 0.82,
      size.height * 0.88,
      size.width * 0.8,
      size.height * 0.88,
      size.width * 0.77,
      size.height * 0.88,
    );
    path.cubicTo(
      size.width * 0.77,
      size.height * 0.88,
      size.width * 0.7,
      size.height * 0.88,
      size.width * 0.7,
      size.height * 0.88,
    );
    path.cubicTo(
      size.width * 0.69,
      size.height * 0.88,
      size.width * 0.68,
      size.height * 0.88,
      size.width * 0.67,
      size.height * 0.89,
    );
    path.cubicTo(
      size.width * 0.67,
      size.height * 0.89,
      size.width * 0.66,
      size.height * 0.89,
      size.width * 0.65,
      size.height * 0.9,
    );
    path.cubicTo(
      size.width * 0.64,
      size.height * 0.9,
      size.width * 0.64,
      size.height * 0.9,
      size.width * 0.63,
      size.height * 0.91,
    );
    path.cubicTo(
      size.width * 0.63,
      size.height * 0.91,
      size.width * 0.58,
      size.height * 0.96,
      size.width * 0.58,
      size.height * 0.96,
    );
    path.cubicTo(
      size.width * 0.55,
      size.height * 0.98,
      size.width * 0.54,
      size.height,
      size.width * 0.53,
      size.height,
    );
    path.cubicTo(
      size.width * 0.51,
      size.height,
      size.width * 0.49,
      size.height,
      size.width * 0.47,
      size.height,
    );
    path.cubicTo(
      size.width * 0.46,
      size.height,
      size.width * 0.45,
      size.height * 0.98,
      size.width * 0.42,
      size.height * 0.96,
    );
    path.cubicTo(
      size.width * 0.42,
      size.height * 0.96,
      size.width * 0.37,
      size.height * 0.91,
      size.width * 0.37,
      size.height * 0.91,
    );
    path.cubicTo(
      size.width * 0.36,
      size.height * 0.9,
      size.width * 0.36,
      size.height * 0.9,
      size.width * 0.35,
      size.height * 0.9,
    );
    path.cubicTo(
      size.width * 0.34,
      size.height * 0.89,
      size.width / 3,
      size.height * 0.89,
      size.width / 3,
      size.height * 0.89,
    );
    path.cubicTo(
      size.width * 0.32,
      size.height * 0.88,
      size.width * 0.31,
      size.height * 0.88,
      size.width * 0.3,
      size.height * 0.88,
    );
    path.cubicTo(
      size.width * 0.3,
      size.height * 0.88,
      size.width * 0.23,
      size.height * 0.88,
      size.width * 0.23,
      size.height * 0.88,
    );
    path.cubicTo(
      size.width / 5,
      size.height * 0.88,
      size.width * 0.18,
      size.height * 0.88,
      size.width * 0.17,
      size.height * 0.87,
    );
    path.cubicTo(
      size.width * 0.15,
      size.height * 0.86,
      size.width * 0.14,
      size.height * 0.85,
      size.width * 0.13,
      size.height * 0.83,
    );
    path.cubicTo(
      size.width * 0.12,
      size.height * 0.82,
      size.width * 0.12,
      size.height * 0.8,
      size.width * 0.12,
      size.height * 0.77,
    );
    path.cubicTo(
      size.width * 0.12,
      size.height * 0.77,
      size.width * 0.12,
      size.height * 0.7,
      size.width * 0.12,
      size.height * 0.7,
    );
    path.cubicTo(
      size.width * 0.12,
      size.height * 0.69,
      size.width * 0.12,
      size.height * 0.68,
      size.width * 0.11,
      size.height * 0.67,
    );
    path.cubicTo(
      size.width * 0.11,
      size.height * 0.67,
      size.width * 0.11,
      size.height * 0.66,
      size.width * 0.1,
      size.height * 0.65,
    );
    path.cubicTo(
      size.width * 0.1,
      size.height * 0.64,
      size.width * 0.1,
      size.height * 0.64,
      size.width * 0.09,
      size.height * 0.63,
    );
    path.cubicTo(
      size.width * 0.09,
      size.height * 0.63,
      size.width * 0.04,
      size.height * 0.58,
      size.width * 0.04,
      size.height * 0.58,
    );
    path.cubicTo(
      size.width * 0.02,
      size.height * 0.55,
      size.width * 0.01,
      size.height * 0.54,
      size.width * 0.01,
      size.height * 0.53,
    );
    path.cubicTo(
      0,
      size.height * 0.51,
      0,
      size.height * 0.49,
      size.width * 0.01,
      size.height * 0.47,
    );
    path.cubicTo(
      size.width * 0.01,
      size.height * 0.46,
      size.width * 0.02,
      size.height * 0.45,
      size.width * 0.04,
      size.height * 0.42,
    );
    path.cubicTo(
      size.width * 0.04,
      size.height * 0.42,
      size.width * 0.09,
      size.height * 0.37,
      size.width * 0.09,
      size.height * 0.37,
    );
    path.cubicTo(
      size.width * 0.1,
      size.height * 0.36,
      size.width * 0.1,
      size.height * 0.36,
      size.width * 0.1,
      size.height * 0.35,
    );
    path.cubicTo(
      size.width * 0.11,
      size.height * 0.34,
      size.width * 0.11,
      size.height / 3,
      size.width * 0.11,
      size.height / 3,
    );
    path.cubicTo(
      size.width * 0.12,
      size.height * 0.32,
      size.width * 0.12,
      size.height * 0.31,
      size.width * 0.12,
      size.height * 0.3,
    );
    path.cubicTo(
      size.width * 0.12,
      size.height * 0.3,
      size.width * 0.12,
      size.height * 0.23,
      size.width * 0.12,
      size.height * 0.23,
    );
    path.cubicTo(
      size.width * 0.12,
      size.height / 5,
      size.width * 0.12,
      size.height * 0.18,
      size.width * 0.13,
      size.height * 0.17,
    );
    path.cubicTo(
      size.width * 0.14,
      size.height * 0.15,
      size.width * 0.15,
      size.height * 0.14,
      size.width * 0.17,
      size.height * 0.13,
    );
    path.cubicTo(
      size.width * 0.18,
      size.height * 0.12,
      size.width / 5,
      size.height * 0.12,
      size.width * 0.23,
      size.height * 0.12,
    );
    path.cubicTo(
      size.width * 0.23,
      size.height * 0.12,
      size.width * 0.3,
      size.height * 0.12,
      size.width * 0.3,
      size.height * 0.12,
    );
    path.cubicTo(
      size.width * 0.31,
      size.height * 0.12,
      size.width * 0.32,
      size.height * 0.12,
      size.width / 3,
      size.height * 0.11,
    );
    path.cubicTo(
      size.width / 3,
      size.height * 0.11,
      size.width * 0.34,
      size.height * 0.11,
      size.width * 0.35,
      size.height * 0.1,
    );
    path.cubicTo(
      size.width * 0.36,
      size.height * 0.1,
      size.width * 0.36,
      size.height * 0.1,
      size.width * 0.37,
      size.height * 0.09,
    );
    path.cubicTo(
      size.width * 0.37,
      size.height * 0.09,
      size.width * 0.42,
      size.height * 0.04,
      size.width * 0.42,
      size.height * 0.04,
    );
    path.cubicTo(
      size.width * 0.45,
      size.height * 0.02,
      size.width * 0.46,
      size.height * 0.01,
      size.width * 0.47,
      size.height * 0.01,
    );
    path.cubicTo(
      size.width * 0.49,
      0,
      size.width * 0.51,
      0,
      size.width * 0.53,
      size.height * 0.01,
    );
    path.cubicTo(
      size.width * 0.54,
      size.height * 0.01,
      size.width * 0.55,
      size.height * 0.02,
      size.width * 0.58,
      size.height * 0.04,
    );
    path.cubicTo(
      size.width * 0.58,
      size.height * 0.04,
      size.width * 0.63,
      size.height * 0.09,
      size.width * 0.63,
      size.height * 0.09,
    );
    path.cubicTo(
      size.width * 0.64,
      size.height * 0.1,
      size.width * 0.64,
      size.height * 0.1,
      size.width * 0.65,
      size.height * 0.1,
    );
    path.cubicTo(
      size.width * 0.66,
      size.height * 0.11,
      size.width * 0.67,
      size.height * 0.11,
      size.width * 0.67,
      size.height * 0.11,
    );
    path.cubicTo(
      size.width * 0.68,
      size.height * 0.12,
      size.width * 0.69,
      size.height * 0.12,
      size.width * 0.7,
      size.height * 0.12,
    );
    path.cubicTo(
      size.width * 0.7,
      size.height * 0.12,
      size.width * 0.77,
      size.height * 0.12,
      size.width * 0.77,
      size.height * 0.12,
    );
    path.cubicTo(
      size.width * 0.77,
      size.height * 0.12,
      size.width * 0.77,
      size.height * 0.12,
      size.width * 0.77,
      size.height * 0.12,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

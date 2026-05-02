import 'package:flutter/material.dart';

//https://www.flutterclutter.dev/tools/svg-to-flutter-path-converter/

class ProfileBorder extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xAxis = size.width / 412.05;
    final double yAxis = size.height / 388;
    path.lineTo(0 * xAxis, 0 * yAxis);
    path.cubicTo(
      0 * xAxis,
      0 * yAxis,
      412 * xAxis,
      0 * yAxis,
      412 * xAxis,
      0 * yAxis,
    );
    path.cubicTo(
      412 * xAxis,
      0 * yAxis,
      412 * xAxis,
      365.003 * yAxis,
      412 * xAxis,
      365.003 * yAxis,
    );
    path.cubicTo(
      412 * xAxis,
      365.003 * yAxis,
      409 * xAxis,
      388.615 * yAxis,
      208 * xAxis,
      388.615 * yAxis,
    );
    path.cubicTo(
      7 * xAxis,
      388.615 * yAxis,
      0 * xAxis,
      365.003 * yAxis,
      0 * xAxis,
      365.003 * yAxis,
    );
    path.cubicTo(
      0 * xAxis,
      365.003 * yAxis,
      0 * xAxis,
      0 * yAxis,
      0 * xAxis,
      0 * yAxis,
    );
    path.cubicTo(
      0 * xAxis,
      0 * yAxis,
      0 * xAxis,
      0 * yAxis,
      0 * xAxis,
      0 * yAxis,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

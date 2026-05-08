import 'package:flutter/material.dart';

class FirstShapePattern extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 200;
    final double yScaling = size.height / 200;
    path.lineTo(193.684 * xScaling, 96.8421 * yScaling);
    path.cubicTo(
      193.684 * xScaling,
      150.327 * yScaling,
      150.326 * xScaling,
      193.684 * yScaling,
      96.8421 * xScaling,
      193.684 * yScaling,
    );
    path.cubicTo(
      43.3577 * xScaling,
      193.684 * yScaling,
      -0.00000467575 * xScaling,
      150.326 * yScaling,
      0 * xScaling,
      96.8421 * yScaling,
    );
    path.cubicTo(
      0.00000467576 * xScaling,
      43.3577 * yScaling,
      43.3577 * xScaling,
      -0.00000467576 * yScaling,
      96.8421 * xScaling,
      0 * yScaling,
    );
    path.cubicTo(
      150.327 * xScaling,
      0.00000467576 * yScaling,
      193.684 * xScaling,
      43.3577 * yScaling,
      193.684 * xScaling,
      96.8421 * yScaling,
    );
    path.cubicTo(
      193.684 * xScaling,
      96.8421 * yScaling,
      193.684 * xScaling,
      96.8421 * yScaling,
      193.684 * xScaling,
      96.8421 * yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

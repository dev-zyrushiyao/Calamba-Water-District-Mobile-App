import 'package:flutter/material.dart';

class ScoopBorder extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // x - horizontal
    // y - vertical
    // parameters (x , y)

    /* A-------B
       |       |  
       D-------C */

    //https://itchylabs.com/tools/path-to-bezier/
    //https://youtu.be/P0eZ0XH5FdI?si=N-SLXxspMoZIP1c5
    //https://medium.com/thebrand/bezier-animations-ui-elements-to-flutter-widgets-part-1-95c04b6ba1c4

    Path path = Path();
    final double xScaling = size.width / 412.05;
    final double yScaling = size.height / 545;
    path.lineTo(0.0480735 * xScaling, 0 * yScaling);
    path.cubicTo(
      0.0480735 * xScaling,
      0 * yScaling,
      412.048 * xScaling,
      0 * yScaling,
      412.048 * xScaling,
      0 * yScaling,
    );
    path.cubicTo(
      412.048 * xScaling,
      0 * yScaling,
      412.048 * xScaling,
      545 * yScaling,
      412.048 * xScaling,
      545 * yScaling,
    );
    path.cubicTo(
      412.048 * xScaling,
      545 * yScaling,
      407.187 * xScaling,
      520.097 * yScaling,
      343.048 * xScaling,
      507 * yScaling,
    );
    path.cubicTo(
      302.364 * xScaling,
      498.692 * yScaling,
      179.047 * xScaling,
      498.5 * yScaling,
      87.0475 * xScaling,
      501.5 * yScaling,
    );
    path.cubicTo(
      -4.95248 * xScaling,
      504.5 * yScaling,
      0.0480735 * xScaling,
      459.958 * yScaling,
      0.0480735 * xScaling,
      459.958 * yScaling,
    );
    path.cubicTo(
      0.0480735 * xScaling,
      459.958 * yScaling,
      0.0480735 * xScaling,
      0 * yScaling,
      0.0480735 * xScaling,
      0 * yScaling,
    );
    path.cubicTo(
      0.0480735 * xScaling,
      0 * yScaling,
      0.0480735 * xScaling,
      0 * yScaling,
      0.0480735 * xScaling,
      0 * yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

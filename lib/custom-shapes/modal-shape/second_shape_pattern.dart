import 'package:flutter/material.dart';

class SecondShapePattern extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 200;
    final double yScaling = size.height / 200;
    path.lineTo(122.616 * xScaling, 167.001 * yScaling);
    path.cubicTo(
      111.985 * xScaling,
      174.723 * yScaling,
      106.669 * xScaling,
      178.584 * yScaling,
      101.003 * xScaling,
      180.504 * yScaling,
    );
    path.cubicTo(
      92.8086 * xScaling,
      183.28 * yScaling,
      83.9272 * xScaling,
      183.28 * yScaling,
      75.7325 * xScaling,
      180.504 * yScaling,
    );
    path.cubicTo(
      70.0667 * xScaling,
      178.584 * yScaling,
      64.7509 * xScaling,
      174.723 * yScaling,
      54.1193 * xScaling,
      167.001 * yScaling,
    );
    path.cubicTo(
      54.1193 * xScaling,
      167.001 * yScaling,
      30.2125 * xScaling,
      149.635 * yScaling,
      30.2125 * xScaling,
      149.635 * yScaling,
    );
    path.cubicTo(
      23.899 * xScaling,
      145.049 * yScaling,
      20.7422 * xScaling,
      142.756 * yScaling,
      18.1689 * xScaling,
      140.004 * yScaling,
    );
    path.cubicTo(
      14.4499 * xScaling,
      136.025 * yScaling,
      11.5971 * xScaling,
      131.319 * yScaling,
      9.79066 * xScaling,
      126.182 * yScaling,
    );
    path.cubicTo(
      8.54074 * xScaling,
      122.627 * yScaling,
      7.96848 * xScaling,
      118.769 * yScaling,
      6.82392 * xScaling,
      111.051 * yScaling,
    );
    path.cubicTo(
      6.82392 * xScaling,
      111.051 * yScaling,
      2.39756 * xScaling,
      81.2037 * yScaling,
      2.39756 * xScaling,
      81.2037 * yScaling,
    );
    path.cubicTo(
      0.389656 * xScaling,
      67.6643 * yScaling,
      -0.614297 * xScaling,
      60.8946 * yScaling,
      0.399046 * xScaling,
      54.793 * yScaling,
    );
    path.cubicTo(
      1.86485 * xScaling,
      45.967 * yScaling,
      6.29451 * xScaling,
      37.9037 * yScaling,
      12.958 * xScaling,
      31.9317 * yScaling,
    );
    path.cubicTo(
      17.5646 * xScaling,
      27.8032 * yScaling,
      23.8175 * xScaling,
      25.0181 * yScaling,
      36.3232 * xScaling,
      19.4481 * yScaling,
    );
    path.cubicTo(
      36.3232 * xScaling,
      19.4481 * yScaling,
      64.6564 * xScaling,
      6.82864 * yScaling,
      64.6564 * xScaling,
      6.82864 * yScaling,
    );
    path.cubicTo(
      72.2029 * xScaling,
      3.46744 * yScaling,
      75.9762 * xScaling,
      1.78684 * yScaling,
      79.8556 * xScaling,
      0.927926 * yScaling,
    );
    path.cubicTo(
      85.4625 * xScaling,
      -0.313456 * yScaling,
      91.2733 * xScaling,
      -0.313455 * yScaling,
      96.8802 * xScaling,
      0.927926 * yScaling,
    );
    path.cubicTo(
      100.76 * xScaling,
      1.78684 * yScaling,
      104.533 * xScaling,
      3.46743 * yScaling,
      112.079 * xScaling,
      6.82862 * yScaling,
    );
    path.cubicTo(
      112.079 * xScaling,
      6.82862 * yScaling,
      140.413 * xScaling,
      19.4481 * yScaling,
      140.413 * xScaling,
      19.4481 * yScaling,
    );
    path.cubicTo(
      152.918 * xScaling,
      25.0182 * yScaling,
      159.171 * xScaling,
      27.8032 * yScaling,
      163.778 * xScaling,
      31.9317 * yScaling,
    );
    path.cubicTo(
      170.441 * xScaling,
      37.9037 * yScaling,
      174.871 * xScaling,
      45.967 * yScaling,
      176.337 * xScaling,
      54.793 * yScaling,
    );
    path.cubicTo(
      177.35 * xScaling,
      60.8947 * yScaling,
      176.346 * xScaling,
      67.6644 * yScaling,
      174.338 * xScaling,
      81.2038 * yScaling,
    );
    path.cubicTo(
      174.338 * xScaling,
      81.2038 * yScaling,
      169.912 * xScaling,
      111.051 * yScaling,
      169.912 * xScaling,
      111.051 * yScaling,
    );
    path.cubicTo(
      168.767 * xScaling,
      118.769 * yScaling,
      168.195 * xScaling,
      122.627 * yScaling,
      166.945 * xScaling,
      126.182 * yScaling,
    );
    path.cubicTo(
      165.139 * xScaling,
      131.319 * yScaling,
      162.286 * xScaling,
      136.025 * yScaling,
      158.567 * xScaling,
      140.004 * yScaling,
    );
    path.cubicTo(
      155.994 * xScaling,
      142.756 * yScaling,
      152.837 * xScaling,
      145.049 * yScaling,
      146.523 * xScaling,
      149.635 * yScaling,
    );
    path.cubicTo(
      146.523 * xScaling,
      149.635 * yScaling,
      122.616 * xScaling,
      167.001 * yScaling,
      122.616 * xScaling,
      167.001 * yScaling,
    );
    path.cubicTo(
      122.616 * xScaling,
      167.001 * yScaling,
      122.616 * xScaling,
      167.001 * yScaling,
      122.616 * xScaling,
      167.001 * yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PageLogo extends StatelessWidget {
  const PageLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.centerStart,
      child: SvgPicture.asset('assets/home-logo.svg', fit: BoxFit.cover),
    );
  }
}

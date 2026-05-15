import 'package:flutter/material.dart';
import 'package:morphable_shape/morphable_shape.dart';

class MorphShape {
  //Variables of Custom Shape for Morphing Shapes

  final MorphableShapeBorder _shape1 = StarShapeBorder(
    corners: 5,
    inset: 50.toPercentLength,
    cornerRadius: 30.toPXLength,
    cornerStyle: CornerStyle.rounded,
    insetRadius: 0.toPXLength,
    insetStyle: CornerStyle.rounded,
  );

  //Rounded Triangle
  final MorphableShapeBorder _shape2 = PolygonShapeBorder(
    sides: 3,
    cornerRadius: 20.toPercentLength,
    cornerStyle: CornerStyle.rounded,
  );

  //Round
  final MorphableShapeBorder _shape3 = CircleShapeBorder(
    border: DynamicBorderSide(width: 1, color: Colors.transparent),
  );

  //octagon
  final MorphableShapeBorder _shape4 = StarShapeBorder(
    corners: 8,
    inset: 50.toPercentLength,
    cornerRadius: 15.toPercentLength,
    cornerStyle: CornerStyle.rounded,
    insetStyle: CornerStyle.rounded,
  );

  final MorphableShapeBorder _shape5 = StarShapeBorder(
    corners: 4,
    inset: 50.toPXLength,
    cornerRadius: 15.toPercentLength,
    cornerStyle: CornerStyle.rounded,
  );

  List<MorphableShapeBorder> getAllShapes() {
    return [_shape1, _shape2, _shape3, _shape4, _shape5];
  }
}

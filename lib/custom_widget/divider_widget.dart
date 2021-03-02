import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget DividerWidget({double height, double width, Color color}) {
  return Container(
    height: height,
    width: width,
    color: (color != null) ? color : AppConstants.clrDivider,
  );
}

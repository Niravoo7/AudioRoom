import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget LogoWidget({double height, double width}) {
  return Image.asset(
    AppConstants.img_logo,
    height: height,
    width: width,
  );
}

// ignore: non_constant_identifier_names
Widget LogoWidgetText({double height, double width, BoxFit boxFit}) {
  return Image.asset(
    AppConstants.img_logo_text,
    height: height,
    width: width,
    fit: boxFit,
  );
}

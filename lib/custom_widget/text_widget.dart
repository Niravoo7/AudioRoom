import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';

// ignore: non_constant_identifier_names
Widget TextWidget(String string,
    {Color color,
    double fontSize,
    double height,
    FontWeight fontWeight,
    int maxLines,
    TextAlign textAlign,
    TextOverflow textOverflow,
    double letterSpacing}) {
  return (string != null && string != "")
      ? Text(
          (string != null) ? string : "",
          overflow: (textOverflow!=null)?textOverflow:TextOverflow.ellipsis,
          maxLines: (maxLines != null) ? maxLines : 1,
          style: TextStyle(
              height: height,
              color: (color != null) ? color : AppConstants.clrBlack,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              fontFamily: AppConstants.fontGothic),
          textAlign: (textAlign != null) ? textAlign : TextAlign.left,
        )
      : Container();
}

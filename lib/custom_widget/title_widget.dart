import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget TitleWidget(BuildContext context, String name) {
  return Container(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          color: AppConstants.clrTitleBG,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: TextWidget(name,
              color: AppConstants.clrBlack,
              fontSize: AppConstants.size_medium_large,
              fontWeight: FontWeight.bold)),
      DividerWidget(height: 1)
    ],
  ));
}

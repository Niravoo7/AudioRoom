
import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';

// ignore: non_constant_identifier_names
Widget FlexibleWidget(int flax) {
  return Flexible(
    child: Container(
      color: AppConstants.clrTransparent,
    ),
    flex: flax,
  );
}

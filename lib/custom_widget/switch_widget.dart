import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';

// ignore: non_constant_identifier_names
Widget SwitchWidget(bool isOn, Function onSwitch) {
  return GestureDetector(
    onTap: onSwitch,
    child: Container(
      height: 31,
      width: 51,
      alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: isOn ? AppConstants.clrSwitchGreen : AppConstants.clrWhite,
          borderRadius: BorderRadius.circular(51),
          border: Border.all(width: 1, color: AppConstants.clrSwitchGreen)),
      child: Container(
        height: 27,
        width: 27,
        decoration: BoxDecoration(
            color: isOn ? AppConstants.clrWhite : AppConstants.clrSwitchGreen,
            shape: BoxShape.circle),
      ),
    ),
  );
}

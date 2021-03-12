import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';

// ignore: non_constant_identifier_names
Widget OnGoingButtonWidget(BuildContext context, String name, Function onClick,
    {EdgeInsetsGeometry margin, int selectedIndex, int index}) {
  return Container(
    padding: EdgeInsets.only(top: 16),
    margin: margin,
    child: ButtonTheme(
      // minWidth: MediaQuery.of(context).size.width,
      height: 44,
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
          side: BorderSide(color: AppConstants.clrGrey)),
      child: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: onClick,
        child: TextWidget(name,
            color: selectedIndex == index
                ? AppConstants.clrWhite
                : AppConstants.clrBlack,
            fontSize: AppConstants.size_medium,
            fontWeight: FontWeight.w600),
        color: selectedIndex == index
            ? AppConstants.clrBlack
            : AppConstants.clrWhite,
      ),
    ),
  );
}

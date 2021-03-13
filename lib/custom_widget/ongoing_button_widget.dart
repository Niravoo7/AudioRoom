import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';

// ignore: non_constant_identifier_names
Widget OnGoingButtonWidget(BuildContext context, String name, Function onClick,
    {int selectedIndex, int index}) {
  return GestureDetector(
    child: Container(
      height: 36,
      margin: EdgeInsets.only(top: 16, right: 16),
      padding: EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: selectedIndex == index
              ? AppConstants.clrBlack
              : AppConstants.clrWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppConstants.clrGrey, width: 1)),
      child: TextWidget(name,
          color: selectedIndex == index
              ? AppConstants.clrWhite
              : AppConstants.clrBlack,
          fontSize: AppConstants.size_medium,
          fontWeight: FontWeight.w600),
    ),
    onTap: onClick,
  );

  /*return Container(
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
  );*/
}

import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';

// ignore: non_constant_identifier_names
Widget ButtonWidget(BuildContext context, String name, Function onClick) {
  return Container(
    padding: EdgeInsets.only(top: 16, bottom: 16),
    child: ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 44,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
      child: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: onClick,
        child: TextWidget(name,
            color: AppConstants.clrWhite,
            fontSize: AppConstants.size_medium,
            fontWeight: FontWeight.w600),
        color: AppConstants.clrPrimary,
      ),
    ),
  );
}

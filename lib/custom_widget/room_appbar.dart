import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget RoomAppBar(BuildContext context, String pageName, Function onSkipCall) {
  return AppBar(
    titleSpacing: 0.0,
    backgroundColor: AppConstants.clrWhite,
    elevation: 1,
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        GestureDetector(
          child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 30,
                color: AppConstants.clrBlack,
              )),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        TextWidget(pageName,
            textOverflow: TextOverflow.ellipsis,
            maxLines: 1,
            color: AppConstants.clrBlack,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            fontSize: AppConstants.size_medium_large)
      ],
    ),
  );
}

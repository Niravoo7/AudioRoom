import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CommonAppBar(
    BuildContext context, String pageName, bool backArrowVisible) {
  return AppBar(
    titleSpacing: 0.0,
    backgroundColor: AppConstants.clrButtonBG,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: Stack(
      alignment: Alignment.centerLeft,
      children: [
        (backArrowVisible)
            ? GestureDetector(
                child: Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: AppConstants.clrBlack,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            : Container(),
        Container(
          alignment: Alignment.center,
          child: TextWidget(pageName,
              textOverflow: TextOverflow.ellipsis,
              maxLines: 1,
              color: AppConstants.clrBlack,
              fontSize: 20),
        ),
      ],
    ),
  );
}

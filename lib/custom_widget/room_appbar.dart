import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget RoomAppBar(BuildContext context, String pageName, Function onBackCall) {
  return AppBar(
    titleSpacing: 0.0,
    backgroundColor: AppConstants.clrWhite,
    elevation: 1,
    automaticallyImplyLeading: false,
    title: GestureDetector(
      onTap: onBackCall,
      child: Container(
        child: Row(
          children: [
            Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 30,
                  color: AppConstants.clrBlack,
                )),
            TextWidget(pageName,
                textOverflow: TextOverflow.ellipsis,
                maxLines: 1,
                color: AppConstants.clrBlack,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                fontSize: AppConstants.size_medium_large)
          ],
        ),
      ),
    ),
  );
}

import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CommonAppBar(BuildContext context, String pageName,
    bool backArrowVisible, bool skipVisible, Function onSkipCall,
    {Widget leading}) {
  return AppBar(
    titleSpacing: 0.0,
    backgroundColor: AppConstants.clrWhite,
    elevation: 1,
    automaticallyImplyLeading: false,
    title: Stack(
      children: [
        Container(
          alignment: Alignment.center,
          height: 50,
          child: TextWidget(pageName,
              textOverflow: TextOverflow.ellipsis,
              maxLines: 1,
              color: AppConstants.clrBlack,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              fontSize: AppConstants.size_medium_large),
        ),
        (backArrowVisible)
            ? GestureDetector(
                child: Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 20,
                    color: AppConstants.clrBlack,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            : Container(),
        (skipVisible)
            ? GestureDetector(
                child: Container(
                  height: 50,
                  margin: EdgeInsets.only(right: 15),
                  alignment: Alignment.centerRight,
                  child: TextWidget(AppConstants.str_skip,
                      textOverflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      color: AppConstants.clrBlack,
                      fontWeight: FontWeight.w500,
                      fontSize: AppConstants.size_medium),
                ),
                onTap: () {
                  onSkipCall();
                },
              )
            : Container(),
      ],
    ),
    leading: leading,
  );
}

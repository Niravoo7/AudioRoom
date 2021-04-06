import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CommonUserDetailWidget(
    BuildContext context, String imageURL, String name, String desc,
    {bool isSelected, Function onClick, bool isOnline}) {
  return Flexible(
      child: GestureDetector(
    child: Container(
      color: AppConstants.clrTransparent,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: AppConstants.clrGrey,
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(imageURL)))),
              (isOnline != null && isOnline)
                  ? Container(
                      margin: EdgeInsets.only(left: 16, bottom: 16),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: AppConstants.clrGreen, shape: BoxShape.circle))
                  : Container(),
            ],
          ),
          Flexible(
            child: Container(
                margin: EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(name,
                        color: (isSelected != null && isSelected)
                            ? AppConstants.clrWhite
                            : AppConstants.clrBlack,
                        fontSize: AppConstants.size_medium_large,
                        fontWeight: FontWeight.bold),
                    TextWidget(desc,
                        color: (isSelected != null && isSelected)
                            ? AppConstants.clrWhite
                            : AppConstants.clrBlack,
                        fontSize: AppConstants.size_small_medium,
                        fontWeight: FontWeight.w500)
                  ],
                )),
            flex: 1,
          )
        ],
      ),
    ),
    onTap: () {
      if (onClick != null) {
        onClick();
      }
    },
  ));
}

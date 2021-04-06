import 'package:audioroom/custom_widget/common_user_detail_widget.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget ChoosePeopleWidget(BuildContext context, String profilePic, String name,
    String tagName, bool isSelected, bool isOnline, Function btnClick) {
  return Container(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        Flexible(
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Row(
                children: [
                  CommonUserDetailWidget(context, profilePic, name, tagName,
                      isOnline: isOnline),
                ],
              ),
              Container(
                height: 8,
                width: 8,
                margin: EdgeInsets.only(bottom: 16, left: 45),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (isOnline)
                        ? AppConstants.clrGreen
                        : AppConstants.clrTransparent),
              ),
            ],
          ),
          flex: 1,
        ),
        GestureDetector(
            onTap: () {
              btnClick();
            },
            child: Container(
                alignment: Alignment.center,
                height: 22,
                width: 22,
                margin: EdgeInsets.only(right: 16),
                padding: EdgeInsets.only(left: 24, right: 24),
                decoration: BoxDecoration(
                    color: isSelected
                        ? AppConstants.clrPrimary
                        : AppConstants.clrWhite,
                    shape: BoxShape.circle,
                    border: isSelected
                        ? null
                        : Border.all(width: 1, color: AppConstants.clrGrey))))
      ]),
      DividerWidget(height: 1, width: MediaQuery.of(context).size.width)
    ],
  ));
}

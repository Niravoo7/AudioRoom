import 'package:audioroom/custom_widget/common_user_detail_widget.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget FollowPeopleWidgetTemp(
    BuildContext context,
    String profilePic,
    String name,
    String tagName,
    String btnName,
    bool isSelected,
    Function btnClick) {
  return Container(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        CommonUserDetailWidget(context, profilePic, name, tagName),
        GestureDetector(
            onTap: () {
              btnClick();
            },
            child: Container(
                alignment: Alignment.center,
                height: 36,
                margin: EdgeInsets.only(right: 16),
                padding: EdgeInsets.only(left: 24, right: 24),
                decoration: BoxDecoration(
                    color: isSelected
                        ? AppConstants.clrPrimary
                        : AppConstants.clrWhite,
                    borderRadius: BorderRadius.circular(10),
                    border: isSelected
                        ? null
                        : Border.all(width: 1, color: AppConstants.clrPrimary)),
                child: TextWidget(btnName,
                    color: isSelected
                        ? AppConstants.clrWhite
                        : AppConstants.clrPrimary,
                    fontSize: AppConstants.size_medium,
                    fontWeight: FontWeight.bold,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis)))
      ]),
      DividerWidget(height: 1, width: MediaQuery.of(context).size.width)
    ],
  ));
}

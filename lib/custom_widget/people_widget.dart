import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget PeopleWidget(BuildContext context, String profilePic, String name,
    String tagName, String btnName, bool isSelected, Function btnClick) {
  return Container(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        Container(
          margin: EdgeInsets.only(left: 16, top: 16, bottom: 16),
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Image.network(profilePic, height: 40, width: 40),
        ),
        Flexible(
          child: Container(
              margin: EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(name,
                      color: AppConstants.clrBlack,
                      fontSize: AppConstants.size_medium_large,
                      fontWeight: FontWeight.bold),
                  TextWidget(tagName,
                      color: AppConstants.clrBlack,
                      fontSize: AppConstants.size_small_medium,
                      fontWeight: FontWeight.w500)
                ],
              )),
          flex: 1,
        ),
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

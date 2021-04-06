import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget InvitePeopleWidget(
    BuildContext context, String name, String phone, bool isSelected,
    {Function() onInviteClick}) {
  return Container(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        Flexible(
            child: Container(
          color: AppConstants.clrTransparent,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppConstants.clrGrey, shape: BoxShape.circle),
                child: TextWidget(name.substring(0, 1).toUpperCase(),
                    color: AppConstants.clrBlack,
                    fontSize: AppConstants.size_extra_large,
                    fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Container(
                    margin: EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWidget(name,
                            color:  AppConstants.clrBlack,
                            fontSize: AppConstants.size_medium_large,
                            fontWeight: FontWeight.bold),
                        (phone != null)
                            ? TextWidget(phone,
                                color:  AppConstants.clrBlack,
                                fontSize: AppConstants.size_medium_large,
                                fontWeight: FontWeight.bold)
                            : Container()
                      ],
                    )),
                flex: 1,
              )
            ],
          ),
        )),
        GestureDetector(
            onTap: onInviteClick,
            child: Container(
                alignment: Alignment.center,
                height: 36,
                margin: EdgeInsets.only(right: 16),
                padding: EdgeInsets.only(left: 24, right: 24),
                decoration: BoxDecoration(
                    color: (isSelected)
                        ? AppConstants.clrPrimary
                        : AppConstants.clrWhite,
                    borderRadius: BorderRadius.circular(10),
                    border: (isSelected)
                        ? null
                        : Border.all(width: 1, color: AppConstants.clrPrimary)),
                child: TextWidget(
                    (isSelected)
                        ? AppConstants.str_invited
                        : AppConstants.str_invite,
                    color: (isSelected)
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

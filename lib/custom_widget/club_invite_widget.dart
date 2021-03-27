import 'package:audioroom/custom_widget/common_user_detail_widget.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/firestore/model/user_model.dart';
import 'package:audioroom/firestore/network/user_fire.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names

// ignore: must_be_immutable
class ClubInviteWidget extends StatefulWidget {
  String uId;
  bool isSelected;
  Function(bool) onInviteClick;

  ClubInviteWidget(this.uId, this.isSelected, this.onInviteClick);

  @override
  _ClubInviteWidgetState createState() => _ClubInviteWidgetState();
}

class _ClubInviteWidgetState extends State<ClubInviteWidget> {
  UserModel userModel;
  bool isSubSelected;

  @override
  void initState() {
    super.initState();
    this.isSubSelected = widget.isSelected;
    UserService().getUserByReferences(widget.uId).then((userModel) {
      if (userModel != null) {
        this.userModel = userModel;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    (userModel != null)
                        ? CommonUserDetailWidget(
                            context,
                            userModel.imageUrl,
                            userModel.firstName + " " + userModel.lastName,
                            userModel.tagName)
                        : Container(),
                  ],
                ),
                Container(
                  height: 8,
                  width: 8,
                  margin: EdgeInsets.only(bottom: 16, left: 45),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppConstants.clrTransparent),
                ),
              ],
            ),
            flex: 1,
          ),
          GestureDetector(
              onTap: () {
                if (!isSubSelected) {
                  isSubSelected = !isSubSelected;
                  setState(() {});
                  widget.onInviteClick(isSubSelected);
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 22,
                margin: EdgeInsets.only(right: 16),
                padding: EdgeInsets.only(left: 24, right: 24),
                decoration: (isSubSelected)
                    ? null
                    : BoxDecoration(
                        color: isSubSelected
                            ? AppConstants.clrPrimary
                            : AppConstants.clrWhite,
                        shape: BoxShape.circle,
                        border: isSubSelected
                            ? null
                            : Border.all(
                                width: 1, color: AppConstants.clrGrey)),
                child: (isSubSelected)
                    ? TextWidget(AppConstants.str_invited,
                        color: AppConstants.clrPrimary,
                        fontSize: AppConstants.size_medium)
                    : Container(),
              ))
        ]),
        DividerWidget(height: 1, width: MediaQuery.of(context).size.width)
      ],
    ));

    /*return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          (userModel != null)
              ? CommonUserDetailWidget(
                  context,
                  userModel.imageUrl,
                  userModel.firstName + " " + userModel.lastName,
                  userModel.tagName)
              : Container(),
          GestureDetector(
              onTap: widget.onRaiseHandClick,
              child: Container(
                  alignment: Alignment.center,
                  height: 36,
                  margin: EdgeInsets.only(right: 16),
                  padding: EdgeInsets.only(left: 24, right: 24),
                  decoration: BoxDecoration(
                      color: AppConstants.clrPrimary,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextWidget(AppConstants.str_make_speaker,
                      color: AppConstants.clrWhite,
                      fontSize: AppConstants.size_medium,
                      fontWeight: FontWeight.bold,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis)))
        ]),
        DividerWidget(height: 1, width: MediaQuery.of(context).size.width)
      ],
    ));*/
  }
}

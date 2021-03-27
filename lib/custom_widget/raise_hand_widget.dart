import 'package:audioroom/custom_widget/common_user_detail_widget.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/firestore/model/user_model.dart';
import 'package:audioroom/firestore/network/user_fire.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names

// ignore: must_be_immutable
class RaiseHandWidget extends StatefulWidget {
  String uId;
  Function onRaiseHandClick;

  RaiseHandWidget(this.uId, this.onRaiseHandClick);

  @override
  _RaiseHandWidgetState createState() => _RaiseHandWidgetState();
}

class _RaiseHandWidgetState extends State<RaiseHandWidget> {
  UserModel userModel;

  @override
  void initState() {
    super.initState();
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
    ));
  }
}

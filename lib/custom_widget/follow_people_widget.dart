import 'package:audioroom/custom_widget/common_user_detail_widget.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/firestore/network/follow_fire.dart';
import 'package:audioroom/firestore/model/follow_model.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget FollowPeopleWidget(BuildContext context, String profilePic, String name,
    String tagName, String uId,
    {Function(String) onClick}) {
  return StreamBuilder(
    stream: FollowService().checkFollowByUser(uId).snapshots(),
    builder: (context, stream) {
      return Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            CommonUserDetailWidget(context, profilePic, name, tagName,
                onClick: () {
              if (onClick != null) {
                onClick(uId);
              }
            }),
            (stream != null && stream.data != null)
                ? GestureDetector(
                    onTap: () {
                      if (stream.data.size > 0) {
                        FollowService().deleteFollow(
                            FollowModel.fromJson(stream.data.docs[0].data()),
                            name,
                            profilePic);
                      } else {
                        FollowService().createFollow(
                            new FollowModel(
                                followBy: FirebaseAuth.instance.currentUser.uid,
                                followTo: uId,
                                status: 1),
                            name,
                            profilePic);
                      }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 36,
                        margin: EdgeInsets.only(right: 16),
                        padding: EdgeInsets.only(left: 24, right: 24),
                        decoration: BoxDecoration(
                            color: (stream.data.size > 0)
                                ? AppConstants.clrPrimary
                                : AppConstants.clrWhite,
                            borderRadius: BorderRadius.circular(10),
                            border: (stream.data.size > 0)
                                ? null
                                : Border.all(
                                    width: 1, color: AppConstants.clrPrimary)),
                        child: TextWidget(
                            (stream.data.size > 0)
                                ? AppConstants.str_following
                                : AppConstants.str_follow,
                            color: (stream.data.size > 0)
                                ? AppConstants.clrWhite
                                : AppConstants.clrPrimary,
                            fontSize: AppConstants.size_medium,
                            fontWeight: FontWeight.bold,
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis)))
                : Container()
          ]),
          DividerWidget(height: 1, width: MediaQuery.of(context).size.width)
        ],
      ));
    },
  );
}

import 'package:audioroom/custom_widget/common_user_detail_widget.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/firestore/model/club_model.dart';
import 'package:audioroom/firestore/network/club_fire.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget ClubPeopleWidget(BuildContext context, String profilePic, String name,
    String onlineMember, ClubModel clubModel) {
  return Container(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        CommonUserDetailWidget(
            context, profilePic, name, onlineMember + " members online"),
        GestureDetector(
            onTap: () {
              if (clubModel.userList
                  .contains(FirebaseAuth.instance.currentUser.uid)) {
                clubModel.userList
                    .remove(FirebaseAuth.instance.currentUser.uid);
                clubModel.refId =
                    clubModel.clubName.toLowerCase().replaceAll(" ", "_");
                ClubService().updateClub(clubModel);
              } else {
                clubModel.userList.add(FirebaseAuth.instance.currentUser.uid);
                clubModel.refId =
                    clubModel.clubName.toLowerCase().replaceAll(" ", "_");
                ClubService().updateClub(clubModel);
              }
            },
            child: Container(
                alignment: Alignment.center,
                height: 36,
                margin: EdgeInsets.only(right: 16),
                padding: EdgeInsets.only(left: 24, right: 24),
                decoration: BoxDecoration(
                    color: (clubModel.userList
                            .contains(FirebaseAuth.instance.currentUser.uid))
                        ? AppConstants.clrPrimary
                        : AppConstants.clrWhite,
                    borderRadius: BorderRadius.circular(10),
                    border: (clubModel.userList
                            .contains(FirebaseAuth.instance.currentUser.uid))
                        ? null
                        : Border.all(width: 1, color: AppConstants.clrPrimary)),
                child: TextWidget(
                    (clubModel.userList
                            .contains(FirebaseAuth.instance.currentUser.uid))
                        ? AppConstants.str_following
                        : AppConstants.str_follow,
                    color: (clubModel.userList
                            .contains(FirebaseAuth.instance.currentUser.uid))
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

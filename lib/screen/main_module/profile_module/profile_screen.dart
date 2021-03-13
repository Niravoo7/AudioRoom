import 'package:audioroom/custom_widget/flexible_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/firestore/network/user_fire.dart';
import 'package:audioroom/firestore/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/helper/navigate_effect.dart';
import 'package:audioroom/screen/main_module/profile_module/follower_screen.dart';
import 'package:audioroom/screen/main_module/profile_module/following_screen.dart';
import 'package:audioroom/screen/main_module/profile_module/clubs_screen.dart';
import 'package:audioroom/screen/main_module/profile_module/setting_screen.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  bool isOther;

  ProfileScreen(this.isOther);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  bool isFollowingSelected = true;
  UserModel userModel;

  @override
  void initState() {
    super.initState();
    UserService()
        .getUsersByRefID(FirebaseAuth.instance.currentUser.uid)
        .then((userModel) {
      if (userModel != null) {
        this.userModel = userModel;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            titleSpacing: 0.0,
            backgroundColor: AppConstants.clrWhite,
            elevation: 1,
            automaticallyImplyLeading: false,
            title: Stack(children: [
              Container(
                alignment: Alignment.center,
                height: 50,
                child: TextWidget("Profile",
                    textOverflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    color: AppConstants.clrBlack,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    fontSize: AppConstants.size_medium_large),
              ),
              Row(children: [
                GestureDetector(
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
                ),
                FlexibleWidget(1),
                GestureDetector(
                  child: Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.only(right: 15),
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.settings,
                      size: 22,
                      color: AppConstants.clrBlack,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context, NavigatePageRoute(context, SettingScreen()));
                  },
                )
              ])
            ])),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(16),
                child: (userModel != null)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Row(children: [
                              GestureDetector(
                                child: Container(
                                    height: 80,
                                    width: 80,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color: AppConstants.clrProfileBG,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                userModel.imageUrl),
                                            fit: BoxFit.fill),
                                        borderRadius:
                                            BorderRadius.circular(35))),
                                onTap: () {
                                  /*UserService().getUsers().then((value) {
                                    if (value != null) {
                                      List<UserModel> userModels = value;
                                      for (int i = 0;
                                          i < userModels.length;
                                          i++) {
                                        //PrintLog.printMessage(userModels[i].toJson().toString());
                                      }
                                    }
                                  });
                                  UserService()
                                      .getUserModelByReferences("1")
                                      .then((value) {
                                    if (value != null) {
                                      UserModel userModel = value;
                                      PrintLog.printMessage(
                                          userModel.toJson().toString());
                                    }
                                  });
                                  UserService()
                                      .getUsersByRefID("1")
                                      .then((value) {
                                    if (value != null) {
                                      UserModel userModel = value;
                                      PrintLog.printMessage(
                                          userModel.toJson().toString());
                                    }
                                  });*/
                                },
                              ),
                              Flexible(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    TextWidget(
                                        userModel.firstName +
                                            " " +
                                            userModel.lastName,
                                        color: AppConstants.clrBlack,
                                        fontSize:
                                            AppConstants.size_medium_large,
                                        fontWeight: FontWeight.bold),
                                    TextWidget(userModel.tagName,
                                        color: AppConstants.clrBlack,
                                        fontSize:
                                            AppConstants.size_small_medium,
                                        fontWeight: FontWeight.w400),
                                  ]))
                            ]),
                            SizedBox(height: 16),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            NavigatePageRoute(
                                                context, FollowerScreen()));
                                      },
                                      child: Container(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            TextWidget(
                                                userModel.followers.toString(),
                                                color: AppConstants.clrBlack,
                                                fontSize:
                                                    AppConstants.size_medium,
                                                fontWeight: FontWeight.bold),
                                            TextWidget(
                                              AppConstants.str_followers,
                                              color: AppConstants.clrBlack,
                                              fontSize:
                                                  AppConstants.size_medium,
                                              fontWeight: FontWeight.w400,
                                            )
                                          ]))),
                                  SizedBox(width: 16),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            NavigatePageRoute(
                                                context, FollowingScreen()));
                                      },
                                      child: Container(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            TextWidget(
                                                userModel.following.toString(),
                                                color: AppConstants.clrBlack,
                                                fontSize:
                                                    AppConstants.size_medium,
                                                fontWeight: FontWeight.bold),
                                            TextWidget(
                                              AppConstants.str_following,
                                              color: AppConstants.clrBlack,
                                              fontSize:
                                                  AppConstants.size_medium,
                                              fontWeight: FontWeight.w400,
                                            )
                                          ]))),
                                  SizedBox(width: 16),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            NavigatePageRoute(
                                                context, ClubsScreen()));
                                      },
                                      child: Container(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            TextWidget(
                                                userModel.clubJoined.toString(),
                                                color: AppConstants.clrBlack,
                                                fontSize:
                                                    AppConstants.size_medium,
                                                fontWeight: FontWeight.bold),
                                            TextWidget(
                                              AppConstants.str_clubs_joined,
                                              color: AppConstants.clrBlack,
                                              fontSize:
                                                  AppConstants.size_medium,
                                              fontWeight: FontWeight.w400,
                                            )
                                          ])))
                                ]),
                            SizedBox(height: 16),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  (userModel.twitterName != null &&
                                          userModel.twitterName != "")
                                      ? Image.asset(
                                          AppConstants.ic_twitter,
                                          height: 15,
                                          width: 15,
                                        )
                                      : Container(),
                                  SizedBox(width: 6),
                                  (userModel.twitterName != null &&
                                          userModel.twitterName != "")
                                      ? TextWidget(userModel.twitterName,
                                          color: AppConstants.clrBlack,
                                          fontSize:
                                              AppConstants.size_small_medium,
                                          fontWeight: FontWeight.w700)
                                      : Container(),
                                  SizedBox(width: 18),
                                  (userModel.instagramName != null &&
                                          userModel.instagramName != "")
                                      ? Image.asset(AppConstants.ic_instagram,
                                          height: 15, width: 15)
                                      : Container(),
                                  SizedBox(width: 6),
                                  (userModel.instagramName != null &&
                                          userModel.instagramName != "")
                                      ? TextWidget(userModel.instagramName,
                                          color: AppConstants.clrBlack,
                                          fontSize:
                                              AppConstants.size_small_medium,
                                          fontWeight: FontWeight.w700)
                                      : Container()
                                ]),
                            SizedBox(height: 16),
                            (widget.isOther)
                                ? Row(
                                    children: [
                                      GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                              alignment: Alignment.center,
                                              height: 36,
                                              padding: EdgeInsets.only(
                                                  left: 24, right: 24),
                                              decoration: BoxDecoration(
                                                  color: isFollowingSelected
                                                      ? AppConstants.clrPrimary
                                                      : AppConstants.clrWhite,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: isFollowingSelected
                                                      ? null
                                                      : Border.all(
                                                          width: 1,
                                                          color: AppConstants
                                                              .clrPrimary)),
                                              child: TextWidget(
                                                  isFollowingSelected
                                                      ? AppConstants
                                                          .str_following
                                                      : AppConstants.str_follow,
                                                  color: isFollowingSelected
                                                      ? AppConstants.clrWhite
                                                      : AppConstants.clrPrimary,
                                                  fontSize:
                                                      AppConstants.size_medium,
                                                  fontWeight: FontWeight.bold,
                                                  maxLines: 1,
                                                  textOverflow:
                                                      TextOverflow.ellipsis))),
                                      GestureDetector(
                                        child: Container(
                                          width: 54,
                                          height: 36,
                                          margin: EdgeInsets.only(right: 15),
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            AppConstants.ic_notification,
                                            height: 18,
                                          ),
                                        ),
                                        onTap: () {},
                                      )
                                    ],
                                  )
                                : Container(),
                            (widget.isOther)
                                ? SizedBox(height: 16)
                                : Container(),
                            TextWidget(AppConstants.str_about,
                                color: AppConstants.clrBlack,
                                fontSize: AppConstants.size_medium,
                                fontWeight: FontWeight.bold),
                            SizedBox(height: 8),
                            TextWidget(userModel.aboutInfo,
                                color: AppConstants.clrBlack,
                                fontSize: AppConstants.size_medium,
                                fontWeight: FontWeight.w400,
                                maxLines: 10),
                            SizedBox(height: 16),
                            Row(children: [
                              Container(
                                  height: 40,
                                  width: 40,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color: AppConstants.clrProfileBG,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              AppConstants.str_image_url),
                                          fit: BoxFit.fill),
                                      shape: BoxShape.circle)),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                        AppConstants.str_joined +
                                            " Feb 27 2021",
                                        color: AppConstants.clrBlack,
                                        fontSize:
                                            AppConstants.size_small_medium,
                                        fontWeight: FontWeight.w400),
                                    TextWidget(
                                        AppConstants.str_recommended_by +
                                            " Alex Benkre",
                                        color: AppConstants.clrBlack,
                                        fontSize: AppConstants.size_medium,
                                        fontWeight: FontWeight.w400),
                                  ])
                            ])
                          ])
                    : Center(child: CircularProgressIndicator()))));
  }
}

import 'package:audioroom/custom_widget/flexible_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/print_log.dart';
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
  User user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    PrintLog.printMessage("ProfileScreen -> ${user.displayName}");
    //PrintLog.printMessage("ProfileScreen -> ${user.providerData}");
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                            height: 80,
                            width: 80,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: AppConstants.clrProfileBG,
                                image: DecorationImage(
                                    image: NetworkImage(user.photoURL),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(35))),
                        Flexible(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              TextWidget(user.displayName,
                                  color: AppConstants.clrBlack,
                                  fontSize: AppConstants.size_medium_large,
                                  fontWeight: FontWeight.bold),
                              TextWidget("@serafield",
                                  color: AppConstants.clrBlack,
                                  fontSize: AppConstants.size_small_medium,
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
                                      TextWidget("501",
                                          color: AppConstants.clrBlack,
                                          fontSize: AppConstants.size_medium,
                                          fontWeight: FontWeight.bold),
                                      TextWidget(
                                        AppConstants.str_followers,
                                        color: AppConstants.clrBlack,
                                        fontSize: AppConstants.size_medium,
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
                                      TextWidget("38",
                                          color: AppConstants.clrBlack,
                                          fontSize: AppConstants.size_medium,
                                          fontWeight: FontWeight.bold),
                                      TextWidget(
                                        AppConstants.str_following,
                                        color: AppConstants.clrBlack,
                                        fontSize: AppConstants.size_medium,
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
                                      TextWidget("12",
                                          color: AppConstants.clrBlack,
                                          fontSize: AppConstants.size_medium,
                                          fontWeight: FontWeight.bold),
                                      TextWidget(
                                        AppConstants.str_clubs_joined,
                                        color: AppConstants.clrBlack,
                                        fontSize: AppConstants.size_medium,
                                        fontWeight: FontWeight.w400,
                                      )
                                    ])))
                          ]),
                      SizedBox(height: 16),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image.asset(
                              AppConstants.ic_twitter,
                              height: 15,
                              width: 15,
                            ),
                            SizedBox(width: 6),
                            TextWidget("serafield",
                                color: AppConstants.clrBlack,
                                fontSize: AppConstants.size_small_medium,
                                fontWeight: FontWeight.w700),
                            SizedBox(width: 18),
                            Image.asset(AppConstants.ic_instagram,
                                height: 15, width: 15),
                            SizedBox(width: 6),
                            TextWidget("serafield",
                                color: AppConstants.clrBlack,
                                fontSize: AppConstants.size_small_medium,
                                fontWeight: FontWeight.w700)
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
                                                ? AppConstants.str_following
                                                : AppConstants.str_follow,
                                            color: isFollowingSelected
                                                ? AppConstants.clrWhite
                                                : AppConstants.clrPrimary,
                                            fontSize: AppConstants.size_medium,
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
                      (widget.isOther) ? SizedBox(height: 16) : Container(),
                      TextWidget(AppConstants.str_about,
                          color: AppConstants.clrBlack,
                          fontSize: AppConstants.size_medium,
                          fontWeight: FontWeight.bold),
                      SizedBox(height: 8),
                      TextWidget(AppConstants.str_lorem_ipsum,
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
                                  AppConstants.str_joined + " Feb 27 2021",
                                  color: AppConstants.clrBlack,
                                  fontSize: AppConstants.size_small_medium,
                                  fontWeight: FontWeight.w400),
                              TextWidget(
                                  AppConstants.str_recommended_by +
                                      " Alex Benkre",
                                  color: AppConstants.clrBlack,
                                  fontSize: AppConstants.size_medium,
                                  fontWeight: FontWeight.w400),
                            ])
                      ])
                    ]))));
  }
}

import 'package:audioroom/custom_widget/flexible_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/firestore/model/follow_model.dart';
import 'package:audioroom/firestore/network/club_fire.dart';
import 'package:audioroom/firestore/network/follow_fire.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/firestore/network/user_fire.dart';
import 'package:audioroom/firestore/model/user_model.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:audioroom/screen/sign_module/basic_info_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String uId;

  ProfileScreen(this.isOther, this.uId);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  bool isFollowingSelected = true;
  UserModel userModel;
  UserModel userModelRecommendedBy;

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  void getUserDetails() {
    UserService().getUserByReferences(widget.uId).then((userModel) {
      if (userModel != null) {
        this.userModel = userModel;
        setState(() {});
        if (this.userModel.recommendedBy != null) {
          UserService()
              .getUserByReferences(this.userModel.recommendedBy)
              .then((userModelRecommendedBy) {
            if (userModelRecommendedBy != null) {
              this.userModelRecommendedBy = userModelRecommendedBy;
              setState(() {});
            }
          });
        }
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
                                  child: Container(
                                width: MediaQuery.of(context).size.width,
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
                                    ]),
                              )),
                              GestureDetector(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  color: AppConstants.clrTransparent,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.edit,
                                    size: 30,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                          context,
                                          NavigatePageRoute(
                                              context,
                                              BasicInfoScreen(
                                                  userModel: userModel)))
                                      .then((value) {
                                    getUserDetails();
                                  });
                                },
                              )
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
                                          color: AppConstants.clrTransparent,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                StreamBuilder(
                                                  stream: FollowService()
                                                      .checkFollowerByUID()
                                                      .snapshots(),
                                                  builder: (context, stream) {
                                                    if (stream.hasError) {
                                                      return Center(
                                                          child: TextWidget(
                                                              stream.error
                                                                  .toString(),
                                                              color:
                                                                  AppConstants
                                                                      .clrBlack,
                                                              fontSize: 20));
                                                    }
                                                    QuerySnapshot
                                                        querySnapshot =
                                                        stream.data;
                                                    if (querySnapshot == null ||
                                                        querySnapshot.size ==
                                                            0) {
                                                      if (querySnapshot ==
                                                          null) {
                                                        return Container();
                                                      } else {
                                                        return TextWidget("0",
                                                            color: AppConstants
                                                                .clrBlack,
                                                            fontSize:
                                                                AppConstants
                                                                    .size_medium,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold);
                                                      }
                                                    } else {
                                                      return TextWidget(
                                                          querySnapshot.size
                                                              .toString(),
                                                          color: AppConstants
                                                              .clrBlack,
                                                          fontSize: AppConstants
                                                              .size_medium,
                                                          fontWeight:
                                                              FontWeight.bold);
                                                    }
                                                  },
                                                ),
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
                                          color: AppConstants.clrTransparent,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                StreamBuilder(
                                                  stream: FollowService()
                                                      .checkFollowingByUID()
                                                      .snapshots(),
                                                  builder: (context, stream) {
                                                    if (stream.hasError) {
                                                      return Center(
                                                          child: TextWidget(
                                                              stream.error
                                                                  .toString(),
                                                              color:
                                                                  AppConstants
                                                                      .clrBlack,
                                                              fontSize: 20));
                                                    }
                                                    QuerySnapshot
                                                        querySnapshot =
                                                        stream.data;
                                                    if (querySnapshot == null ||
                                                        querySnapshot.size ==
                                                            0) {
                                                      if (querySnapshot ==
                                                          null) {
                                                        return Container();
                                                      } else {
                                                        return TextWidget("0",
                                                            color: AppConstants
                                                                .clrBlack,
                                                            fontSize:
                                                                AppConstants
                                                                    .size_medium,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold);
                                                      }
                                                    } else {
                                                      return TextWidget(
                                                          querySnapshot.size
                                                              .toString(),
                                                          color: AppConstants
                                                              .clrBlack,
                                                          fontSize: AppConstants
                                                              .size_medium,
                                                          fontWeight:
                                                              FontWeight.bold);
                                                    }
                                                  },
                                                ),
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
                                          color: AppConstants.clrTransparent,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                StreamBuilder(
                                                  stream: ClubService()
                                                      .getClubByUIDQuery()
                                                      .snapshots(),
                                                  builder: (context, stream) {
                                                    if (stream.hasError) {
                                                      return Center(
                                                          child: TextWidget(
                                                              stream.error
                                                                  .toString(),
                                                              color:
                                                                  AppConstants
                                                                      .clrBlack,
                                                              fontSize: 20));
                                                    }
                                                    QuerySnapshot
                                                        querySnapshot =
                                                        stream.data;
                                                    if (querySnapshot == null ||
                                                        querySnapshot.size ==
                                                            0) {
                                                      if (querySnapshot ==
                                                          null) {
                                                        return Container();
                                                      } else {
                                                        return TextWidget("0",
                                                            color: AppConstants
                                                                .clrBlack,
                                                            fontSize:
                                                                AppConstants
                                                                    .size_medium,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold);
                                                      }
                                                    } else {
                                                      return TextWidget(
                                                          querySnapshot.size
                                                              .toString(),
                                                          color: AppConstants
                                                              .clrBlack,
                                                          fontSize: AppConstants
                                                              .size_medium,
                                                          fontWeight:
                                                              FontWeight.bold);
                                                    }
                                                  },
                                                ),
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
                                      StreamBuilder(
                                        stream: FollowService()
                                            .checkFollowByUser(widget.uId)
                                            .snapshots(),
                                        builder: (context, stream) {
                                          if (stream != null &&
                                              stream.data != null) {
                                            return GestureDetector(
                                                onTap: () {
                                                  if (stream.data.size > 0) {
                                                    FollowService()
                                                        .deleteFollow(
                                                            FollowModel
                                                                .fromJson(stream
                                                                    .data
                                                                    .docs[0]
                                                                    .data()),
                                                            userModel
                                                                    .firstName +
                                                                " " +
                                                                userModel
                                                                    .lastName,
                                                            userModel.imageUrl);
                                                  } else {
                                                    FollowService().createFollow(
                                                        new FollowModel(
                                                            followBy:
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser
                                                                    .uid,
                                                            followTo:
                                                                widget.uId,
                                                            status: 1),
                                                        userModel.firstName +
                                                            " " +
                                                            userModel.lastName,
                                                        userModel.imageUrl);
                                                  }
                                                },
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    height: 36,
                                                    margin: EdgeInsets.only(
                                                        right: 16),
                                                    padding: EdgeInsets.only(
                                                        left: 24, right: 24),
                                                    decoration: BoxDecoration(
                                                        color: (stream.data.size > 0)
                                                            ? AppConstants
                                                                .clrPrimary
                                                            : AppConstants
                                                                .clrWhite,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        border: (stream.data.size > 0)
                                                            ? null
                                                            : Border.all(
                                                                width: 1,
                                                                color: AppConstants
                                                                    .clrPrimary)),
                                                    child: TextWidget((stream.data.size > 0) ? AppConstants.str_following : AppConstants.str_follow,
                                                        color: (stream.data.size > 0)
                                                            ? AppConstants.clrWhite
                                                            : AppConstants.clrPrimary,
                                                        fontSize: AppConstants.size_medium,
                                                        fontWeight: FontWeight.bold,
                                                        maxLines: 1,
                                                        textOverflow: TextOverflow.ellipsis)));
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
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
                            (userModelRecommendedBy != null)
                                ? Row(children: [
                                    Container(
                                        height: 40,
                                        width: 40,
                                        margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            color: AppConstants.clrProfileBG,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    userModelRecommendedBy
                                                        .imageUrl),
                                                fit: BoxFit.fill),
                                            shape: BoxShape.circle)),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                              AppConstants.str_joined +
                                                  datetimeToString(
                                                      userModelRecommendedBy
                                                          .joinedDate),
                                              color: AppConstants.clrBlack,
                                              fontSize: AppConstants
                                                  .size_small_medium,
                                              fontWeight: FontWeight.w400),
                                          TextWidget(
                                              AppConstants.str_recommended_by +
                                                  " " +
                                                  userModelRecommendedBy
                                                      .firstName +
                                                  " " +
                                                  userModelRecommendedBy
                                                      .lastName,
                                              color: AppConstants.clrBlack,
                                              fontSize:
                                                  AppConstants.size_medium,
                                              fontWeight: FontWeight.w400),
                                        ])
                                  ])
                                : Container()
                          ])
                    : Center(child: CircularProgressIndicator()))));
  }
}

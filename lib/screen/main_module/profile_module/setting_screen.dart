import 'package:audioroom/firestore/network/user_fire.dart';
import 'package:audioroom/helper/shar_pref.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:audioroom/screen/main_module/profile_module/hidden_rooms_screen.dart';
import 'package:audioroom/screen/main_module/profile_module/interests_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/switch_widget.dart';
import 'package:audioroom/screen/sign_module/login_screen.dart';
import 'package:audioroom/helper/navigate_effect.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(context, "Settings", true, false, null),
      body: SafeArea(
        child: Container(
          child: ListView(
            shrinkWrap: true,
            children: [
              settingNotificationWidget(context, "Notification"),
              settingListWidget(context, "Interests", () {
                Navigator.push(
                    context, NavigatePageRoute(context, InterestsScreen()));
              }),
              settingListWidget(context, "Hidden Rooms", () {
                Navigator.push(
                    context, NavigatePageRoute(context, HiddenRoomsScreen()));
              }),
              settingListWidget(context, "What’s New", () {
                showToast("What’s New Clicked!!");
              }),
              settingListWidget(context, "FAQ / Contact Us", () {
                showToast("FAQ / Contact Us Clicked!!");
              }),
              settingListWidget(context, "Report an Incident", () {
                showToast("Report an Incident Clicked!!");
              }),
              settingListWidget(context, "Community Guidelines", () {
                showToast("Community Guidelines Clicked!!");
              }),
              settingListWidget(context, "Terms of Service", () {
                showToast("Terms of Service Clicked!!");
              }),
              settingConnectWidget(context, "Connect to Twitter", () {
                showToast("Connect to Twitter Clicked!!");
              }),
              settingConnectWidget(context, "Connect to Instagram", () {
                showToast("Connect to Instagram Clicked!!");
              }),
              settingLogoutWidget(context, "Logout"),
            ],
          ),
        ),
      ),
    );
  }

  Widget settingNotificationWidget(BuildContext context, String option) {
    return Container(
      alignment: Alignment.center,
      color: AppConstants.clrWhite,
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    child: TextWidget(option,
                        color: AppConstants.clrBlack,
                        fontSize: AppConstants.size_medium_large,
                        fontWeight: FontWeight.w500),
                  ),
                  flex: 1),
              SwitchWidget(isNotification, () {
                isNotification = !isNotification;
                setState(() {});
              }),
              SizedBox(width: 16)
            ],
          ),
          DividerWidget(height: 1)
        ],
      ),
    );
  }

  Widget settingListWidget(
      BuildContext context, String option, Function onClick) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        alignment: Alignment.center,
        color: AppConstants.clrWhite,
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16),
                      child: TextWidget(option,
                          color: AppConstants.clrBlack,
                          fontSize: AppConstants.size_medium_large,
                          fontWeight: FontWeight.w500),
                    ),
                    flex: 1),
                Icon(Icons.arrow_forward_ios, size: 18),
                SizedBox(width: 16)
              ],
            ),
            DividerWidget(height: 1)
          ],
        ),
      ),
    );
  }

  Widget settingConnectWidget(
      BuildContext context, String option, Function onClick) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        alignment: Alignment.center,
        color: AppConstants.clrWhite,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              child: TextWidget(option,
                  color: AppConstants.clrBlack,
                  fontSize: AppConstants.size_medium_large,
                  fontWeight: FontWeight.bold),
            ),
            DividerWidget(height: 1)
          ],
        ),
      ),
    );
  }

  Widget settingLogoutWidget(BuildContext context, String option) {
    return GestureDetector(
      onTap: () {
        UserService()
            .getUserByReferences(FirebaseAuth.instance.currentUser.uid)
            .then((userModel) {
          userModel.isOnline = false;
          userModel.offlineDate = DateTime.now();
          UserService().updateUser(userModel);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          FirebaseAuth.instance.signOut();
          SharePref.clearAllPref();
          Navigator.pushReplacement(
              context, NavigatePageRoute(context, LoginScreen()));
        });
      },
      child: Container(
        alignment: Alignment.center,
        color: AppConstants.clrWhite,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              child: TextWidget(option,
                  color: AppConstants.clrRedAccent,
                  fontSize: AppConstants.size_medium_large,
                  fontWeight: FontWeight.bold),
            ),
            DividerWidget(height: 1)
          ],
        ),
      ),
    );
  }
}

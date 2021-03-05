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
              settingListWidget(context, "Interests"),
              settingListWidget(context, "What’s New"),
              settingListWidget(context, "FAQ / Contact Us"),
              settingListWidget(context, "Report an Incident"),
              settingListWidget(context, "Community Guidelines"),
              settingListWidget(context, "Terms of Service"),
              settingConnectWidget(context, "Connect to Twitter"),
              settingConnectWidget(context, "Connect to Instagram"),
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

  Widget settingListWidget(BuildContext context, String option) {
    return Container(
      alignment: Alignment.center,
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
    );
  }

  Widget settingConnectWidget(BuildContext context, String option) {
    return Container(
      alignment: Alignment.center,
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
    );
  }

  Widget settingLogoutWidget(BuildContext context, String option) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context, NavigatePageRoute(context, LoginScreen()));
      },
      child: Container(
        alignment: Alignment.center,
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

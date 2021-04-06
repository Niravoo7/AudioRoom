import 'dart:async';
import 'package:audioroom/custom_widget/logo_widget.dart';
import 'package:audioroom/helper/navigate_effect.dart';
import 'package:audioroom/helper/shar_pref.dart';
import 'package:audioroom/screen/main_module/main_screen.dart';
import 'package:audioroom/screen/sign_module/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<SplashScreen> {
  String mobileNo;

  startTime() async {
    mobileNo = await SharePref.prefGetString(SharePref.keyMobileNo, "");
    var _duration = Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  Future navigationPage() async {
    if (mobileNo != null && mobileNo.length > 0) {
      //Navigator.pushReplacement(context, NavigatePageRoute(context, AccountCreatedScreen()));
      Navigator.pushReplacement(
          context, NavigatePageRoute(context, MainScreen()));
    } else {
      //Navigator.pushReplacement(context, NavigatePageRoute(context, BasicInfoScreen()));
      Navigator.pushReplacement(context, NavigatePageRoute(context, LoginScreen()));
    }
  }

  @override
  initState() {
    super.initState();
    //FirebaseCrashlytics.instance.crash();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                child: Center(
                    child: LogoWidgetText(
                        width: MediaQuery.of(context).size.width - 200)))));
  }
}

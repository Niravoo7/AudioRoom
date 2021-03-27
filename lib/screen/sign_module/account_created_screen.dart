import 'package:audioroom/custom_widget/button_widget.dart';
import 'package:audioroom/custom_widget/flexible_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/helper/navigate_effect.dart';
import 'package:audioroom/screen/main_module/main_screen.dart';
import 'package:flutter/services.dart';

class AccountCreatedScreen extends StatefulWidget {
  @override
  _AccountCreatedScreenState createState() => _AccountCreatedScreenState();
}

class _AccountCreatedScreenState extends State<AccountCreatedScreen> {
  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      showToast("Press again to exit!");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: CommonAppBar(context, "Account Created", false, false, null),
        body: SafeArea(
            child: GestureDetector(
          onTap: () {
            //Navigator.push(context, NavigatePageRoute(context, MainScreen()));
          },
          child: Container(
              padding: EdgeInsets.all(16),
              color: AppConstants.clrTransparent,
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    FlexibleWidget(1),
                    Image.asset(AppConstants.img_green_true,
                        height: 50, width: 50),
                    SizedBox(height: 16),
                    TextWidget(AppConstants.str_account_created,
                        color: AppConstants.clrBlack,
                        fontSize: AppConstants.size_medium_large,
                        fontWeight: FontWeight.w400,
                        maxLines: 5,
                        textAlign: TextAlign.center),
                    FlexibleWidget(1),
                    ButtonWidget(context, AppConstants.str_continue, () {
                      Navigator.push(
                          context, NavigatePageRoute(context, MainScreen()));
                    })
                  ]))),
        )),
      ),
    );
  }
}

import 'package:audioroom/custom_widget/progress.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioroom/helper/constants.dart';

void showAlert(BuildContext context, String strMessage, String strTitle,
    String strButton) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: TextWidget(strTitle),
            content: TextWidget(strMessage),
            actions: <Widget>[
              FlatButton(
                  child: Text(strButton),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          ));
}

void onLoading(BuildContext context, String strMessage) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          alignment: Alignment.center,
          height: 100,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(right: 30),
                child: CupertinoActivityIndicator(
                  radius: 30.0,
                ),
              ),
              Flexible(
                child: TextWidget(
                  strMessage,
                  maxLines: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.clrBlack,
                ),
                flex: 1,
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<bool> onWillPops(BuildContext context) {
  return showDialog(
        context: context,
        // ignore: deprecated_member_use
        child: AlertDialog(
          title: TextWidget(AppConstants.str_are_you_sure_you_want_to_exit),
          content: TextWidget(AppConstants.str_exitApp),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: TextWidget(AppConstants.str_no),
            ),
            FlatButton(
              onPressed: () => SystemNavigator.pop(),
              child: TextWidget(AppConstants.str_yes),
            ),
          ],
        ),
      ) ??
      false;
}

void showApiLoader() {
  showDialog(
    context: navigatorKey.currentContext,
    barrierDismissible: false,
    builder: (ctx) {
      return Dialog(
        insetPadding: EdgeInsets.fromLTRB(
            (MediaQuery.of(navigatorKey.currentContext).size.width - 100) / 2,
            0,
            (MediaQuery.of(navigatorKey.currentContext).size.width - 100) / 2,
            0),
        child: Wrap(
          children: [
            Container(
                height: 100,
                alignment: Alignment.center,
                child: Progress(color: AppConstants.clrBlack)),
          ],
        ),
      );
    },
  );
}

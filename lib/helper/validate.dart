
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';

Future<bool> checkInternetConnect() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppConstants.clrDarkGrey,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget noRecordFoundView() {
  return TextWidget(AppConstants.str_no_record_found);
}

String datetimeToString(DateTime dateTime) {
  return dateTime.day.toString() +
      "/" +
      dateTime.month.toString() +
      "/" +
      dateTime.year.toString() +
      " " +
      dateTime.hour.toString() +
      ":" +
      dateTime.minute.toString();
}

int dateDifference(DateTime dateTime) {
  return DateTime.now().difference(dateTime).inMinutes;
}

String strDateDifference(int minute) {
  if (minute < 60) {
    return minute.toString() + " mins ago";
  } else if (minute >= 60 && minute < 1440) {
    return (minute ~/ 60).toString() + " hrs ago";
  } else {
    return (minute ~/ 1440).toString() + " days ago";
  }
}

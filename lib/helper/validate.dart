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

import 'package:audioroom/custom_widget/flexible_widget.dart';
import 'package:audioroom/custom_widget/button_widget.dart';
import 'package:audioroom/custom_widget/text_field_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/dialogues.dart';
import 'package:audioroom/helper/navigate_effect.dart';
import 'package:audioroom/helper/shar_pref.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:audioroom/main.dart';
import 'package:audioroom/screen/sign_module/basic_info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EnterCodeScreen extends StatefulWidget {
  String verificationId;

  EnterCodeScreen(this.verificationId);

  @override
  _EnterCodeScreenState createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    codeController.text = "123456";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
            appBar: CommonAppBar(context, "Enter Code", true, false, null),
            body: SafeArea(
                child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        inputFields(),
                        ButtonWidget(context, AppConstants.str_continue, () {
                          validateInputs(context);
                        }),
                        FlexibleWidget(1),
                      ],
                    )))));
  }

  Widget inputFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        TextFieldWidget(
            controller: codeController, keyboardType: TextInputType.number),
        SizedBox(height: 8),
        TextWidget(AppConstants.str_resend_otp,
            color: AppConstants.clrPrimary,
            fontSize: AppConstants.size_medium,
            fontWeight: FontWeight.w500),
      ],
    );
  }

  void validateInputs(BuildContext con) {
    if (codeController.text.trim().isEmpty) {
      showToast(AppConstants.str_enter_code);
    } else if (codeController.text.trim().length != 6) {
      showToast(AppConstants.str_valid_code);
    } else {
      submitEvent();
    }
  }

  Future<void> submitEvent() async {
    showApiLoader();
    FirebaseAuth auth = FirebaseAuth.instance;
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: codeController.text.trim());
    await auth.signInWithCredential(phoneAuthCredential).then((userCredential) {
      SharePref.prefSetString(SharePref.keyUId, userCredential.user.uid);
      SharePref.prefSetString(
          SharePref.keyMobileNo, userCredential.user.phoneNumber);
      Navigator.pop(navigatorKey.currentContext);
      Navigator.push(context, NavigatePageRoute(context, BasicInfoScreen()));
    });
  }
}

import 'package:audioroom/custom_widget/flexible_widget.dart';
import 'package:audioroom/custom_widget/button_widget.dart';
import 'package:audioroom/custom_widget/text_field_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/firestore/model/user_model.dart';
import 'package:audioroom/firestore/network/user_fire.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/dialogues.dart';
import 'package:audioroom/helper/navigate_effect.dart';
import 'package:audioroom/helper/print_log.dart';
import 'package:audioroom/helper/shar_pref.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:audioroom/main.dart';
import 'package:audioroom/screen/main_module/main_screen.dart';
import 'package:audioroom/screen/sign_module/basic_info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EnterCodeScreen extends StatefulWidget {
  String verificationId;
  String countryMobile;

  EnterCodeScreen(this.verificationId, this.countryMobile);

  @override
  _EnterCodeScreenState createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  TextEditingController codeController = TextEditingController();
  String verificationId;

  @override
  void initState() {
    super.initState();
    verificationId = widget.verificationId;
    //codeController.text = "123456";
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
        GestureDetector(
          onTap: () async {
            showApiLoader();
            FirebaseAuth auth = FirebaseAuth.instance;
            await auth.verifyPhoneNumber(
              phoneNumber: widget.countryMobile,
              timeout: const Duration(seconds: 5),
              verificationCompleted: (PhoneAuthCredential credential) async {
                PrintLog.printMessage(
                    "verifyPhoneNumber -> verificationCompleted");
                await auth.signInWithCredential(credential);
              },
              verificationFailed: (FirebaseAuthException e) {
                Navigator.pop(navigatorKey.currentContext);
                PrintLog.printMessage(
                    "verifyPhoneNumber -> verificationFailed");
                if (e.code == 'invalid-phone-number') {
                  showToast(AppConstants.str_valid_mobile_number);
                } else {
                  showToast(e.code);
                }
              },
              codeSent: (String verificationId, int resendToken) async {
                Navigator.pop(navigatorKey.currentContext);
                PrintLog.printMessage(
                    "verifyPhoneNumber -> codeSent $verificationId");
                this.verificationId = verificationId;
                showToast("Otp send successfully!!!");
              },
              codeAutoRetrievalTimeout: (String verificationId) {
                PrintLog.printMessage(
                    "verifyPhoneNumber -> codeAutoRetrievalTimeout $verificationId");
              },
            );
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: TextWidget(AppConstants.str_resend_otp,
                color: AppConstants.clrPrimary,
                fontSize: AppConstants.size_medium,
                fontWeight: FontWeight.w500),
          ),
        ),
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
        verificationId: verificationId, smsCode: codeController.text.trim());

    await auth
        .signInWithCredential(phoneAuthCredential)
        .then((userCredential) async {
      SharePref.prefSetString(SharePref.keyUId, userCredential.user.uid);
      SharePref.prefSetString(
          SharePref.keyMobileNo, userCredential.user.phoneNumber);
      Navigator.pop(navigatorKey.currentContext);

      UserModel userModel =
          await UserService().getUserByReferences(userCredential.user.uid);
      if (userModel == null) {
        Navigator.push(context, NavigatePageRoute(context, BasicInfoScreen()));
      } else {
        Navigator.push(context, NavigatePageRoute(context, MainScreen()));
      }
    }).onError((error, stackTrace) {
      Navigator.pop(navigatorKey.currentContext);
      showToast("Wrong OTP!");
    });
  }
}

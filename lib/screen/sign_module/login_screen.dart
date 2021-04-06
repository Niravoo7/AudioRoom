import 'dart:convert';

import 'package:audioroom/custom_widget/flexible_widget.dart';
import 'package:audioroom/custom_widget/button_widget.dart';
import 'package:audioroom/custom_widget/logo_widget.dart';
import 'package:audioroom/custom_widget/mobile_text_field_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/dialogues.dart';
import 'package:audioroom/helper/navigate_effect.dart';
import 'package:audioroom/helper/print_log.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:audioroom/library/country_code_picker/country_code_picker.dart';
import 'package:audioroom/library/country_code_picker/country_codes.dart';
import 'package:audioroom/main.dart';
import 'package:audioroom/screen/sign_module/enter_code_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;

  TextEditingController mobileNumberController = TextEditingController();

  CountryCode countryCode = new CountryCode(
      dialCode: "+93",
      code: "AF",
      flagUri: "flags/af.png",
      name: "Afghanistan");

  //Position currentPosition;

  @override
  void initState() {
    super.initState();
    //mobileNumberController.text = "3216549870";
    determinePosition();
  }

  Future<void> determinePosition() async {
    //bool serviceEnabled;
    //LocationPermission permission;
    /*serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //return Future.error('Location services are disabled.');
      Geolocator.openLocationSettings().then((value) {
        return determinePosition();
      });
    }*/

    /*permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }*/

    /*currentPosition = await Geolocator.getLastKnownPosition(
        forceAndroidLocationManager: true);
    PrintLog.printMessage(
        "currentPosition -> ${currentPosition.latitude} ${currentPosition.longitude}");

    Coordinates coordinates =
        new Coordinates(currentPosition.latitude, currentPosition.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    String cc = addresses.first.countryCode;*/

    String cc;

    try {
      http.get(Uri.parse('http://ip-api.com/json')).then((value) {
        print(json.decode(value.body)['country'].toString());
        cc = json.decode(value.body)['countryCode'].toString();
        PrintLog.printMessage("currentPosition -> $cc");
        Map<String, String> code =
            codes.where((element) => element['code'] == cc).toList()[0];
        PrintLog.printMessage(
            "currentPosition -> ${code['code']} ${code['name']} ${code['dial_code']} ");
        countryCode = new CountryCode(
            dialCode: code['dial_code'],
            code: code['code'],
            flagUri: "flags/${code['code'].toLowerCase()}.png",
            name: code['name']);

        setState(() {});
      });
    } catch (err) {
      //handleError
    }
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
            appBar: CommonAppBar(
                context, "🙏 Welcome to AudioRoom", false, false, null),
            body: SafeArea(
                child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FlexibleWidget(1),
                        LogoWidgetText(height: 36),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 40),
                          child: TextWidget(AppConstants.str_lorem,
                              color: AppConstants.clrBlack,
                              fontSize: AppConstants.size_medium_large,
                              maxLines: 7,
                              fontWeight: FontWeight.w400),
                        ),
                        inputFields(),
                        ButtonWidget(context, AppConstants.str_request_code,
                            () {
                          validateInputs(context);
                        }),
                      ],
                    )))));
  }

  Widget inputFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget(AppConstants.str_your_mobile_number,
            color: AppConstants.clrBlack,
            fontSize: AppConstants.size_medium_large,
            fontWeight: FontWeight.bold),
        SizedBox(height: 8),
        MobileTextFieldWidget(
            controller: mobileNumberController,
            countryCode: countryCode,
            keyboardType: TextInputType.number,
            onCountryCodeChange: (c) {
              countryCode = c;
            }),
      ],
    );
  }

  Future<void> validateInputs(BuildContext con) async {
    if (mobileNumberController.text.trim().isEmpty) {
      showToast(AppConstants.str_enter_mobile_number);
    } else if (mobileNumberController.text.length < 5 ||
        mobileNumberController.text.length > 15) {
      showToast(AppConstants.str_valid_mobile_number);
    } else {
      submitEvent();
    }
  }

  Future<void> submitEvent() async {
    showApiLoader();
    FirebaseAuth auth = FirebaseAuth.instance;
    PrintLog.printMessage(
        "verifyPhoneNumber -> ${countryCode.dialCode} ${mobileNumberController.text}");

    await auth.verifyPhoneNumber(
      phoneNumber: '${countryCode.dialCode} ${mobileNumberController.text}',
      timeout: const Duration(seconds: 5),
      verificationCompleted: (PhoneAuthCredential credential) async {
        PrintLog.printMessage("verifyPhoneNumber -> verificationCompleted");
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        Navigator.pop(navigatorKey.currentContext);
        PrintLog.printMessage("verifyPhoneNumber -> verificationFailed");
        if (e.code == 'invalid-phone-number') {
          showToast(AppConstants.str_valid_mobile_number);
        } else {
          showToast(e.code);
        }
      },
      codeSent: (String verificationId, int resendToken) async {
        Navigator.pop(navigatorKey.currentContext);
        PrintLog.printMessage("verifyPhoneNumber -> codeSent $verificationId");
        Navigator.push(
            context,
            NavigatePageRoute(
                context,
                EnterCodeScreen(verificationId,
                    '${countryCode.dialCode} ${mobileNumberController.text}')));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        PrintLog.printMessage(
            "verifyPhoneNumber -> codeAutoRetrievalTimeout $verificationId");
      },
    );

    //Navigator.push(context, NavigatePageRoute(context, EnterCodeScreen()));
  }
}

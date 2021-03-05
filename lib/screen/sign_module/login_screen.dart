import 'package:audioroom/custom_widget/flexible_widget.dart';
import 'package:audioroom/custom_widget/button_widget.dart';
import 'package:audioroom/custom_widget/logo_widget.dart';
import 'package:audioroom/custom_widget/mobile_text_field_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/navigate_effect.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:audioroom/library/country_code_picker/country_code_picker.dart';
import 'package:audioroom/screen/sign_module/enter_code_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;

  TextEditingController mobileNumberController = TextEditingController();

  CountryCode countryCode = new CountryCode(
      dialCode: "+91", code: "IN", flagUri: "flags/in.png", name: "India");

  @override
  void initState() {
    super.initState();
    mobileNumberController.text = "1234567890";
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
            keyboardType: TextInputType.number),
      ],
    );
  }

  void validateInputs(BuildContext con) {
    if (mobileNumberController.text.trim().isEmpty) {
      showToast(AppConstants.str_enter_mobile_number);
    } else if (mobileNumberController.text.length != 10) {
      showToast(AppConstants.str_valid_mobile_number);
    } else {
      submitEvent();
    }
  }

  void submitEvent() {
    Navigator.push(context, NavigatePageRoute(context, EnterCodeScreen()));
  }
}

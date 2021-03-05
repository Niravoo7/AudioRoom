import 'package:audioroom/custom_widget/flexible_widget.dart';
import 'package:audioroom/custom_widget/button_widget.dart';
import 'package:audioroom/custom_widget/text_field_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/navigate_effect.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:audioroom/screen/sign_module/basic_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnterCodeScreen extends StatefulWidget {
  @override
  _EnterCodeScreenState createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    codeController.text = "1234";
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
          appBar:  CommonAppBar(
              context, "Enter Code", true, false, null),
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
    } else if (codeController.text.trim().length != 4) {
      showToast(AppConstants.str_valid_code);
    } else {
      submitEvent();
    }
  }

  void submitEvent() {
    Navigator.push(context, NavigatePageRoute(context, BasicInfoScreen()));
  }
}

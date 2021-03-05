import 'package:audioroom/custom_widget/button_widget.dart';
import 'package:audioroom/custom_widget/text_field_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/navigate_effect.dart';
import 'package:audioroom/helper/print_log.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:audioroom/screen/sign_module/choose_your_interests_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:audioroom/library/image_picker/image_picker_handler.dart';
import 'package:image_picker/image_picker.dart';

class BasicInfoScreen extends StatefulWidget {
  @override
  _BasicInfoScreenState createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen>
    with TickerProviderStateMixin, ImagePickerListener {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  AnimationController _controller;
  ImagePickerHandler imagePicker;
  PickedFile imageFile;

  @override
  void initState() {
    super.initState();
    firstNameController.text = "test";
    lastNameController.text = "test";
    userNameController.text = "test";

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
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
              context, "Basic Information", true, false, null),
            body: SafeArea(
                child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: ListView(
                            children: [
                              profileWidget(),
                              SizedBox(height: 16),
                              inputFields(),
                            ],
                          ),
                          flex: 1,
                        ),
                        ButtonWidget(context, AppConstants.str_continue, () {
                          validateInputs(context);
                        }),
                      ],
                    )))));
  }

  Widget profileWidget() {
    return Container(
        height: 80,
        width: 80,
        alignment: Alignment.centerLeft,
        child: (imageFile == null)
            ? GestureDetector(
                child: Container(
                    height: 80,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppConstants.clrGrey,
                        borderRadius: BorderRadius.circular(35)),
                    child: Icon(Icons.camera_alt,
                        size: 22, color: AppConstants.clrBlack)),
                onTap: () {
                  imagePicker.showDialog(context);
                },
              )
            : Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(io.File(imageFile.path)),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(35))),
                  GestureDetector(
                    child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppConstants.img_close)))),
                    onTap: () {
                      imageFile = null;
                      setState(() {});
                    },
                  )
                ],
              ));
  }

  Widget inputFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget(AppConstants.str_first_name,
            color: AppConstants.clrBlack,
            fontSize: AppConstants.size_medium_large,
            fontWeight: FontWeight.bold),
        SizedBox(height: 8),
        TextFieldWidget(
            controller: firstNameController, keyboardType: TextInputType.text),
        SizedBox(height: 16),
        TextWidget(AppConstants.str_last_name,
            color: AppConstants.clrBlack,
            fontSize: AppConstants.size_medium_large,
            fontWeight: FontWeight.bold),
        SizedBox(height: 8),
        TextFieldWidget(
            controller: lastNameController, keyboardType: TextInputType.text),
        SizedBox(height: 16),
        TextWidget(AppConstants.str_choose_your_username,
            color: AppConstants.clrBlack,
            fontSize: AppConstants.size_medium_large,
            fontWeight: FontWeight.bold),
        SizedBox(height: 8),
        TextFieldWidget(
            controller: userNameController, keyboardType: TextInputType.text),
      ],
    );
  }

  void validateInputs(BuildContext con) {
    if (firstNameController.text.trim().isEmpty) {
      showToast(AppConstants.str_enter_first_name);
    } else if (lastNameController.text.trim().isEmpty) {
      showToast(AppConstants.str_enter_last_name);
    } else if (userNameController.text.trim().isEmpty) {
      showToast(AppConstants.str_enter_user_name);
    } else {
      submitEvent();
    }
  }

  void submitEvent() {
    Navigator.push(
        context, NavigatePageRoute(context, ChooseYourInterestsScreen()));
  }

  @override
  userImage(PickedFile image) {
    PrintLog.printMessage("userImage -> ${image.path}");
    imageFile = image;
    setState(() {});
  }
}

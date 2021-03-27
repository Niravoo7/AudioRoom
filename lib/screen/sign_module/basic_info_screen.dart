import 'dart:io';
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
import 'package:audioroom/helper/validate.dart';
import 'package:audioroom/main.dart';
import 'package:audioroom/screen/sign_module/choose_your_interests_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:audioroom/library/image_picker/image_picker_handler.dart';
import 'package:flutter/services.dart';
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
  TextEditingController aboutController = TextEditingController();

  AnimationController _controller;
  ImagePickerHandler imagePicker;
  PickedFile imageFile;

  final _firebaseStorage = FirebaseStorage.instance;
  String profileUrl;

  @override
  void initState() {
    super.initState();
    //firstNameController.text = "test";
    //lastNameController.text = "test";
    //userNameController.text = "testing";
    //aboutController.text = "about info";

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
            appBar:
                CommonAppBar(context, "Basic Information", true, false, null),
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
            controller: userNameController,
            keyboardType: TextInputType.name,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[a-z]"))
            ]),
        SizedBox(height: 16),
        TextWidget(AppConstants.str_about,
            color: AppConstants.clrBlack,
            fontSize: AppConstants.size_medium_large,
            fontWeight: FontWeight.bold),
        SizedBox(height: 8),
        TextFieldWidget(
            controller: aboutController,
            keyboardType: TextInputType.text,
            lines: 4),
      ],
    );
  }

  void validateInputs(BuildContext con) {
    if (imageFile == null) {
      showToast(AppConstants.str_enter_profile_image);
    } else if (firstNameController.text.trim().isEmpty) {
      showToast(AppConstants.str_enter_first_name);
    } else if (lastNameController.text.trim().isEmpty) {
      showToast(AppConstants.str_enter_last_name);
    } else if (userNameController.text.trim().isEmpty) {
      showToast(AppConstants.str_enter_user_name);
    } else if (aboutController.text.trim().isEmpty) {
      showToast(AppConstants.str_enter_about);
    } else {
      checkUserName();
    }
  }

  Future<void> checkUserName() async {
    PrintLog.printMessage('checkUserName -> ${userNameController.text.trim()}');
    await UserService()
        .getUserByUserName("@" + userNameController.text.trim())
        .then((userModel) {
      if (userModel != null) {
        showToast("Username is unavailable. please try with another one.");
      } else {
        //showToast("okay");
        uploadProfileImage();
      }
    });
  }

  Future<void> uploadProfileImage() async {
    showApiLoader();
    var snapshot = await _firebaseStorage
        .ref()
        .child('user_profile/${DateTime.now().millisecondsSinceEpoch}.jpeg')
        .putFile(File(imageFile.path))
        .whenComplete(() => {});

    profileUrl = await snapshot.ref.getDownloadURL();
    PrintLog.printMessage('imageUrl -> $profileUrl');
    submitEvent();
  }

  void submitEvent() {
    User user = FirebaseAuth.instance.currentUser;
    user.updateProfile(
        displayName: userNameController.text.toLowerCase(),
        photoURL: profileUrl);
    UserModel userModel = UserModel(
        displayName: userNameController.text.toLowerCase(),
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        tagName: "@${userNameController.text.toLowerCase()}",
        followers: 0,
        following: 0,
        clubJoined: 0,
        aboutInfo: aboutController.text,
        imageUrl: profileUrl,
        instagramName: "",
        twitterName: "",
        isDelete: false,
        joinedDate: DateTime.now(),
        uId: user.uid,
        recommendedBy: null,
        phoneNumber: user.phoneNumber);
    UserService().createUser(userModel);
    Navigator.pop(navigatorKey.currentContext);
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

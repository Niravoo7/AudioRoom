
import 'package:audioroom/library/image_picker/image_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHandler {
  ImagePickerDialog imagePicker;
  AnimationController _controller;
  ImagePickerListener _listener;

  ImagePickerHandler(this._listener, this._controller);

  openCamera() async {
    imagePicker.dismissDialog();
    var image =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(source: ImageSource.camera);

    _listener.userImage(image);
  }

  openGallery() async {
    imagePicker.dismissDialog();
    var image =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    _listener.userImage(image);
  }

  void init() {
    imagePicker = new ImagePickerDialog(this, _controller);
    imagePicker.initState();
  }

  showDialog(BuildContext context) {
    imagePicker.getImage(context);
  }
}

abstract class ImagePickerListener {
  userImage(PickedFile image);
}

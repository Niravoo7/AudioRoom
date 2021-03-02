import 'dart:async';

import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/library/image_picker/image_picker_handler.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImagePickerDialog extends StatelessWidget {
  ImagePickerHandler _listener;
  AnimationController _controller;
  BuildContext context;

  ImagePickerDialog(this._listener, this._controller);

  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;

  void initState() {
    _drawerContentsOpacity = new CurvedAnimation(
      parent: new ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = new Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  getImage(BuildContext context) {
    if (_controller == null ||
        _drawerDetailsPosition == null ||
        _drawerContentsOpacity == null) {
      return;
    }
    _controller.forward();
    showDialog(
      context: context,
      builder: (BuildContext context) => new SlideTransition(
        position: _drawerDetailsPosition,
        child: new FadeTransition(
          opacity: new ReverseAnimation(_drawerContentsOpacity),
          child: this,
        ),
      ),
    );
  }

  void dispose() {
    _controller.dispose();
  }

  startTime() async {
    var _duration = new Duration(milliseconds: 200);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pop(context);
  }

  dismissDialog() {
    _controller.reverse();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new Material(
        type: MaterialType.transparency,
        child: Opacity(
          opacity: 1.0,
          child: Container(
            padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                    onTap: () => _listener.openCamera(),
                    child: roundedButton(
                        "Camera",
                        EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                        AppConstants.clrBlack,
                        Color(0xFFFFFFFF))),
                GestureDetector(
                    onTap: () => _listener.openGallery(),
                    child: roundedButton(
                        "Gallery",
                        EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                        AppConstants.clrBlack,
                        Color(0xFFFFFFFF))),
                GestureDetector(
                    onTap: () => dismissDialog(),
                    child: roundedButton(
                        "Cancel",
                        EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                        AppConstants.clrBlack,
                        Color(0xFFFFFFFF))),
              ],
            ),
          ),
        ));
  }

  Widget roundedButton(
      String buttonLabel, EdgeInsets margin, Color bgColor, Color textColor) {
    var loginBtn = Container(
      margin: margin,
      padding: EdgeInsets.all(12),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: AppConstants.clrBlack,
        borderRadius: BorderRadius.all(Radius.circular(100.0)),
        border: Border.all(color: AppConstants.clrWhite, width: 1),
      ),
      child: TextWidget(buttonLabel,
          maxLines: 1,
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold),
    );
    return loginBtn;
  }
}

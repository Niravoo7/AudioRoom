import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

class StartRoomScreen extends StatefulWidget {
  @override
  _StartRoomScreenState createState() => _StartRoomScreenState();
}

class _StartRoomScreenState extends State<StartRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
              child: TextWidget("StartRoomScreen",
                  color: AppConstants.clrBlack,
                  fontSize: AppConstants.size_medium_large,
                  fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }
}

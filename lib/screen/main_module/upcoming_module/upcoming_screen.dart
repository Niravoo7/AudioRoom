import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

class UpcomingScreen extends StatefulWidget {
  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
              child: TextWidget("UpcomingScreen",
                  color: AppConstants.clrBlack,
                  fontSize: AppConstants.size_medium_large,
                  fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }
}

import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

class ActiveUserScreen extends StatefulWidget {
  @override
  _ActiveUserScreenState createState() => _ActiveUserScreenState();
}

class _ActiveUserScreenState extends State<ActiveUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
              child: TextWidget("ActiveUserScreen",
                  color: AppConstants.clrBlack,
                  fontSize: AppConstants.size_medium_large,
                  fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }
}

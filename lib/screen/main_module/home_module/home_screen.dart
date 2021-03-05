import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
              child: TextWidget("HomeScreen",
                  color: AppConstants.clrBlack,
                  fontSize: AppConstants.size_medium_large,
                  fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }
}

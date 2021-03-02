
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Progress extends StatefulWidget {
  AnimationController rotationController;
  Color color;

  Progress({this.color});

  @override
  _ProgresState createState() => new _ProgresState(color);
}

class _ProgresState extends State<Progress> with TickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Color color;

  _ProgresState(this.color);

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(minutes: 1));

    animationController.repeat();

    setState(() {
      _visible = !_visible;
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: animationController,
      child: new Container(
        child: new Image.asset(AppConstants.img_progress,
            width: 35, height: 35, fit: BoxFit.fill, color: color),
      ),
      builder: (BuildContext context, Widget _widget) {
        return new Transform.rotate(
            angle: animationController.value * 200, child: _widget);
      },
    );
  }
}

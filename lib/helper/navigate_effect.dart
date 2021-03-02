import 'package:flutter/cupertino.dart';

class NavigatePageRoute extends CupertinoPageRoute {
  Widget _page;

  NavigatePageRoute(BuildContext context, Widget page)
      : super(builder: (context) => page) {
    _page = page;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: _page);
  }
}

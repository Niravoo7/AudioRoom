import 'package:audioroom/custom_widget/card_widget.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/ongoing_button_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/model/home_page_model.dart';
import 'package:flutter/material.dart';

class UpcomingScreen extends StatefulWidget {
  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  int _selectedIndex = 0;
  // ignore: deprecated_member_use
  List<PostListModel> postListModel = List<PostListModel>();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ignore: deprecated_member_use
    List<UserListModel> userListModel1 = List<UserListModel>();
    userListModel1.add(UserListModel(AppConstants.ic_user_profile, "Melinda Livsey"));
    userListModel1.add(UserListModel(AppConstants.ic_user_profile2, "Ben Bhai"));
    userListModel1.add(UserListModel(AppConstants.ic_user_profile, "Melinda Livsey"));
    userListModel1.add(UserListModel(AppConstants.ic_user_profile2, "Ben Bhai"));
    userListModel1.add(UserListModel(AppConstants.ic_user_profile, "Melinda Livsey"));

    postListModel.add(new PostListModel("TheFutur","Take The Guess Work Out Of Bidding - How To Bid",userListModel1,"5","132"));
    postListModel.add(new PostListModel("TheFutur","Take The Guess Work Out Of Bidding - How To Bid",userListModel1,"5","132"));
    postListModel.add(new PostListModel("TheFutur","Take The Guess Work Out Of Bidding - How To Bid",userListModel1,"5","132"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DividerWidget(height: 1, color: AppConstants.clrSearchBG),
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return OnGoingButtonWidget(
                        context,
                        index == 0
                            ? AppConstants.str_upcoming_for_you
                            : AppConstants.str_upcoming + " " + "🌎", () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                        margin: EdgeInsets.only(right: 16),
                        index: index,
                        selectedIndex: _selectedIndex);
                  }),
            ),
            ListView.builder(
                padding: EdgeInsets.only(bottom: 16),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: postListModel.length,
                itemBuilder: (context, index) {
                  final itemsList = List<String>.generate(postListModel.length, (n) => "List item ${n}");
                  return Dismissible(
                      key: Key(itemsList[index]),
                      background: slideRightBackground(),
                      direction: DismissDirection.startToEnd,
                     // secondaryBackground: slideLeftBackground(),
                      child: cardWidgets(context,postListModel[index],true));
                })
          ],
        )),
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: AppConstants.clrTransparent,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Image.asset(AppConstants.ic_hide,height: 18,width: 18),
            SizedBox(
              width: 15,
            ),
            TextWidget(AppConstants.str_hide_room,
                color: AppConstants.clrBlack,
                fontSize: AppConstants.size_medium_large,
                fontWeight: FontWeight.w600, textAlign: TextAlign.left),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}

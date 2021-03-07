import 'package:audioroom/custom_widget/card_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/custom_widget/ongoing_button_widget.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/model/home_page_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  int _selectedIndex = 0;
  // ignore: deprecated_member_use
  List<HomeModel> homeModel = List<HomeModel>();
  // ignore: deprecated_member_use
  List<PostListModel> postListModel = List<PostListModel>();

  void initState() {
    super.initState();
    homeModel.add(new HomeModel(
        'TheFutur', '3:30 PM', 'Take The Guess Work Out Of Bidding - How...'));
    homeModel.add(new HomeModel(
        'TheFutur', '3:30 PM', 'Take The Guess Work Out Of Bidding - How...'));
    homeModel.add(new HomeModel(
        'TheFutur', '3:30 PM', 'Take The Guess Work Out Of Bidding - How...'));

    // ignore: deprecated_member_use
    List<UserListModel> userListModel1 = List<UserListModel>();
    userListModel1.add(UserListModel(AppConstants.ic_user_profile, "Melinda Livsey"));
    userListModel1.add(UserListModel(AppConstants.ic_user_profile2, "Ben Bhai"));
    userListModel1.add(UserListModel(AppConstants.ic_user_profile, "Melinda Livsey"));
    userListModel1.add(UserListModel(AppConstants.ic_user_profile2, "Ben Bhai"));
    userListModel1.add(UserListModel(AppConstants.ic_user_profile, "Melinda Livsey"));

    postListModel.add(new PostListModel("TheFutur","Take The Guess Work Out Of Bidding - How To Bid",userListModel1,"5","132"));
    postListModel.add(new PostListModel("TheFutur","Take The Guess Work Out Of Bidding - How To Bid",userListModel1,"5","132"));


  }

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
                          context,index==0? AppConstants.str_ongoing:AppConstants.str_ongoing + " " + "🌎", () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                          margin: EdgeInsets.only(right: 16),
                          index: index,
                          selectedIndex: _selectedIndex);
                    }),
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16,top: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppConstants.clrGrey,
                    borderRadius: BorderRadius.circular(8)),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: homeModel.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Image.asset(
                                  AppConstants.ic_dark_home,
                                  height: 18,
                                  width: 18,
                                  color: AppConstants.clrBlack,
                                ),
                              ),
                              TextWidget(homeModel[index].title,
                                  color: AppConstants.clrBlack,
                                  fontSize: AppConstants.size_small_medium,
                                  fontWeight: FontWeight.w600),
                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 8),
                                child: Image.asset(
                                  AppConstants.ic_clock,
                                  height: 18,
                                  width: 18,
                                  color: AppConstants.clrBlack,
                                ),
                              ),
                              TextWidget(homeModel[index].time,
                                  color: AppConstants.clrBlack,
                                  fontSize: AppConstants.size_small_medium,
                                  fontWeight: FontWeight.w600),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: TextWidget(homeModel[index].detail,
                                color: AppConstants.clrBlack,
                                fontSize: AppConstants.size_medium,
                                fontWeight: FontWeight.w600,
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis),
                          ),
                          (index != homeModel.length - 1)
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: DividerWidget(
                                      height: 1,
                                      color: AppConstants.clrBlack
                                          .withOpacity(0.2)),
                                )
                              : Container(),
                        ],
                      );
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
                        child: cardWidgets(context,postListModel[index],false));
                  })
            ],
          ),
        ),
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
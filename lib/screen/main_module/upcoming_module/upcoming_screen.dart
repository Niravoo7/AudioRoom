import 'package:audioroom/custom_widget/room_card_widget.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/ongoing_button_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/model/room_card_model.dart';
import 'package:flutter/material.dart';

class UpcomingScreen extends StatefulWidget {
  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  int _selectedIndex = 0;

  // ignore: deprecated_member_use
  List<RoomCardModel> roomCardModels = List<RoomCardModel>();

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    List<RoomCardPeopleModel> roomCardPeopleModels = [];
    roomCardPeopleModels.add(
        RoomCardPeopleModel(AppConstants.ic_user_profile, "Melinda Livsey"));
    roomCardPeopleModels
        .add(RoomCardPeopleModel(AppConstants.ic_user_profile2, "Ben Bhai"));
    roomCardPeopleModels.add(
        RoomCardPeopleModel(AppConstants.ic_user_profile, "Melinda Livsey"));
    roomCardPeopleModels
        .add(RoomCardPeopleModel(AppConstants.ic_user_profile2, "Ben Bhai"));
    roomCardPeopleModels.add(
        RoomCardPeopleModel(AppConstants.ic_user_profile, "Melinda Livsey"));

    roomCardModels.add(new RoomCardModel(
        "TheFutur",
        "Take The Guess Work Out Of Bidding - How To Bid",
        roomCardPeopleModels,
        "5",
        "132"));
    roomCardModels.add(new RoomCardModel(
        "TheFutur",
        "Take The Guess Work Out Of Bidding - How To Bid",
        roomCardPeopleModels,
        "5",
        "132"));
    roomCardModels.add(new RoomCardModel(
        "TheFutur",
        "Take The Guess Work Out Of Bidding - How To Bid",
        roomCardPeopleModels,
        "5",
        "132"));
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
                    }, index: index, selectedIndex: _selectedIndex);
                  }),
            ),
            ListView.builder(
                padding: EdgeInsets.only(bottom: 16),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: roomCardModels.length,
                itemBuilder: (context, index) {
                  final itemsList = List<String>.generate(
                      roomCardModels.length, (n) => "List item $n");
                  return Dismissible(
                      key: Key(itemsList[index]),
                      background: slideRightBackground(),
                      direction: DismissDirection.startToEnd,
                      // secondaryBackground: slideLeftBackground(),
                      child:
                          RoomCardWidget(context, roomCardModels[index], true));
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
            Image.asset(AppConstants.ic_hide, height: 18, width: 18),
            SizedBox(
              width: 15,
            ),
            TextWidget(AppConstants.str_hide_room,
                color: AppConstants.clrBlack,
                fontSize: AppConstants.size_medium_large,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.left),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}

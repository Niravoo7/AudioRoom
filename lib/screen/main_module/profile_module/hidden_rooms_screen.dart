import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/room_card_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/model/room_card_model.dart';
import 'package:flutter/material.dart';

class HiddenRoomsScreen extends StatefulWidget {
  @override
  _HiddenRoomsScreenState createState() => _HiddenRoomsScreenState();
}

class _HiddenRoomsScreenState extends State<HiddenRoomsScreen> {
  List<RoomCardModel> roomCardModels = [];

  @override
  void initState() {
    super.initState();
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
      appBar: CommonAppBar(context, "Hidden Rooms", true, false, null),
      body: SafeArea(
        child: ListView.builder(
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
                  child: RoomCardWidget(context, roomCardModels[index], true));
            }),
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
            TextWidget(AppConstants.str_show_room,
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

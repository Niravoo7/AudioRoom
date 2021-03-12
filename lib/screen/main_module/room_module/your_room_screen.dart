import 'package:audioroom/custom_widget/room_appbar.dart';
import 'package:audioroom/custom_widget/your_room_card_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/custom_widget/flexible_widget.dart';
import 'package:audioroom/custom_widget/switch_widget.dart';
import 'package:audioroom/custom_widget/follow_people_widget.dart';
import 'package:audioroom/custom_widget/choose_people_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/print_log.dart';
import 'package:audioroom/model/your_room_card_model.dart';
import 'package:audioroom/model/follow_people_model.dart';
import 'package:audioroom/model/choose_people_model.dart';
import 'package:flutter/material.dart';

class YourRoomScreen extends StatefulWidget {
  YourRoomScreen();

  @override
  _YourRoomScreenState createState() => _YourRoomScreenState();
}

class _YourRoomScreenState extends State<YourRoomScreen> {
  List<YourRoomCardModel> yourRoomCardModels = List<YourRoomCardModel>();
  List<YourRoomCardPeopleModel> yourRoomCardPeopleModels;
  List<String> icons = new List<String>();

  bool isRaisedHand = true;
  bool icListBottomSheetVisible = false;
  bool icAddUserBottomSheetVisible = false;
  bool icSpeakerBottomSheetVisible = false;

  @override
  void initState() {
    super.initState();

    yourRoomCardPeopleModels = List<YourRoomCardPeopleModel>();
    yourRoomCardPeopleModels.add(YourRoomCardPeopleModel(
        AppConstants.ic_user_profile, "Melinda Livsey", true, false));
    yourRoomCardPeopleModels.add(YourRoomCardPeopleModel(
        AppConstants.ic_user_profile2, "Ben Bhai", true, true));
    yourRoomCardPeopleModels.add(YourRoomCardPeopleModel(
        AppConstants.ic_user_profile, "Melinda Livsey", false, true));
    yourRoomCardPeopleModels.add(YourRoomCardPeopleModel(
        AppConstants.ic_user_profile2, "Ben Bhai", false, true));
    yourRoomCardPeopleModels.add(YourRoomCardPeopleModel(
        AppConstants.ic_user_profile, "Melinda Livsey", false, true));

    yourRoomCardModels.add(new YourRoomCardModel(
        "TheFutur",
        "Take The Guess Work Out Of Bidding - How To Bid",
        yourRoomCardPeopleModels,
        "5",
        "132"));

    yourRoomCardPeopleModels = List<YourRoomCardPeopleModel>();
    yourRoomCardPeopleModels.add(YourRoomCardPeopleModel(
        AppConstants.ic_user_profile, "Melinda Livsey", true, true));
    yourRoomCardPeopleModels.add(YourRoomCardPeopleModel(
        AppConstants.ic_user_profile2, "Ben Bhai", false, false));
    yourRoomCardPeopleModels.add(YourRoomCardPeopleModel(
        AppConstants.ic_user_profile, "Melinda Livsey", false, false));
    yourRoomCardPeopleModels.add(YourRoomCardPeopleModel(
        AppConstants.ic_user_profile2, "Ben Bhai", false, false));
    yourRoomCardPeopleModels.add(YourRoomCardPeopleModel(
        AppConstants.ic_user_profile, "Melinda Livsey", false, false));
    yourRoomCardPeopleModels.add(YourRoomCardPeopleModel(
        AppConstants.ic_user_profile2, "Ben Bhai", false, false));
    yourRoomCardPeopleModels.add(YourRoomCardPeopleModel(
        AppConstants.ic_user_profile, "Melinda Livsey", false, false));
    yourRoomCardPeopleModels.add(YourRoomCardPeopleModel(
        AppConstants.ic_user_profile2, "Ben Bhai", false, false));
    yourRoomCardPeopleModels.add(YourRoomCardPeopleModel(
        AppConstants.ic_user_profile, "Melinda Livsey", false, false));
    yourRoomCardPeopleModels.add(YourRoomCardPeopleModel(
        AppConstants.ic_user_profile2, "Ben Bhai", false, false));
    yourRoomCardPeopleModels.add(YourRoomCardPeopleModel(
        AppConstants.ic_user_profile, "Melinda Livsey", false, false));
    yourRoomCardPeopleModels.add(YourRoomCardPeopleModel(
        AppConstants.ic_user_profile2, "Ben Bhai", false, false));
    yourRoomCardModels.add(
        new YourRoomCardModel("", "", yourRoomCardPeopleModels, "5", "132"));

    icons.add(AppConstants.ic_list);
    icons.add(AppConstants.ic_add_user);
    icons.add(AppConstants.ic_speaker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RoomAppBar(context, AppConstants.str_all_rooms, null),
        body: SafeArea(
            child: Container(
                color: AppConstants.clrTitleBG,
                width: MediaQuery.of(context).size.width,
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  ListView.builder(
                      padding: EdgeInsets.only(bottom: 80),
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: yourRoomCardModels.length,
                      itemBuilder: (context, index) {
                        return YourRoomCardWidget(
                            context, yourRoomCardModels[index], index != 0);
                      }),
                  (icListBottomSheetVisible)
                      ? icListBottomSheet()
                      : Container(),
                  (icAddUserBottomSheetVisible)
                      ? icAddUserBottomSheet()
                      : Container(),
                  (icSpeakerBottomSheetVisible)
                      ? icSpeakerBottomSheet()
                      : Container(),
                  Container(
                      height: 68,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppConstants.clrWhite,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          border: Border.all(
                              color: AppConstants.clrSearchBG, width: 1)),
                      child: Row(children: [
                        Container(
                            height: 36,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppConstants.clrPrimary, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(children: [
                              Container(
                                  margin: EdgeInsets.only(right: 8, left: 28),
                                  child: Image.asset(
                                    AppConstants.ic_leave_group,
                                    height: 17,
                                    color: AppConstants.clrPrimary,
                                  )),
                              TextWidget(AppConstants.str_leave_quietly,
                                  color: AppConstants.clrPrimary,
                                  fontSize: AppConstants.size_small_medium,
                                  fontWeight: FontWeight.normal),
                              SizedBox(width: 28)
                            ])),
                        FlexibleWidget(1),
                        Container(
                            height: 36,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: icons.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 8, bottom: 8, left: 20),
                                      child:
                                          Image.asset(icons[index], height: 20),
                                    ),
                                    onTap: () {
                                      switch (icons[index]) {
                                        case AppConstants.ic_list:
                                          PrintLog.printMessage("ic_list");
                                          icListBottomSheetVisible =
                                              !icListBottomSheetVisible;
                                          icAddUserBottomSheetVisible = false;
                                          icSpeakerBottomSheetVisible = false;
                                          setState(() {});
                                          /*showBarModalBottomSheet(
                                                expand: true,
                                                context: context,
                                                backgroundColor: Colors.transparent,
                                                builder: (context) =>
                                                    icListBottomSheet(),
                                              );*/
                                          break;
                                        case AppConstants.ic_add_user:
                                          PrintLog.printMessage("ic_add_user");
                                          icListBottomSheetVisible = false;
                                          icAddUserBottomSheetVisible =
                                              !icAddUserBottomSheetVisible;
                                          icSpeakerBottomSheetVisible = false;
                                          setState(() {});
                                          break;
                                        case AppConstants.ic_speaker:
                                          PrintLog.printMessage("ic_speaker");
                                          icListBottomSheetVisible = false;
                                          icAddUserBottomSheetVisible = false;
                                          icSpeakerBottomSheetVisible =
                                              !icSpeakerBottomSheetVisible;
                                          setState(() {});
                                          break;
                                      }
                                    },
                                  );
                                }))
                      ])),
                ]))));
  }

  Widget icListBottomSheet() {
    List<FollowPeopleModel> followPeopleModels = new List<FollowPeopleModel>();

    followPeopleModels.add(new FollowPeopleModel(
        "Saikik", "@saikik.jp", AppConstants.str_image_url, true));
    followPeopleModels.add(new FollowPeopleModel(
        "Mr Beast", "@mrbest6000", AppConstants.str_image_url, true));

    return Container(
      padding: EdgeInsets.only(bottom: 66),
      decoration: BoxDecoration(
          color: AppConstants.clrWhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          border: Border.all(color: AppConstants.clrSearchBG, width: 1)),
      child: Wrap(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                TextWidget(AppConstants.str_people_who_raised_hand,
                    color: AppConstants.clrBlack,
                    fontSize: AppConstants.size_medium_large,
                    fontWeight: FontWeight.bold),
                FlexibleWidget(1),
                SwitchWidget(isRaisedHand, () {
                  isRaisedHand = !isRaisedHand;
                  setState(() {});
                })
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              itemCount: followPeopleModels.length,
              itemBuilder: (BuildContext context, int index) {
                return FollowPeopleWidget(
                    context,
                    followPeopleModels[index].profilePic,
                    followPeopleModels[index].name,
                    followPeopleModels[index].tagName,
                    AppConstants.str_make_speaker,
                    followPeopleModels[index].isFollow,
                    () {});
              })
        ],
      ),
    );
  }

  Widget icAddUserBottomSheet() {
    List<ChoosePeopleModel> choosePeopleModels = new List<ChoosePeopleModel>();

    choosePeopleModels.add(new ChoosePeopleModel(
        "Saikik", "@saikik.jp", AppConstants.str_image_url, true, false));
    choosePeopleModels.add(new ChoosePeopleModel(
        "Mr Beast", "@mrbest6000", AppConstants.str_image_url, true, false));
    choosePeopleModels.add(new ChoosePeopleModel(
        "GraphyBoy", "@graphyboy", AppConstants.str_image_url, true, false));
    choosePeopleModels.add(new ChoosePeopleModel(
        "Amy Doe", "@amygirl", AppConstants.str_image_url, false, false));

    return Container(
      padding: EdgeInsets.only(bottom: 66),
      decoration: BoxDecoration(
          color: AppConstants.clrWhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          border: Border.all(color: AppConstants.clrSearchBG, width: 1)),
      child: Wrap(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: TextWidget(AppConstants.str_invite_people,
                color: AppConstants.clrBlack,
                fontSize: AppConstants.size_medium_large,
                fontWeight: FontWeight.bold),
          ),
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              itemCount: choosePeopleModels.length,
              itemBuilder: (BuildContext context, int index) {
                return ChoosePeopleWidget(
                    context,
                    choosePeopleModels[index].profilePic,
                    choosePeopleModels[index].name,
                    choosePeopleModels[index].tagName,
                    choosePeopleModels[index].isSelected
                        ? AppConstants.str_following
                        : AppConstants.str_follow,
                    choosePeopleModels[index].isSelected,
                    choosePeopleModels[index].isOnline, () {
                  choosePeopleModels[index].isSelected =
                      !choosePeopleModels[index].isSelected;
                  setState(() {});
                });
              })
        ],
      ),
    );
  }

  Widget icSpeakerBottomSheet() {
    return Container(
      padding: EdgeInsets.only(bottom: 70, top: 16, left: 16, right: 16),
      decoration: BoxDecoration(
          color: AppConstants.clrWhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          border: Border.all(color: AppConstants.clrSearchBG, width: 1)),
      child: Wrap(children: [
        Row(children: [
          Container(
              height: 66,
              width: 66,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: AppConstants.clrProfileBG,
                  image: DecorationImage(
                      image: NetworkImage(AppConstants.str_image_url),
                      fit: BoxFit.fill),
                  shape: BoxShape.circle)),
          Flexible(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                TextWidget("Sera Scholfield",
                    color: AppConstants.clrBlack,
                    fontSize: AppConstants.size_medium_large,
                    fontWeight: FontWeight.bold),
                TextWidget("@serafield",
                    color: AppConstants.clrBlack,
                    fontSize: AppConstants.size_small_medium,
                    fontWeight: FontWeight.w400),
              ]))
        ]),
        Container(
          margin: EdgeInsets.only(top: 16, bottom: 16),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            GestureDetector(
                onTap: () {},
                child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      TextWidget("501",
                          color: AppConstants.clrBlack,
                          fontSize: AppConstants.size_medium,
                          fontWeight: FontWeight.bold),
                      TextWidget(
                        AppConstants.str_followers,
                        color: AppConstants.clrBlack,
                        fontSize: AppConstants.size_medium,
                        fontWeight: FontWeight.w400,
                      )
                    ]))),
            SizedBox(width: 16),
            GestureDetector(
                onTap: () {},
                child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      TextWidget("38",
                          color: AppConstants.clrBlack,
                          fontSize: AppConstants.size_medium,
                          fontWeight: FontWeight.bold),
                      TextWidget(
                        AppConstants.str_following,
                        color: AppConstants.clrBlack,
                        fontSize: AppConstants.size_medium,
                        fontWeight: FontWeight.w400,
                      )
                    ]))),
            SizedBox(width: 16),
            GestureDetector(
                onTap: () {},
                child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      TextWidget("12",
                          color: AppConstants.clrBlack,
                          fontSize: AppConstants.size_medium,
                          fontWeight: FontWeight.bold),
                      TextWidget(
                        AppConstants.str_clubs_joined,
                        color: AppConstants.clrBlack,
                        fontSize: AppConstants.size_medium,
                        fontWeight: FontWeight.w400,
                      )
                    ])))
          ]),
        ),
        Container(
          height: 44,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppConstants.clrPrimary,
              borderRadius: BorderRadius.circular(10)),
          child: TextWidget(AppConstants.str_make_a_speaker,
              color: AppConstants.clrWhite,
              fontSize: AppConstants.size_medium_large,
              fontWeight: FontWeight.bold),
        ),
        Container(
          height: 44,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppConstants.clrWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppConstants.clrPrimary, width: 1)),
          child: TextWidget(AppConstants.str_move_to_audience,
              color: AppConstants.clrPrimary,
              fontSize: AppConstants.size_medium_large,
              fontWeight: FontWeight.bold),
        ),
        Container(
          height: 44,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppConstants.clrWhite,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppConstants.clrPrimary, width: 1)),
          child: TextWidget(AppConstants.str_view_full_profile,
              color: AppConstants.clrPrimary,
              fontSize: AppConstants.size_medium_large,
              fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}

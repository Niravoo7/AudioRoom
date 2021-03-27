import 'package:audioroom/custom_widget/button_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/common_user_detail_widget.dart';
import 'package:audioroom/custom_widget/text_field_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/firestore/model/club_model.dart';
import 'package:audioroom/firestore/model/upcoming_room_model.dart';
import 'package:audioroom/firestore/network/club_fire.dart';
import 'package:audioroom/firestore/network/upcoming_room_fire.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/print_log.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewEventScreen extends StatefulWidget {
  @override
  _NewEventScreenState createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController eventNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<ClubModel> clubModels = [];

  List<String> uIdList = [];

  @override
  void initState() {
    super.initState();
    //eventNameController.text = "test";
    //dateController.text = "test";
    //timeController.text = "test";
    //descriptionController.text = "about info";

    ClubService().getClubByUserId().then((value) {
      if (value != null) {
        clubModels = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
            appBar: CommonAppBar(context, "New Event", true, false, null),
            body: SafeArea(
                child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: ListView(children: <Widget>[
                      inputFields(),
                      ButtonWidget(context, AppConstants.str_publish, () {
                        UpcomingRoomModel upcomingRoomModel =
                            new UpcomingRoomModel(
                                clubName: eventNameController.text,
                                createDatetime: DateTime.now(),
                                createrUid:
                                    FirebaseAuth.instance.currentUser.uid,
                                isRoomLock: false,
                                channelName: eventNameController.text
                                    .toLowerCase()
                                    .replaceAll(" ", "_"),
                                roomDesc: descriptionController.text,
                                roomType: "Social",
                                people: uIdList,
                                roomName: eventNameController.text,
                                raiseHand: [],
                                moderator: [],
                                broadcaster: [
                                  FirebaseAuth.instance.currentUser.uid
                                ],
                                mutePeople: [],
                                audiance: [],
                                hidePeople: [],
                                channelToken: "");

                        PrintLog.printMessage(
                            "roomModel 1 -> ${upcomingRoomModel.toJson()}");

                        UpcomingRoomService()
                            .createUpcomingRoom(upcomingRoomModel)
                            .then((value) {
                          Navigator.pop(context);
                        });
                      })
                    ])))));
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateController.text = selectedDate.day.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.year.toString();
      });
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
        timeController.text =
            selectedTime.hour.toString() + ":" + selectedTime.minute.toString();
      });
  }

  Widget inputFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget(AppConstants.str_event_name,
            color: AppConstants.clrBlack,
            fontSize: AppConstants.size_medium_large,
            fontWeight: FontWeight.bold),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: AppConstants.clrWhite,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            TextWidget(AppConstants.str_select_club,
                                color: AppConstants.clrBlack,
                                fontSize: AppConstants.size_medium_large,
                                fontWeight: FontWeight.bold),
                            ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(0),
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: clubModels.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: 72,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: AppConstants.clrTransparent,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin:
                                        EdgeInsets.only(left: 16, right: 16),
                                    child: Column(
                                      children: [
                                        CommonUserDetailWidget(
                                            context,
                                            clubModels[index].imageUrl,
                                            clubModels[index].clubName,
                                            clubModels[index]
                                                    .onlineMemberCount
                                                    .toString() +
                                                " ${AppConstants.str_member_online}",
                                            isSelected: false, onClick: () {
                                          uIdList = [];
                                          for (int i = 0;
                                              i <
                                                  clubModels[index]
                                                      .userList
                                                      .length;
                                              i++) {
                                            uIdList.add(clubModels[index]
                                                .userList[i]
                                                .toString());
                                          }
                                          eventNameController.text =
                                              clubModels[index].clubName;
                                          Navigator.pop(ctx);
                                          setState(() {});
                                        }),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ],
                  );
                });
          },
          child: Container(
            color: AppConstants.clrTransparent,
            child: TextFieldWidget(
                controller: eventNameController,
                keyboardType: TextInputType.text,
                hintText: AppConstants.str_write_a_title_for_the_event,
                enabled: false),
          ),
        ),
        SizedBox(height: 16),
        TextWidget(AppConstants.str_with,
            color: AppConstants.clrBlack,
            fontSize: AppConstants.size_medium_large,
            fontWeight: FontWeight.bold),
        SizedBox(height: 8),
        Row(
          children: [
            Container(
                height: 22,
                width: 22,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                    color: AppConstants.clrGreen,
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(AppConstants.str_image_url)))),
            TextWidget(AppConstants.str_melinda_livsey,
                color: AppConstants.clrBlack,
                fontSize: AppConstants.size_medium_large,
                fontWeight: FontWeight.w400),
          ],
        ),
        Container(
          height: 50,
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.only(left: 8, right: 8),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(color: AppConstants.clrGrey),
              borderRadius: BorderRadius.circular(5)),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Flexible(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextWidget(AppConstants.str_add_a_co_host_or_guest,
                      color: AppConstants.clrBlack,
                      fontSize: AppConstants.size_medium_large,
                      fontWeight: FontWeight.w400),
                ),
                flex: 1,
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
        SizedBox(height: 16),
        TextWidget(
          AppConstants.str_date,
          color: AppConstants.clrBlack,
          fontSize: AppConstants.size_medium_large,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            selectDate(context);
          },
          child: Container(
            color: AppConstants.clrTransparent,
            child: TextFieldWidget(
                controller: dateController,
                keyboardType: TextInputType.text,
                enabled: false),
          ),
        ),
        SizedBox(height: 16),
        TextWidget(AppConstants.str_time,
            color: AppConstants.clrBlack,
            fontSize: AppConstants.size_medium_large,
            fontWeight: FontWeight.bold),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            selectTime(context);
          },
          child: Container(
            color: AppConstants.clrTransparent,
            child: TextFieldWidget(
                controller: timeController,
                keyboardType: TextInputType.text,
                enabled: false),
          ),
        ),
        SizedBox(height: 16),
        TextWidget(AppConstants.str_description,
            color: AppConstants.clrBlack,
            fontSize: AppConstants.size_medium_large,
            fontWeight: FontWeight.bold),
        SizedBox(height: 8),
        TextFieldWidget(
            controller: descriptionController,
            hintText: AppConstants.str_write_the_event_details,
            keyboardType: TextInputType.text,
            lines: 4),
      ],
    );
  }
}

import 'package:audioroom/custom_widget/room_card_widget.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/ongoing_button_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/firestore/model/room_model.dart';
import 'package:audioroom/firestore/network/upcoming_room_fire.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UpcomingScreen extends StatefulWidget {
  Function onNewEventClick;

  UpcomingScreen(this.onNewEventClick);

  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
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
              height: 52,
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
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
                              selectedIndex = index;
                            });
                          }, index: index, selectedIndex: selectedIndex);
                        }),
                    flex: 1,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 36,
                      width: 36,
                      margin: EdgeInsets.only(top: 16, left: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppConstants.clrPrimary,
                          borderRadius: BorderRadius.circular(5)),
                      child: Image.asset(AppConstants.ic_add_upcoming_event,
                          height: 20, width: 20),
                    ),
                    onTap: () {
                      widget.onNewEventClick();
                    },
                  )
                ],
              ),
            ),
            Container(
              child: StreamBuilder(
                stream: UpcomingRoomService()
                    .getUpcomingRoomQueryTop(selectedIndex)
                    .snapshots(),
                builder: (context, stream) {
                  if (stream.hasError) {
                    return Center(
                        child: TextWidget(stream.error.toString(),
                            color: AppConstants.clrBlack, fontSize: 20));
                  }
                  QuerySnapshot querySnapshot = stream.data;
                  if (querySnapshot == null || querySnapshot.size == 0) {
                    if (querySnapshot == null) {
                      return Container();
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height - 200,
                        child: Center(
                          child: TextWidget(AppConstants.str_no_record_found,
                              color: AppConstants.clrBlack, fontSize: 20),
                        ),
                      );
                    }
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0),
                        itemCount: querySnapshot.size,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          RoomModel roomModelTemp = RoomModel.fromJson(
                              querySnapshot.docs[index].data());
                          if (roomModelTemp != null) {
                            return RoomCardWidget(
                                context, roomModelTemp, false);
                          } else {
                            return Container();
                          }
                        });
                  }
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}

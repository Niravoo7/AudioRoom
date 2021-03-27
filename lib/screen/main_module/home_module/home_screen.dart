import 'package:audioroom/custom_widget/room_card_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/firestore/model/room_model.dart';
import 'package:audioroom/firestore/network/room_fire.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:audioroom/model/your_room_card_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/custom_widget/ongoing_button_widget.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  Function(StartRoomModel) onStartRoomClick;

  HomeScreen(this.onStartRoomClick);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            DividerWidget(height: 1, color: AppConstants.clrSearchBG),
            Container(
              height: 52,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return OnGoingButtonWidget(
                        context,
                        index == 0
                            ? AppConstants.str_ongoing
                            : AppConstants.str_ongoing + " " + "🌎", () {
                      setState(() {
                        selectedIndex = index;
                      });
                    }, index: index, selectedIndex: selectedIndex);
                  }),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: BoxDecoration(
                  color: AppConstants.clrGrey,
                  borderRadius: BorderRadius.circular(8)),
              child: StreamBuilder(
                stream:
                    RoomService().getRoomQueryTop(selectedIndex).snapshots(),
                builder: (context, stream) {
                  if (stream.hasError) {
                    return Center(
                        child: TextWidget(stream.error.toString(),
                            color: AppConstants.clrBlack, fontSize: 20));
                  }
                  QuerySnapshot querySnapshot = stream.data;
                  if (querySnapshot == null || querySnapshot.size == 0) {
                    return Container();
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0),
                        itemCount: querySnapshot.size,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          RoomModel roomModelTemp = RoomModel.fromJson(
                              querySnapshot.docs[index].data());

                          if (roomModelTemp != null &&
                              !roomModelTemp.hidePeople.contains(
                                  FirebaseAuth.instance.currentUser.uid)) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 10),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Image.asset(
                                          AppConstants.ic_dark_home,
                                          height: 18,
                                          width: 18,
                                          color: AppConstants.clrBlack,
                                        ),
                                      ),
                                      TextWidget(roomModelTemp.roomName,
                                          color: AppConstants.clrBlack,
                                          fontSize:
                                              AppConstants.size_small_medium,
                                          fontWeight: FontWeight.w600),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, right: 8),
                                        child: Image.asset(
                                          AppConstants.ic_clock,
                                          height: 18,
                                          width: 18,
                                          color: AppConstants.clrBlack,
                                        ),
                                      ),
                                      TextWidget(
                                          datetimeToString(
                                              roomModelTemp.createDatetime),
                                          color: AppConstants.clrBlack,
                                          fontSize:
                                              AppConstants.size_small_medium,
                                          fontWeight: FontWeight.w600),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, left: 16, right: 16, bottom: 10),
                                  child: TextWidget(roomModelTemp.roomDesc,
                                      color: AppConstants.clrBlack,
                                      fontSize: AppConstants.size_medium,
                                      fontWeight: FontWeight.w600,
                                      maxLines: 1,
                                      textOverflow: TextOverflow.ellipsis),
                                ),
                                (index != querySnapshot.size - 1)
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: DividerWidget(
                                            height: 1,
                                            color: AppConstants.clrBlack
                                                .withOpacity(0.2)),
                                      )
                                    : Container(),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        });
                  }
                },
              ),
            ),
            Container(
              child: StreamBuilder(
                stream:
                    RoomService().getRoomQueryTop(selectedIndex).snapshots(),
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
                        height: MediaQuery.of(context).size.height-200,
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

                          if (roomModelTemp != null &&
                              !roomModelTemp.hidePeople.contains(
                                  FirebaseAuth.instance.currentUser.uid)) {
                            final itemsList = List<String>.generate(
                                querySnapshot.size, (n) => "List item $n");
                            return Dismissible(
                                key: Key(itemsList[index]),
                                background: slideRightBackground(),
                                direction: DismissDirection.startToEnd,
                                onDismissed: (t) {
                                  roomModelTemp.hidePeople.add(
                                      FirebaseAuth.instance.currentUser.uid);
                                  RoomService().updateRoom(roomModelTemp);
                                },
                                // secondaryBackground: slideLeftBackground(),
                                child: GestureDetector(
                                  onTap: () {
                                    widget.onStartRoomClick(new StartRoomModel(
                                        null, null, null, null, roomModelTemp));
                                  },
                                  child: RoomCardWidget(
                                      context, roomModelTemp, false),
                                ));
                          } else {
                            return Container();
                          }
                        });
                  }
                },
              ),
            ),
          ],
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

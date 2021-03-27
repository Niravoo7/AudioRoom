import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/room_card_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/firestore/model/room_model.dart';
import 'package:audioroom/firestore/network/room_fire.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HiddenRoomsScreen extends StatefulWidget {
  @override
  _HiddenRoomsScreenState createState() => _HiddenRoomsScreenState();
}

class _HiddenRoomsScreenState extends State<HiddenRoomsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(context, "Hidden Rooms", true, false, null),
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
            stream: RoomService().getRoomQueryHide().snapshots(),
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
                  return Center(
                    child: TextWidget(
                        AppConstants.str_no_record_found,
                        color: AppConstants.clrBlack,
                        fontSize: 20),
                  );
                }
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0),
                    itemCount: querySnapshot.size,
                    itemBuilder: (BuildContext context, int index) {
                      RoomModel roomModelTemp =
                          RoomModel.fromJson(querySnapshot.docs[index].data());

                      if (roomModelTemp != null) {
                        final itemsList = List<String>.generate(
                            querySnapshot.size, (n) => "List item $n");
                        return Dismissible(
                            key: Key(itemsList[index]),
                            background: slideRightBackground(),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (t) {
                              roomModelTemp.hidePeople.remove(
                                  FirebaseAuth.instance.currentUser.uid);
                              RoomService().updateRoom(roomModelTemp);
                            },
                            // secondaryBackground: slideLeftBackground(),
                            child:
                                RoomCardWidget(context, roomModelTemp, false));
                      } else {
                        return Container();
                      }
                    });
              }
            },
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

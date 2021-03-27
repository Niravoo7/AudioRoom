import 'package:audioroom/custom_widget/common_user_detail_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/search_input_field.dart';
import 'package:audioroom/custom_widget/button_widget.dart';
import 'package:audioroom/firestore/model/club_model.dart';
import 'package:audioroom/firestore/network/club_fire.dart';
import 'package:audioroom/firestore/network/room_fire.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:audioroom/model/room_type_model.dart';
import 'package:audioroom/model/your_room_card_model.dart';
import 'package:audioroom/screen/main_module/room_module/choose_people_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/helper/navigate_effect.dart';

// ignore: must_be_immutable
class StartRoomScreen extends StatefulWidget {
  Function(StartRoomModel) onStartRoomClick;

  StartRoomScreen(this.onStartRoomClick);

  @override
  _StartRoomScreenState createState() => _StartRoomScreenState();
}

class _StartRoomScreenState extends State<StartRoomScreen> {
  TextEditingController titleController = new TextEditingController();
  List<RoomTypeModel> roomTypeModels = [];
  int selectedRoomType = 0;
  String selectedClub;
  List<String> uIdList = [];

  @override
  void initState() {
    super.initState();
    roomTypeModels.add(new RoomTypeModel(
        AppConstants.str_global, AppConstants.ic_global, false));
    roomTypeModels.add(new RoomTypeModel(
        AppConstants.str_social, AppConstants.ic_social, false));
    roomTypeModels.add(new RoomTypeModel(
        AppConstants.str_closed, AppConstants.ic_closed, false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
            context, AppConstants.str_tab_room, false, false, null),
        body: SafeArea(
            child: Container(
                color: AppConstants.clrTitleBG,
                width: MediaQuery.of(context).size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                          child: ListView(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 16, top: 16, right: 16, bottom: 8),
                            child: TextWidget(AppConstants.str_title,
                                color: AppConstants.clrBlack,
                                fontSize: AppConstants.size_medium_large,
                                fontWeight: FontWeight.bold),
                          ),
                          SearchInputField(
                              AppConstants
                                  .str_write_a_title_for_the_conversation,
                              titleController,
                              false,
                              (text) {}),
                          Container(
                            margin: EdgeInsets.only(
                                left: 16, top: 8, right: 16, bottom: 8),
                            child: TextWidget(
                                AppConstants.str_select_the_audience,
                                color: AppConstants.clrBlack,
                                fontSize: AppConstants.size_medium_large,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height: 103,
                            child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(right: 16, left: 16),
                                itemCount: roomTypeModels.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 16),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 74,
                                            width: 74,
                                            padding: EdgeInsets.all(19),
                                            margin: EdgeInsets.only(bottom: 8),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: (selectedRoomType ==
                                                        index)
                                                    ? AppConstants.clrPrimary
                                                    : AppConstants.clrWhite,
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                        AppConstants.clrGrey)),
                                            child: Image.asset(
                                              roomTypeModels[index].pic,
                                              height: 36,
                                              width: 36,
                                              color: (selectedRoomType == index)
                                                  ? AppConstants.clrWhite
                                                  : AppConstants.clrBlack,
                                            ),
                                          ),
                                          TextWidget(roomTypeModels[index].name,
                                              color: AppConstants.clrBlack,
                                              fontSize:
                                                  AppConstants.size_medium,
                                              fontWeight: FontWeight.bold)
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      selectedRoomType = index;
                                      setState(() {});
                                    },
                                  );
                                }),
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 16, top: 8, right: 16, bottom: 8),
                              child: TextWidget(AppConstants.str_select_club,
                                  color: AppConstants.clrBlack,
                                  fontSize: AppConstants.size_medium_large,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              /*ClubService()
                              .getClubByReferences("entertainment")
                              .then((value) {
                            if (value != null) {
                              PrintLog.printMessage(
                                  "getClub -> " + value.toJson().toString());
                            }
                          });*/
                              /*ClubService().getClubByUserId();*/
                              /*ClubModel clubModel = new ClubModel(
                              imageUrl: AppConstants.str_image_url,
                              clubName: "Entertainment",
                              memberCount: 50,
                              onlineMemberCount: 25,
                              userList: [
                                "CwTXnB8YYGesBM6eXz7rM70pchh2",
                                "Rjs4r7EZscWCItJMA0ohCfXwIpg2",
                                "LiDT5PRmRkPX52rp6ZPH4C8zbDc2"
                              ]);
                          ClubService().createClub(clubModel);*/
                            },
                          ),
                          Container(
                            color: AppConstants.clrWhite,
                            child: StreamBuilder(
                              stream:
                                  ClubService().getClubByUIDQuery().snapshots(),
                              builder: (context, stream) {
                                if (stream.hasError) {
                                  return Center(
                                      child: TextWidget(stream.error.toString(),
                                          color: AppConstants.clrBlack,
                                          fontSize: 20));
                                }
                                QuerySnapshot querySnapshot = stream.data;
                                if (querySnapshot == null ||
                                    querySnapshot.size == 0) {
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
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: querySnapshot.size,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        ClubModel clubModelTemp =
                                            ClubModel.fromJson(querySnapshot
                                                .docs[index]
                                                .data());

                                        return Container(
                                          height: 72,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: (selectedClub ==
                                                      clubModelTemp.clubName)
                                                  ? AppConstants.clrPrimary
                                                  : AppConstants.clrTransparent,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          margin: EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: Column(
                                            children: [
                                              CommonUserDetailWidget(
                                                  context,
                                                  clubModelTemp.imageUrl,
                                                  clubModelTemp.clubName,
                                                  clubModelTemp
                                                          .onlineMemberCount
                                                          .toString() +
                                                      " ${AppConstants.str_member_online}",
                                                  isSelected: (selectedClub ==
                                                      clubModelTemp.clubName),
                                                  onClick: () {
                                                uIdList = [];
                                                for (int i = 0;
                                                    i <
                                                        clubModelTemp
                                                            .userList.length;
                                                    i++) {
                                                  uIdList.add(clubModelTemp
                                                      .userList[i]
                                                      .toString());
                                                }
                                                selectedClub =
                                                    clubModelTemp.clubName;
                                                setState(() {});
                                              }),
                                            ],
                                          ),
                                        );
                                      });
                                }
                              },
                            ),
                          ),
                        ],
                      )),
                      Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          child: ButtonWidget(
                              context,
                              (selectedRoomType == 2)
                                  ? AppConstants.str_choose_people
                                  : AppConstants.str_start_a_room_small, () {
                            if (uIdList != null && uIdList.length > 0) {
                              if (titleController.text != null &&
                                  titleController.text != "") {
                                if (selectedRoomType == 2) {
                                  Navigator.push(
                                          context,
                                          NavigatePageRoute(
                                              context, ChoosePeopleScreen()))
                                      .then((value) {
                                    if (value != null) {
                                      RoomService()
                                          .getRoomByReferences(selectedClub
                                              .toLowerCase()
                                              .replaceAll(" ", "_"))
                                          .then((value1) {
                                        if (value1 == null) {
                                          widget.onStartRoomClick(
                                              new StartRoomModel(
                                                  value,
                                                  selectedClub,
                                                  titleController.text,
                                                  roomTypeModels[
                                                          selectedRoomType]
                                                      .name,
                                                  null));
                                        } else {
                                          showToast("Room already exist");
                                        }
                                      });
                                    }
                                  });
                                } else {
                                  RoomService()
                                      .getRoomByReferences(selectedClub
                                          .toLowerCase()
                                          .replaceAll(" ", "_"))
                                      .then((value1) {
                                    if (value1 == null) {
                                      widget.onStartRoomClick(
                                          new StartRoomModel(
                                              uIdList,
                                              selectedClub,
                                              titleController.text,
                                              roomTypeModels[selectedRoomType]
                                                  .name,
                                              null));
                                    } else {
                                      showToast("Room already exist");
                                    }
                                  });
                                }
                              } else {
                                showToast(AppConstants.str_title_required);
                              }
                            } else {
                              showToast(
                                  AppConstants.str_please_select_club_first);
                            }
                          }))
                    ]))));
  }
}

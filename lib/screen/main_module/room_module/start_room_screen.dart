import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/search_input_field.dart';
import 'package:audioroom/custom_widget/flexible_widget.dart';
import 'package:audioroom/custom_widget/button_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/model/room_type_model.dart';
import 'package:audioroom/screen/main_module/room_module/choose_people_screen.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/helper/navigate_effect.dart';

// ignore: must_be_immutable
class StartRoomScreen extends StatefulWidget {
  Function onStartRoomClick;

  StartRoomScreen(this.onStartRoomClick);

  @override
  _StartRoomScreenState createState() => _StartRoomScreenState();
}

class _StartRoomScreenState extends State<StartRoomScreen> {
  TextEditingController searchController = new TextEditingController();
  List<RoomTypeModel> roomTypeModels = new List<RoomTypeModel>();
  int selectedRoomType = 0;

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
                          AppConstants.str_write_a_title_for_the_conversation,
                          searchController,
                          false,
                          (text) {}),
                      Container(
                        margin: EdgeInsets.only(
                            left: 16, top: 8, right: 16, bottom: 8),
                        child: TextWidget(AppConstants.str_select_the_audience,
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
                                            color: (selectedRoomType == index)
                                                ? AppConstants.clrPrimary
                                                : AppConstants.clrWhite,
                                            border: Border.all(
                                                width: 1,
                                                color: AppConstants.clrGrey)),
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
                                          fontSize: AppConstants.size_medium,
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
                      FlexibleWidget(1),
                      Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          child: ButtonWidget(
                              context,
                              (selectedRoomType == 2)
                                  ? AppConstants.str_choose_people
                                  : AppConstants.str_start_a_room_small, () {
                            if (selectedRoomType == 2) {
                              Navigator.push(
                                  context,
                                  NavigatePageRoute(
                                      context,
                                      ChoosePeopleScreen(
                                          widget.onStartRoomClick)));
                            } else {
                              widget.onStartRoomClick();
                            }
                          }))
                    ]))));
  }
}

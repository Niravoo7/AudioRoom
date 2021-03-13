import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/search_input_field.dart';
import 'package:audioroom/custom_widget/button_widget.dart';
import 'package:audioroom/custom_widget/choose_people_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/model/choose_people_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChoosePeopleScreen extends StatefulWidget {
  Function onStartRoomClick;

  ChoosePeopleScreen(this.onStartRoomClick);

  @override
  _ChoosePeopleScreenState createState() => _ChoosePeopleScreenState();
}

class _ChoosePeopleScreenState extends State<ChoosePeopleScreen> {
  List<ChoosePeopleModel> choosePeopleModels =[];
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    choosePeopleModels.add(new ChoosePeopleModel(
        "Saikik", "@saikik.jp", AppConstants.str_image_url, false, false));
    choosePeopleModels.add(new ChoosePeopleModel(
        "Mr Beast", "@mrbest6000", AppConstants.str_image_url, false, false));
    choosePeopleModels.add(new ChoosePeopleModel(
        "GraphyBoy", "@graphyboy", AppConstants.str_image_url, false, false));
    choosePeopleModels.add(new ChoosePeopleModel(
        "Amy Doe", "@amygirl", AppConstants.str_image_url, false, false));
    choosePeopleModels.add(new ChoosePeopleModel(
        "Saikik", "@saikik.jp", AppConstants.str_image_url, false, false));
    choosePeopleModels.add(new ChoosePeopleModel(
        "Mr Beast", "@mrbest6000", AppConstants.str_image_url, false, false));
    choosePeopleModels.add(new ChoosePeopleModel(
        "GraphyBoy", "@graphyboy", AppConstants.str_image_url, false, false));
    choosePeopleModels.add(new ChoosePeopleModel(
        "Amy Doe", "@amygirl", AppConstants.str_image_url, false, false));
    choosePeopleModels.add(new ChoosePeopleModel(
        "Rishab Pant", "@amygirl", AppConstants.str_image_url, false, false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(context, "Choose people", true, false, null),
        body: SafeArea(
            child: Container(
                child: Column(children: [
          SearchInputField(AppConstants.str_search_for_people, searchController,
              true, (text) {}),
          DividerWidget(height: 1),
          Flexible(
            child: ListView.builder(
                padding: EdgeInsets.all(0),
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
                }),
            flex: 1,
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child:
                ButtonWidget(context, AppConstants.str_start_a_room_small, () {
              widget.onStartRoomClick();
            }),
          )
        ]))));
  }
}

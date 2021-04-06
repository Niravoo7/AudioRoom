import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/search_input_field.dart';
import 'package:audioroom/custom_widget/button_widget.dart';
import 'package:audioroom/custom_widget/choose_people_widget.dart';
import 'package:audioroom/firestore/network/follow_fire.dart';
import 'package:audioroom/firestore/network/user_fire.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/print_log.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:audioroom/model/choose_people_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChoosePeopleScreen extends StatefulWidget {
  ChoosePeopleScreen();

  @override
  _ChoosePeopleScreenState createState() => _ChoosePeopleScreenState();
}

class _ChoosePeopleScreenState extends State<ChoosePeopleScreen> {
  TextEditingController searchController = new TextEditingController();
  List<ChoosePeopleModel> choosePeopleModels = [];
  List<String> uIdList = [];

  @override
  void initState() {
    super.initState();

    FollowService().getFollowUserConnected().then((value) {
      if (value != null) {
        for (int i = 0; i < value.length; i++) {
          UserService().getUserByReferences(value[i]).then((value) {
            if (value != null) {
              choosePeopleModels.add(ChoosePeopleModel(value, false, false));
              setState(() {});
            }
          });
        }
      } else {
        PrintLog.printMessage("getFollowUserConnected count1 -> null");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(context, "Choose people", true, false, null),
        body: SafeArea(
            child: Container(
                child: Column(children: [
          SearchInputField(
              AppConstants.str_search_for_people, searchController, true,
              (text) {
            setState(() {});
          }),
          DividerWidget(height: 1),
          Flexible(
            child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: choosePeopleModels.length,
                itemBuilder: (BuildContext context, int index) {
                  if (choosePeopleModels[index]
                          .userModel
                          .firstName
                          .toLowerCase()
                          .contains(searchController.text) ||
                      choosePeopleModels[index]
                          .userModel
                          .lastName
                          .toLowerCase()
                          .contains(searchController.text) ||
                      choosePeopleModels[index]
                          .userModel
                          .tagName
                          .toLowerCase()
                          .contains(searchController.text)) {
                    return ChoosePeopleWidget(
                        context,
                        choosePeopleModels[index].userModel.imageUrl,
                        choosePeopleModels[index].userModel.firstName +
                            " " +
                            choosePeopleModels[index].userModel.lastName,
                        choosePeopleModels[index].userModel.tagName,
                        choosePeopleModels[index].isSelected,
                        choosePeopleModels[index].userModel.isOnline, () {
                      choosePeopleModels[index].isSelected =
                          !choosePeopleModels[index].isSelected;
                      if (choosePeopleModels[index].isSelected) {
                        uIdList.add(choosePeopleModels[index].userModel.uId);
                      } else {
                        uIdList.remove(choosePeopleModels[index].userModel.uId);
                      }
                      setState(() {});
                    });
                  } else {
                    return Container();
                  }
                }),
            flex: 1,
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child:
                ButtonWidget(context, AppConstants.str_start_a_room_small, () {
              if (uIdList != null && uIdList.length > 0) {
                Navigator.of(context).pop(uIdList);
              } else {
                showToast(AppConstants.str_please_select_1_user);
              }
            }),
          )
        ]))));
  }
}

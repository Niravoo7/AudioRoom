import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/custom_widget/follow_people_widget.dart';
import 'package:audioroom/model/follow_people_model.dart';

class PeopleScreen extends StatefulWidget {
  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  List<FollowPeopleModel> followPeopleModels = [];

  @override
  void initState() {
    super.initState();
    followPeopleModels.add(new FollowPeopleModel(
        "Saikik", "online", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "Mr Beast", "online", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "GraphyBoy", "online", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "Amy Doe", "12 mins ago", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "Saikik", "online", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "Mr Beast", "10 mins ago", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "GraphyBoy", "online", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "Amy Doe", "online", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "Rishab Pant", "online", AppConstants.str_image_url, false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: followPeopleModels.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FollowPeopleWidget(
                          context,
                          followPeopleModels[index].profilePic,
                          followPeopleModels[index].name,
                          followPeopleModels[index].tagName,
                          AppConstants.str_room,
                          followPeopleModels[index].isFollow, () {
                        followPeopleModels[index].isFollow =
                            !followPeopleModels[index].isFollow;
                        setState(() {});
                      });
                    }))));
  }
}

import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/custom_widget/people_widget.dart';
import 'package:audioroom/model/follow_people_model.dart';

class ClubsScreen extends StatefulWidget {
  @override
  _ClubsScreenState createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  List<FollowPeopleModel> followPeopleModels = new List<FollowPeopleModel>();

  @override
  void initState() {
    super.initState();
    followPeopleModels.add(new FollowPeopleModel(
        "Saikik", "235 members online", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "Mr Beast", "3017 members online", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "GraphyBoy", "3017 members online", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "Amy Doe", "3017 members online", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "Saikik", "3017 members online", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "Mr Beast", "3017 members online", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "GraphyBoy", "3017 members online", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "Amy Doe", "3017 members online", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel("Rishab Pant",
        "3017 members online", AppConstants.str_image_url, false));
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
                    return PeopleWidget(
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
                  }))),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/custom_widget/follow_people_widget.dart';
import 'package:audioroom/model/follow_people_model.dart';

class PeopleScreen extends StatefulWidget {
  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  List<FollowPeopleModel> followPeopleModels =[];

  @override
  void initState() {
    super.initState();
    followPeopleModels.add(new FollowPeopleModel(
        "Saikik", "@saikik.jp", AppConstants.str_image_url, true));
    followPeopleModels.add(new FollowPeopleModel(
        "Mr Beast", "@mrbest6000", AppConstants.str_image_url, true));
    followPeopleModels.add(new FollowPeopleModel(
        "GraphyBoy", "@graphyboy", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "Amy Doe", "@amygirl", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "Saikik", "@saikik.jp", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "Mr Beast", "@mrbest6000", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "GraphyBoy", "@graphyboy", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "Amy Doe", "@amygirl", AppConstants.str_image_url, false));
    followPeopleModels.add(new FollowPeopleModel(
        "Rishab Pant", "@amygirl", AppConstants.str_image_url, false));
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
                          followPeopleModels[index].isFollow
                              ? AppConstants.str_following
                              : AppConstants.str_follow,
                          followPeopleModels[index].isFollow, () {
                        followPeopleModels[index].isFollow =
                            !followPeopleModels[index].isFollow;
                        setState(() {});
                      });
                    }))));
  }
}

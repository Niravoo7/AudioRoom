import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/custom_widget/follow_people_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/search_input_field.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/model/follow_people_model.dart';

class FollowerScreen extends StatefulWidget {
  @override
  _FollowerScreenState createState() => _FollowerScreenState();
}

class _FollowerScreenState extends State<FollowerScreen> {
  List<FollowPeopleModel> followPeopleModels = new List<FollowPeopleModel>();
  TextEditingController searchController = new TextEditingController();

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
        appBar: CommonAppBar(context, "Followers", true, false, null),
        body: SafeArea(
            child: Container(
                child: Column(children: [
          SearchInputField(
              AppConstants.str_search_for_people, searchController, true, (text) {}),
          DividerWidget(height: 1),
          Flexible(
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
                }),
            flex: 1,
          )
        ]))));
  }
}

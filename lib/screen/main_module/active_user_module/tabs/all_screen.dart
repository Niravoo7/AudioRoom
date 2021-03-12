import 'package:audioroom/custom_widget/follow_people_widget.dart';
import 'package:audioroom/custom_widget/title_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';

import 'package:audioroom/model/follow_people_model.dart';

class AllScreen extends StatefulWidget {
  @override
  _AllScreenState createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  List<FollowPeopleModel> followPeopleModelsClub =
      new List<FollowPeopleModel>();
  List<FollowPeopleModel> followPeopleModelsPeople =
      new List<FollowPeopleModel>();

  @override
  void initState() {
    super.initState();
    followPeopleModelsClub.add(new FollowPeopleModel(
        "Saikik", "235 members online", AppConstants.str_image_url, false));
    followPeopleModelsClub.add(new FollowPeopleModel(
        "Mr Beast", "3017 members online", AppConstants.str_image_url, false));
    followPeopleModelsClub.add(new FollowPeopleModel(
        "GraphyBoy", "3017 members online", AppConstants.str_image_url, false));

    followPeopleModelsPeople.add(new FollowPeopleModel(
        "Saikik", "online", AppConstants.str_image_url, false));
    followPeopleModelsPeople.add(new FollowPeopleModel(
        "Mr Beast", "online", AppConstants.str_image_url, false));
    followPeopleModelsPeople.add(new FollowPeopleModel(
        "GraphyBoy", "online", AppConstants.str_image_url, false));
    followPeopleModelsPeople.add(new FollowPeopleModel(
        "Amy Doe", "12 mins ago", AppConstants.str_image_url, false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              TitleWidget(context, AppConstants.str_people),
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: followPeopleModelsClub.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FollowPeopleWidget(
                        context,
                        followPeopleModelsClub[index].profilePic,
                        followPeopleModelsClub[index].name,
                        followPeopleModelsClub[index].tagName,
                        AppConstants.str_room,
                        followPeopleModelsClub[index].isFollow, () {
                      followPeopleModelsClub[index].isFollow =
                          !followPeopleModelsClub[index].isFollow;
                      setState(() {});
                    });
                  }),
              TitleWidget(context, AppConstants.str_clubs),
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: followPeopleModelsPeople.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FollowPeopleWidget(
                        context,
                        followPeopleModelsPeople[index].profilePic,
                        followPeopleModelsPeople[index].name,
                        followPeopleModelsPeople[index].tagName,
                        AppConstants.str_room,
                        followPeopleModelsPeople[index].isFollow, () {
                      followPeopleModelsPeople[index].isFollow =
                          !followPeopleModelsPeople[index].isFollow;
                      setState(() {});
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/custom_widget/follow_people_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/model/follow_people_model.dart';

class PendingInviteScreen extends StatefulWidget {
  @override
  _PendingInviteScreenState createState() => _PendingInviteScreenState();
}

class _PendingInviteScreenState extends State<PendingInviteScreen> {
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
        "GraphyBoy", "@graphyboy", AppConstants.str_image_url, true));
    followPeopleModels.add(new FollowPeopleModel(
        "Amy Doe", "@amygirl", AppConstants.str_image_url, true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          context, "You have 4 pending invites", true, false, null),
      body: SafeArea(
          child: Container(
              child: Column(children: [
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
                    AppConstants.str_send_remainder,
                    followPeopleModels[index].isFollow, () {
                  followPeopleModels[index].isFollow =
                      !followPeopleModels[index].isFollow;
                  setState(() {});
                });
              }),
          flex: 1,
        )
      ]))),
    );
  }
}

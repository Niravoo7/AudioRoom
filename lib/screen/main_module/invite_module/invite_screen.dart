import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/custom_widget/follow_people_widget.dart';
import 'package:audioroom/screen/main_module/invite_module/pending_invite_screen.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/search_input_field.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/model/follow_people_model.dart';
import 'package:audioroom/helper/navigate_effect.dart';

class InviteScreen extends StatefulWidget {
  @override
  _InviteScreenState createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  List<FollowPeopleModel> followPeopleModels = [];
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    followPeopleModels.add(new FollowPeopleModel(
        "Saikik", "@saikik.jp", AppConstants.str_image_url, true));
    followPeopleModels.add(new FollowPeopleModel(
        "Mr Beast", "@mrbest6000", AppConstants.str_image_url, false));
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
      appBar: CommonAppBar(context, "You have 3 Invites", true, false, null),
      body: SafeArea(
          child: Container(
              child: (followPeopleModels.length != 0)
                  ? inviteListWidget()
                  : emptyListWidget())),
    );
  }

  Widget inviteListWidget() {
    return Column(children: [
      SearchInputField(
          AppConstants.str_search_for_clubs, searchController, true, (text) {}),
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
                      ? AppConstants.str_invited
                      : AppConstants.str_invite,
                  followPeopleModels[index].isFollow, () {
                followPeopleModels[index].isFollow =
                    !followPeopleModels[index].isFollow;
                setState(() {});
              });
            }),
        flex: 1,
      )
    ]);
  }

  Widget emptyListWidget() {
    return Container(
        margin: EdgeInsets.all(16),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextWidget(AppConstants.str_empty_invites_list,
              color: AppConstants.clrBlack,
              fontSize: AppConstants.size_medium_large,
              fontWeight: FontWeight.bold,
              maxLines: 10,
              textAlign: TextAlign.center),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context, NavigatePageRoute(context, PendingInviteScreen()));
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    alignment: Alignment.center,
                    height: 36,
                    margin: EdgeInsets.only(right: 16, top: 16),
                    padding: EdgeInsets.only(left: 24, right: 24),
                    decoration: BoxDecoration(
                      color: AppConstants.clrPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextWidget(AppConstants.str_pending_invites,
                        color: AppConstants.clrWhite,
                        fontSize: AppConstants.size_medium,
                        fontWeight: FontWeight.bold,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis)),
              ]))
        ]));
  }
}

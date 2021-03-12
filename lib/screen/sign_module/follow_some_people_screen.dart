import 'package:audioroom/custom_widget/button_widget.dart';
import 'package:audioroom/custom_widget/follow_people_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/navigate_effect.dart';
import 'package:audioroom/model/follow_people_model.dart';
import 'package:audioroom/screen/sign_module/account_created_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FollowSomePeopleScreen extends StatefulWidget {
  @override
  _FollowSomePeopleScreenState createState() => _FollowSomePeopleScreenState();
}

class _FollowSomePeopleScreenState extends State<FollowSomePeopleScreen> {
  List<FollowPeopleModel> followPeopleModels = new List<FollowPeopleModel>();

  @override
  void initState() {
    super.initState();
    followPeopleModels.add(new FollowPeopleModel(
        "Saikik",
        "@saikik.jp",
        AppConstants.str_image_url,
        false));
    followPeopleModels.add(new FollowPeopleModel(
        "Mr Beast",
        "@mrbest6000",
        AppConstants.str_image_url,
        false));
    followPeopleModels.add(new FollowPeopleModel(
        "GraphyBoy",
        "@graphyboy",
        AppConstants.str_image_url,
        false));
    followPeopleModels.add(new FollowPeopleModel(
        "Amy Doe",
        "@amygirl",
        AppConstants.str_image_url,
        false));
    followPeopleModels.add(new FollowPeopleModel(
        "Saikik",
        "@saikik.jp",
        AppConstants.str_image_url,
        false));
    followPeopleModels.add(new FollowPeopleModel(
        "Mr Beast",
        "@mrbest6000",
        AppConstants.str_image_url,
        false));
    followPeopleModels.add(new FollowPeopleModel(
        "GraphyBoy",
        "@graphyboy",
        AppConstants.str_image_url,
        false));
    followPeopleModels.add(new FollowPeopleModel(
        "Amy Doe",
        "@amygirl",
        AppConstants.str_image_url,
        false));
    followPeopleModels.add(new FollowPeopleModel(
        "Rishab Pant",
        "@amygirl",
        AppConstants.str_image_url,
        false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(context, "Follow some people", true, true, () {
          Navigator.push(
              context, NavigatePageRoute(context, AccountCreatedScreen()));
        }),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: ButtonWidget(
                          context, AppConstants.str_create_account, () {
                        submitEvent();
                      }),
                    ),
                  ],
                ))));
  }

  void submitEvent() {
    Navigator.push(context, NavigatePageRoute(context, AccountCreatedScreen()));
  }
}

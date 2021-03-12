import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/custom_widget/title_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/follow_people_widget.dart';
import 'package:audioroom/model/follow_people_model.dart';
import 'package:audioroom/model/interests_model.dart';
import 'package:audioroom/custom_widget/text_widget.dart';

class ConversationsScreen extends StatefulWidget {
  @override
  _ConversationsScreenState createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  List<FollowPeopleModel> followPeopleModelsPeople =
      new List<FollowPeopleModel>();
  List<FollowPeopleModel> followPeopleModelsClubs =
      new List<FollowPeopleModel>();

  List<InterestsCategoryModel> interestsCategoryModels =
      new List<InterestsCategoryModel>();

  List<InterestsModel> interestsModels = new List<InterestsModel>();

  @override
  void initState() {
    super.initState();

    followPeopleModelsPeople.add(new FollowPeopleModel(
        "Saikik", "@saikik.jp", AppConstants.str_image_url, false));
    followPeopleModelsPeople.add(new FollowPeopleModel(
        "Mr Beast", "@mrbest6000", AppConstants.str_image_url, false));
    followPeopleModelsPeople.add(new FollowPeopleModel(
        "GraphyBoy", "@graphyboy", AppConstants.str_image_url, false));

    followPeopleModelsClubs.add(new FollowPeopleModel(
        "Saikik", "235 members online", AppConstants.str_image_url, true));
    followPeopleModelsClubs.add(new FollowPeopleModel(
        "Mr Beast", "3,017 members online", AppConstants.str_image_url, true));
    followPeopleModelsClubs.add(new FollowPeopleModel("GraphyBoy",
        "3,017 members online", AppConstants.str_image_url, false));

    interestsModels = new List<InterestsModel>();
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsCategoryModels
        .add(new InterestsCategoryModel("Topics to Explore", interestsModels));
  }

  @override
  Widget build(BuildContext context) {
    double crossAxisSpacing = 10;
    double mainAxisSpacing = 10;
    double screenWidth = MediaQuery.of(context).size.width - 35;
    int crossAxisCount = 3;
    double width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    double cellHeight =
        (interestsCategoryModels[0].interestsModels[0].description != null)
            ? 70
            : 40;
    double aspectRatio = width / cellHeight;

    return Scaffold(
        appBar:
            CommonAppBar(context, "💬 Conversation Title", true, false, null),
        body: SafeArea(
            child: Container(
                child: ListView(children: [
          TitleWidget(context, AppConstants.str_people_conversation),
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
                    followPeopleModelsPeople[index].isFollow
                        ? AppConstants.str_following
                        : AppConstants.str_follow,
                    followPeopleModelsPeople[index].isFollow, () {
                  followPeopleModelsPeople[index].isFollow =
                      !followPeopleModelsPeople[index].isFollow;
                  setState(() {});
                });
              }),
          Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  color: AppConstants.clrWhite,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16),
                  child: TextWidget(AppConstants.str_view_more_people,
                      color: AppConstants.clrPrimary,
                      fontSize: AppConstants.size_medium,
                      fontWeight: FontWeight.bold)),
              DividerWidget(height: 1)
            ],
          )),
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              itemCount: interestsCategoryModels.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    color: AppConstants.clrTitleBG,
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(interestsCategoryModels[index].categoryName,
                            color: AppConstants.clrBlack,
                            fontSize: AppConstants.size_medium_large,
                            fontWeight: FontWeight.bold),
                        SizedBox(height: 8),
                        (interestsCategoryModels[index].interestsModels !=
                                    null &&
                                interestsCategoryModels[index]
                                        .interestsModels
                                        .length >
                                    0)
                            ? GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(0),
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: interestsCategoryModels[index]
                                    .interestsModels
                                    .length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: crossAxisCount,
                                        crossAxisSpacing: crossAxisSpacing,
                                        mainAxisSpacing: mainAxisSpacing,
                                        childAspectRatio: aspectRatio),
                                itemBuilder:
                                    (BuildContext context, int index1) {
                                  return GestureDetector(
                                    onTap: () {
                                      interestsCategoryModels[index]
                                              .interestsModels[index1]
                                              .isSelected =
                                          !interestsCategoryModels[index]
                                              .interestsModels[index1]
                                              .isSelected;
                                      setState(() {});
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 12),
                                      decoration: BoxDecoration(
                                          color: interestsCategoryModels[index]
                                                  .interestsModels[index1]
                                                  .isSelected
                                              ? AppConstants.clrBlack
                                              : AppConstants.clrWhite,
                                          border: Border.all(
                                              color: AppConstants.clrGrey),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextWidget(
                                              interestsCategoryModels[index]
                                                  .interestsModels[index1]
                                                  .name,
                                              color: interestsCategoryModels[
                                                          index]
                                                      .interestsModels[index1]
                                                      .isSelected
                                                  ? AppConstants.clrWhite
                                                  : AppConstants.clrBlack,
                                              fontSize:
                                                  AppConstants.size_medium,
                                              fontWeight: FontWeight.bold,
                                              maxLines: 1,
                                              textOverflow:
                                                  TextOverflow.ellipsis),
                                          (interestsCategoryModels[index]
                                                      .interestsModels[index1]
                                                      .description !=
                                                  null)
                                              ? TextWidget(
                                                  interestsCategoryModels[index]
                                                      .interestsModels[index1]
                                                      .description,
                                                  color:
                                                      interestsCategoryModels[
                                                                  index]
                                                              .interestsModels[
                                                                  index1]
                                                              .isSelected
                                                          ? AppConstants
                                                              .clrWhite
                                                          : AppConstants
                                                              .clrBlack,
                                                  fontSize: AppConstants
                                                      .size_small_medium,
                                                  fontWeight: FontWeight.w400,
                                                  maxLines: 2,
                                                  textOverflow:
                                                      TextOverflow.ellipsis)
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : Container(),
                        (interestsCategoryModels[index].interestsModels !=
                                    null &&
                                interestsCategoryModels[index]
                                        .interestsModels
                                        .length >
                                    0)
                            ? SizedBox(height: 16)
                            : Container(),
                      ],
                    ));
              }),
          Container(
              color: AppConstants.clrTitleBG,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(AppConstants.str_clubs_to_follow,
                        color: AppConstants.clrBlack,
                        fontSize: AppConstants.size_medium_large,
                        fontWeight: FontWeight.bold),
                    SizedBox(height: 8),
                    DividerWidget(
                        height: 1, width: MediaQuery.of(context).size.width)
                  ])),
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              itemCount: followPeopleModelsClubs.length,
              itemBuilder: (BuildContext context, int index) {
                return FollowPeopleWidget(
                    context,
                    followPeopleModelsClubs[index].profilePic,
                    followPeopleModelsClubs[index].name,
                    followPeopleModelsClubs[index].tagName,
                    followPeopleModelsClubs[index].isFollow
                        ? AppConstants.str_following
                        : AppConstants.str_follow,
                    followPeopleModelsClubs[index].isFollow, () {
                  followPeopleModelsClubs[index].isFollow =
                      !followPeopleModelsClubs[index].isFollow;
                  setState(() {});
                });
              })
        ]))));
  }
}

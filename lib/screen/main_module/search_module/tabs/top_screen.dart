import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/custom_widget/title_widget.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/follow_people_widget.dart';
import 'package:audioroom/model/follow_people_model.dart';
import 'package:audioroom/model/interests_model.dart';
import 'package:audioroom/custom_widget/text_widget.dart';

// ignore: must_be_immutable
class TopScreen extends StatefulWidget {
  Function onConversationsClick;

  TopScreen(this.onConversationsClick);

  @override
  _TopScreenState createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  List<FollowPeopleModel> followPeopleModelsPeople =
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

    interestsModels = new List<InterestsModel>();
    interestsModels.add(new InterestsModel("🌎 Interest", false,
        description: "lorem ipsum lorem ipsu avlorem ipsum sajonnm"));
    interestsModels.add(new InterestsModel("🌎 Interest", false,
        description: "lorem ipsum lorem ipsu avlorem ipsum sajonnm"));
    interestsModels.add(new InterestsModel("🌎 Interest", false,
        description: "lorem ipsum lorem ipsu avlorem ipsum sajonnm"));
    interestsModels.add(new InterestsModel("🌎 Interest", false,
        description: "lorem ipsum lorem ipsu avlorem ipsum sajonnm"));
    interestsModels.add(new InterestsModel("🌎 Interest", false,
        description: "lorem ipsum lorem ipsu avlorem ipsum sajonnm"));
    interestsModels.add(new InterestsModel("🌎 Interest", false,
        description: "lorem ipsum lorem ipsu avlorem ipsum sajonnm"));
    interestsModels.add(new InterestsModel("🌎 Interest", false,
        description: "lorem ipsum lorem ipsu avlorem ipsum sajonnm"));
    interestsModels.add(new InterestsModel("🌎 Interest", false,
        description: "lorem ipsum lorem ipsu avlorem ipsum sajonnm"));
    interestsCategoryModels
        .add(new InterestsCategoryModel("Conversations", interestsModels));
  }

  @override
  Widget build(BuildContext context) {
    double crossAxisSpacing = 10;
    double mainAxisSpacing = 10;
    double screenWidth = MediaQuery.of(context).size.width - 35;
    int crossAxisCount = 2;
    double width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    double cellHeight =
    (interestsCategoryModels[0].interestsModels[0].description != null)
        ? 70
        : 40;
    double aspectRatio = width / cellHeight;

    return Scaffold(
        body: SafeArea(
            child: Container(
                child: ListView(children: [
      TitleWidget(context, AppConstants.str_people),
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
          physics: NeverScrollableScrollPhysics(),
          itemCount: interestsCategoryModels.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                color: AppConstants.clrTitleBG,
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(interestsCategoryModels[index].categoryName,
                        color: AppConstants.clrBlack,
                        fontSize: AppConstants.size_medium_large,
                        fontWeight: FontWeight.bold),
                    SizedBox(height: 8),
                    GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: interestsCategoryModels[index]
                            .interestsModels
                            .length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: crossAxisSpacing,
                            mainAxisSpacing: mainAxisSpacing,
                            childAspectRatio: aspectRatio),
                        itemBuilder: (BuildContext context, int index1) {
                          return GestureDetector(
                            onTap: () {
                              widget.onConversationsClick();
                              /*interestsCategoryModels[index]
                                      .interestsModels[index1]
                                      .isSelected =
                                  !interestsCategoryModels[index]
                                      .interestsModels[index1]
                                      .isSelected;
                              setState(() {});*/
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
                        }),
                    SizedBox(height: 16),
                  ],
                ));
          })
    ]))));
  }
}

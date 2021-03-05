import 'package:audioroom/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/custom_widget/title_widget.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/people_widget.dart';
import 'package:audioroom/model/follow_people_model.dart';
import 'package:audioroom/model/interests_model.dart';
import 'package:audioroom/custom_widget/text_widget.dart';

class TopScreen extends StatefulWidget {
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
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsCategoryModels
        .add(new InterestsCategoryModel("Conversations", interestsModels));
  }

  @override
  Widget build(BuildContext context) {
    double crossAxisSpacing = 10;
    double mainAxisSpacing = 10;
    double screenWidth = MediaQuery.of(context).size.width - 35;
    int crossAxisCount = 3;
    double width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    double cellHeight = 36;
    double aspectRatio = width / cellHeight;

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
                  itemCount: followPeopleModelsPeople.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PeopleWidget(
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
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
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
                        padding:  EdgeInsets.all(16),
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
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: crossAxisSpacing,
                                    mainAxisSpacing: mainAxisSpacing,
                                    childAspectRatio: aspectRatio),
                            itemBuilder: (BuildContext context, int index1) {
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
                                  height: 36,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  decoration: BoxDecoration(
                                      color: interestsCategoryModels[index]
                                              .interestsModels[index1]
                                              .isSelected
                                          ? AppConstants.clrBlack
                                          : AppConstants.clrWhite,
                                      border: Border.all(
                                          color: AppConstants.clrGrey),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextWidget(
                                      interestsCategoryModels[index]
                                          .interestsModels[index1]
                                          .name,
                                      color: interestsCategoryModels[index]
                                              .interestsModels[index1]
                                              .isSelected
                                          ? AppConstants.clrWhite
                                          : AppConstants.clrBlack,
                                      fontSize: AppConstants.size_medium,
                                      fontWeight: FontWeight.bold,
                                      maxLines: 1,
                                      textOverflow: TextOverflow.ellipsis),
                                ),
                              );
                            }),
                        SizedBox(height: 16),
                      ],
                    ));
                  })
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:audioroom/custom_widget/button_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/navigate_effect.dart';
import 'package:audioroom/model/interests_model.dart';
import 'package:audioroom/screen/sign_module/follow_some_people_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseYourInterestsScreen extends StatefulWidget {
  @override
  _ChooseYourInterestsScreenState createState() =>
      _ChooseYourInterestsScreenState();
}

class _ChooseYourInterestsScreenState extends State<ChooseYourInterestsScreen> {
  List<InterestsCategoryModel> interestsCategoryModels =
      new List<InterestsCategoryModel>();

  List<InterestsModel> interestsModels = new List<InterestsModel>();

  @override
  void initState() {
    super.initState();
    interestsModels = new List<InterestsModel>();
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsCategoryModels
        .add(new InterestsCategoryModel("Category Title", interestsModels));

    interestsModels = new List<InterestsModel>();
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsCategoryModels
        .add(new InterestsCategoryModel("Category Title", interestsModels));

    interestsModels = new List<InterestsModel>();
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsModels.add(new InterestsModel("🌎 Interest", false));
    interestsCategoryModels
        .add(new InterestsCategoryModel("Category Title", interestsModels));
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
      appBar: CommonAppBar(
          context, "Choose your interests", true, true, (){
        Navigator.push(
            context, NavigatePageRoute(context, FollowSomePeopleScreen()));
      }),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: interestsCategoryModels.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                    interestsCategoryModels[index].categoryName,
                                    color: AppConstants.clrBlack,
                                    fontSize: AppConstants.size_medium_large,
                                    fontWeight: FontWeight.bold),
                                SizedBox(height: 8),
                                GridView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(0),physics: NeverScrollableScrollPhysics(),
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
                                          height: 36,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                              left: 5, right: 5),
                                          decoration: BoxDecoration(
                                              color: interestsCategoryModels[
                                                          index]
                                                      .interestsModels[index1]
                                                      .isSelected
                                                  ? AppConstants.clrBlack
                                                  : AppConstants.clrWhite,
                                              border: Border.all(
                                                  color: AppConstants.clrGrey),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: TextWidget(
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
                                        ),
                                      );
                                    }),
                                SizedBox(height: 16),
                              ],
                            ));
                          }),
                      flex: 1,
                    ),
                    ButtonWidget(context, AppConstants.str_continue, () {
                      submitEvent();
                    }),
                  ],
                ))));
  }

  void submitEvent() {
    Navigator.push(
        context, NavigatePageRoute(context, FollowSomePeopleScreen()));
  }
}

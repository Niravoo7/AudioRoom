import 'package:audioroom/custom_widget/follow_people_widget.dart';
import 'package:audioroom/firestore/model/user_model.dart';
import 'package:audioroom/firestore/network/user_fire.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/print_log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/custom_widget/title_widget.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';

// ignore: must_be_immutable
class TopScreen extends StatefulWidget {
  Function onConversationsClick;
  Function(String) onOtherProfileClick;
  TextEditingController searchController;

  TopScreen(this.searchController, this.onConversationsClick,
      this.onOtherProfileClick);

  @override
  _TopScreenState createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  bool isMorePeople = false;

  //List<InterestsCategoryModel> interestsCategoryModels = [];

  //List<InterestsModel> interestsModels = [];

  @override
  void initState() {
    super.initState();
    /*interestsModels = [];
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
        .add(new InterestsCategoryModel("Conversations", interestsModels));*/
  }

  @override
  Widget build(BuildContext context) {
    PrintLog.printMessage("_TopScreenState -> " + widget.searchController.text);

    /*double crossAxisSpacing = 10;
    double mainAxisSpacing = 10;
    double screenWidth = MediaQuery.of(context).size.width - 35;
    int crossAxisCount = 2;
    double width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    double cellHeight =
        (interestsCategoryModels[0].interestsModels[0].description != null)
            ? 70
            : 40;
    double aspectRatio = width / cellHeight;*/

    return Scaffold(
        body: SafeArea(
            child: Container(
                child: ListView(children: [
      TitleWidget(context, AppConstants.str_people),
      StreamBuilder(
        stream: UserService().getUserTopQuery().snapshots(),
        builder: (context, stream) {
          if (stream.hasError) {
            return Center(
                child: TextWidget(stream.error.toString(),
                    color: AppConstants.clrBlack, fontSize: 20));
          }
          QuerySnapshot querySnapshot = stream.data;
          if (querySnapshot == null || querySnapshot.size == 1) {
            if (querySnapshot == null) {
              return Container();
            } else {
              return Center(
                child: TextWidget(
                    AppConstants.str_no_record_found,
                    color: AppConstants.clrBlack,
                    fontSize: 20),
              );
            }
          } else {
            return Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0),
                    itemCount: isMorePeople || querySnapshot.size < 3
                        ? querySnapshot.size
                        : 3,
                    itemBuilder: (BuildContext context, int index) {
                      UserModel userModelTemp =
                          UserModel.fromJson(querySnapshot.docs[index].data());
                      if (userModelTemp.uId ==
                          FirebaseAuth.instance.currentUser.uid) {
                        return Container();
                      } else {
                        if (userModelTemp.firstName
                                .toLowerCase()
                                .contains(widget.searchController.text) ||
                            userModelTemp.lastName
                                .toLowerCase()
                                .contains(widget.searchController.text) ||
                            userModelTemp.tagName
                                .toLowerCase()
                                .contains(widget.searchController.text)) {
                          return FollowPeopleWidget(
                              context,
                              userModelTemp.imageUrl,
                              userModelTemp.firstName +
                                  " " +
                                  userModelTemp.lastName,
                              userModelTemp.tagName,
                              userModelTemp.uId,
                              onClick: widget.onOtherProfileClick);
                        } else {
                          return Container();
                        }
                      }
                    }),
                (querySnapshot.size > 3)
                    ? Container(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              isMorePeople = !isMorePeople;
                              setState(() {});
                            },
                            child: Container(
                                color: AppConstants.clrWhite,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(16),
                                child: TextWidget(
                                    (!isMorePeople)
                                        ? AppConstants.str_view_more_people
                                        : AppConstants.str_view_less_people,
                                    color: AppConstants.clrPrimary,
                                    fontSize: AppConstants.size_medium,
                                    fontWeight: FontWeight.bold)),
                          ),
                          DividerWidget(height: 1)
                        ],
                      ))
                    : Container(),
              ],
            );
          }
        },
      ),

      /*ListView.builder(
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
                                  border:
                                      Border.all(color: AppConstants.clrGrey),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextWidget(
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
                                  (interestsCategoryModels[index]
                                              .interestsModels[index1]
                                              .description !=
                                          null)
                                      ? TextWidget(
                                          interestsCategoryModels[index]
                                              .interestsModels[index1]
                                              .description,
                                          color: interestsCategoryModels[index]
                                                  .interestsModels[index1]
                                                  .isSelected
                                              ? AppConstants.clrWhite
                                              : AppConstants.clrBlack,
                                          fontSize:
                                              AppConstants.size_small_medium,
                                          fontWeight: FontWeight.w400,
                                          maxLines: 2,
                                          textOverflow: TextOverflow.ellipsis)
                                      : Container(),
                                ],
                              ),
                            ),
                          );
                        }),
                    SizedBox(height: 16),
                  ],
                ));
          })*/
    ]))));
  }
}

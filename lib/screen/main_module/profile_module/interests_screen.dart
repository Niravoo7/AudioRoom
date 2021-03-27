import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/firestore/model/interest_model.dart';
import 'package:audioroom/firestore/model/interest_option_model.dart';
import 'package:audioroom/firestore/network/interest_fire.dart';
import 'package:audioroom/firestore/network/interest_option_fire.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InterestsScreen extends StatefulWidget {
  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  List<String> selectedInterests = [];

  @override
  Widget build(BuildContext context) {
    double crossAxisSpacing = 10;
    double mainAxisSpacing = 10;
    double screenWidth = MediaQuery.of(context).size.width - 35;
    int crossAxisCount = 3;
    double width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    double cellHeight = 40;
    double aspectRatio = width / cellHeight;

    return Scaffold(
        appBar: CommonAppBar(context, "Interests", true, false, null),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: StreamBuilder(
                  stream: InterestService().getInterestQuery().snapshots(),
                  builder: (context, stream) {
                    if (stream.hasError) {
                      return Center(
                          child: TextWidget(stream.error.toString(),
                              color: AppConstants.clrBlack, fontSize: 20));
                    }
                    QuerySnapshot querySnapshot = stream.data;
                    if (querySnapshot == null || querySnapshot.size == 0) {
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
                      return ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: querySnapshot.size,
                          itemBuilder: (BuildContext context, int index) {
                            InterestModel interestModelTemp =
                                InterestModel.fromJson(
                                    querySnapshot.docs[index].data());
                            return Container(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(interestModelTemp.categoryTitle,
                                    color: AppConstants.clrBlack,
                                    fontSize: AppConstants.size_medium_large,
                                    fontWeight: FontWeight.bold),
                                Container(
                                  child: StreamBuilder(
                                    stream: InterestOptionService()
                                        .getInterestOptionQuery(
                                            querySnapshot.docs[index].id)
                                        .snapshots(),
                                    builder: (context, stream) {
                                      if (stream.hasError) {
                                        return Center(
                                            child: TextWidget(
                                                stream.error.toString(),
                                                color: AppConstants.clrBlack,
                                                fontSize: 20));
                                      }
                                      QuerySnapshot querySnapshot1 =
                                          stream.data;
                                      if (querySnapshot1 == null ||
                                          querySnapshot1.size == 0) {
                                        return Container();
                                      } else {
                                        return GridView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.only(
                                                top: 8, bottom: 16),
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: querySnapshot1.size,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount:
                                                        crossAxisCount,
                                                    crossAxisSpacing:
                                                        crossAxisSpacing,
                                                    mainAxisSpacing:
                                                        mainAxisSpacing,
                                                    childAspectRatio:
                                                        aspectRatio),
                                            itemBuilder: (BuildContext context,
                                                int index1) {
                                              InterestOptionModel
                                                  interestOptionModelTemp =
                                                  InterestOptionModel.fromJson(
                                                      querySnapshot1
                                                          .docs[index1]
                                                          .data());

                                              return GestureDetector(
                                                onTap: () {
                                                  if (selectedInterests.contains(
                                                      interestOptionModelTemp
                                                          .title)) {
                                                    selectedInterests.remove(
                                                        interestOptionModelTemp
                                                            .title);
                                                  } else {
                                                    selectedInterests.add(
                                                        interestOptionModelTemp
                                                            .title);
                                                  }
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 12),
                                                  decoration: BoxDecoration(
                                                      color: (selectedInterests
                                                              .contains(
                                                                  interestOptionModelTemp
                                                                      .title))
                                                          ? AppConstants
                                                              .clrBlack
                                                          : AppConstants
                                                              .clrWhite,
                                                      border: Border.all(
                                                          color: AppConstants
                                                              .clrGrey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: TextWidget(
                                                      interestOptionModelTemp
                                                          .title,
                                                      color: (selectedInterests
                                                              .contains(
                                                                  interestOptionModelTemp
                                                                      .title))
                                                          ? AppConstants
                                                              .clrWhite
                                                          : AppConstants
                                                              .clrBlack,
                                                      fontSize: AppConstants
                                                          .size_medium,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      maxLines: 1,
                                                      textOverflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              );
                                            });
                                      }
                                    },
                                  ),
                                )
                              ],
                            ));
                          });
                    }
                  },
                ))));
  }
}

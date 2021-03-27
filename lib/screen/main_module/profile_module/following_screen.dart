import 'package:audioroom/custom_widget/follow_people_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/firestore/model/follow_model.dart';
import 'package:audioroom/firestore/model/user_model.dart';
import 'package:audioroom/firestore/network/follow_fire.dart';
import 'package:audioroom/firestore/network/user_fire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/search_input_field.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';

class FollowingScreen extends StatefulWidget {
  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(context, "Following", true, false, null),
      body: SafeArea(
          child: Container(
              child: Column(children: [
        SearchInputField(AppConstants.str_search_for_people, searchController,
            true, (text) {}),
        DividerWidget(height: 1),
        Flexible(
          child: StreamBuilder(
            stream: FollowService().checkFollowingByUID().snapshots(),
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
                    child: TextWidget(AppConstants.str_no_record_found,
                        color: AppConstants.clrBlack, fontSize: 20),
                  );
                }
              } else {
                return ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: querySnapshot.size,
                    itemBuilder: (BuildContext context, int index) {
                      FollowModel followModel = FollowModel.fromJson(
                          querySnapshot.docs[index].data());

                      return StreamBuilder(
                        stream: UserService()
                            .getUserByReferencesStream(followModel.followTo),
                        builder: (context, stream) {
                          if (stream.hasError) {
                            return Center(
                                child: TextWidget(stream.error.toString(),
                                    color: AppConstants.clrBlack,
                                    fontSize: 20));
                          }
                          UserModel userModel = stream.data;
                          if (userModel != null) {
                            return FollowPeopleWidget(
                                context,
                                userModel.imageUrl,
                                userModel.firstName + " " + userModel.lastName,
                                userModel.tagName,
                                userModel.uId,
                                onClick: (str) {});
                          } else {
                            return Container();
                          }
                        },
                      );
                    });
              }
            },
          ),
          flex: 1,
        )
      ]))),
    );
  }
}

import 'package:audioroom/custom_widget/follow_people_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/firestore/model/user_model.dart';
import 'package:audioroom/firestore/network/user_fire.dart';
import 'package:audioroom/helper/print_log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';

// ignore: must_be_immutable
class PeopleScreen extends StatefulWidget {
  Function(String) onOtherProfileClick;
  TextEditingController searchController;

  PeopleScreen(this.searchController, this.onOtherProfileClick);

  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  @override
  Widget build(BuildContext context) {
    PrintLog.printMessage(
        "_PeopleScreenState -> " + widget.searchController.text);

    return Scaffold(
        body: SafeArea(
            child: Container(
                child: StreamBuilder(
                    stream: UserService().getUserQuery().snapshots(),
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
                        return ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemCount: querySnapshot.size,
                            itemBuilder: (BuildContext context, int index) {
                              UserModel userModelTemp = UserModel.fromJson(
                                  querySnapshot.docs[index].data());
                              if (userModelTemp.uId ==
                                  FirebaseAuth.instance.currentUser.uid) {
                                return Container();
                              } else {
                                if (userModelTemp.firstName
                                        .toLowerCase()
                                        .contains(
                                            widget.searchController.text) ||
                                    userModelTemp.lastName
                                        .toLowerCase()
                                        .contains(
                                            widget.searchController.text) ||
                                    userModelTemp.tagName
                                        .toLowerCase()
                                        .contains(
                                            widget.searchController.text)) {
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
                            });
                      }
                    }))));
  }
}

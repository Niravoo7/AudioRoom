import 'package:audioroom/custom_widget/button_widget.dart';
import 'package:audioroom/custom_widget/follow_people_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/firestore/network/user_fire.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/navigate_effect.dart';
import 'package:audioroom/screen/sign_module/account_created_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FollowSomePeopleScreen extends StatefulWidget {
  @override
  _FollowSomePeopleScreenState createState() => _FollowSomePeopleScreenState();
}

class _FollowSomePeopleScreenState extends State<FollowSomePeopleScreen> {
  String uid;

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser.uid;
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
                      child: Container(
                        child: StreamBuilder(
                          stream: UserService().getUserQuery().snapshots(),
                          builder: (context, stream) {
                            /*if (stream.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }*/
                            if (stream.hasError) {
                              return Center(
                                  child: TextWidget(stream.error.toString(),
                                      color: AppConstants.clrBlack,
                                      fontSize: 20));
                            }
                            QuerySnapshot querySnapshot = stream.data;
                            if (querySnapshot == null ||
                                querySnapshot.size == 0) {
                              return Center(
                                  child: TextWidget(
                                      AppConstants.str_no_room_found,
                                      color: AppConstants.clrBlack,
                                      fontSize: 20));
                            }
                            return ListView.builder(
                                padding: EdgeInsets.all(0),
                                itemCount: querySnapshot.size,
                                itemBuilder: (BuildContext context, int index) {
                                  return FollowPeopleWidget(
                                      context,
                                      querySnapshot.docs[index]["image_url"],
                                      querySnapshot.docs[index]["first_name"] +
                                          " " +
                                          querySnapshot.docs[index]
                                              ["last_name"],
                                      querySnapshot.docs[index]["tag_name"],
                                      AppConstants.str_follow,
                                      false,
                                      () {});
                                });
                          },
                        ),
                      ),
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

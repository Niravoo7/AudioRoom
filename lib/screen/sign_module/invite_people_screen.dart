import 'package:audioroom/custom_widget/button_widget.dart';
import 'package:audioroom/firestore/model/user_model.dart';
import 'package:audioroom/firestore/network/user_fire.dart';
import 'package:audioroom/screen/sign_module/account_created_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/custom_widget/invite_people_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/search_input_field.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/navigate_effect.dart';

class InvitePeopleScreen extends StatefulWidget {
  @override
  _InvitePeopleScreenState createState() => _InvitePeopleScreenState();
}

class _InvitePeopleScreenState extends State<InvitePeopleScreen> {
  TextEditingController searchController = new TextEditingController();
  List<String> strInvited = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(context, "Invite people", true, true, () {
        Navigator.push(
            context, NavigatePageRoute(context, AccountCreatedScreen()));
      }),
      body: SafeArea(child: Container(child: inviteListWidget())),
    );
  }

  Widget inviteListWidget() {
    return Column(children: [
      SearchInputField(
          AppConstants.str_search_for_people, searchController, true, (text) {
        setState(() {});
      }),
      DividerWidget(height: 1),
      Flexible(
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
                    child: TextWidget(AppConstants.str_no_record_found,
                        color: AppConstants.clrBlack, fontSize: 20),
                  );
                }
              } else {
                return ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: querySnapshot.size,
                    itemBuilder: (BuildContext context, int index) {
                      UserModel userModelTemp =
                          UserModel.fromJson(querySnapshot.docs[index].data());
                      if (userModelTemp.uId ==
                          FirebaseAuth.instance.currentUser.uid) {
                        return Container();
                      } else {
                        if (userModelTemp.firstName
                                .toLowerCase()
                                .contains(searchController.text) ||
                            userModelTemp.lastName
                                .toLowerCase()
                                .contains(searchController.text) ||
                            userModelTemp.tagName
                                .toLowerCase()
                                .contains(searchController.text)) {
                          return InvitePeopleWidget(
                              context,
                              userModelTemp.imageUrl,
                              userModelTemp.firstName +
                                  " " +
                                  userModelTemp.lastName,
                              userModelTemp.tagName,
                              userModelTemp.uId,
                              strInvited.contains(userModelTemp.tagName),
                              onInviteClick: () {
                            if (strInvited.contains(userModelTemp.tagName)) {
                              strInvited.remove(userModelTemp.tagName);
                            } else {
                              strInvited.add(userModelTemp.tagName);
                            }
                            setState(() {});
                          });
                        } else {
                          return Container();
                        }
                      }
                    });
              }
            }),
        flex: 1,
      ),
      Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: ButtonWidget(context, AppConstants.str_create_account, () {
          submitEvent();
        }),
      ),
    ]);
  }

  void submitEvent() {
    Navigator.push(context, NavigatePageRoute(context, AccountCreatedScreen()));
  }
}

import 'package:audioroom/firestore/model/user_model.dart';
import 'package:audioroom/firestore/network/user_fire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/custom_widget/invite_people_widget.dart';
import 'package:audioroom/screen/main_module/invite_module/pending_invite_screen.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/search_input_field.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/navigate_effect.dart';

class InviteScreen extends StatefulWidget {
  @override
  _InviteScreenState createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  TextEditingController searchController = new TextEditingController();
  List<String> strInvited = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(context, "Invites", true, false, null),
      body: SafeArea(
          child: Container(
              child:
                  inviteListWidget() /*(followPeopleModels.length != 0)
                  ? inviteListWidget()
                  : emptyListWidget()*/
              )),
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
      )
    ]);
  }

  Widget emptyListWidget() {
    return Container(
        margin: EdgeInsets.all(16),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextWidget(AppConstants.str_empty_invites_list,
              color: AppConstants.clrBlack,
              fontSize: AppConstants.size_medium_large,
              fontWeight: FontWeight.bold,
              maxLines: 10,
              textAlign: TextAlign.center),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context, NavigatePageRoute(context, PendingInviteScreen()));
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    alignment: Alignment.center,
                    height: 36,
                    margin: EdgeInsets.only(right: 16, top: 16),
                    padding: EdgeInsets.only(left: 24, right: 24),
                    decoration: BoxDecoration(
                      color: AppConstants.clrPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextWidget(AppConstants.str_pending_invites,
                        color: AppConstants.clrWhite,
                        fontSize: AppConstants.size_medium,
                        fontWeight: FontWeight.bold,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis)),
              ]))
        ]));
  }
}

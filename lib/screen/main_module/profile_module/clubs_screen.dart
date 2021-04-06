import 'package:audioroom/custom_widget/club_people_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/firestore/model/club_model.dart';
import 'package:audioroom/firestore/network/club_fire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/custom_widget/search_input_field.dart';
import 'package:audioroom/custom_widget/divider_widget.dart';

class ClubsScreen extends StatefulWidget {
  @override
  _ClubsScreenState createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(context, "Clubs", true, false, null),
      body: SafeArea(
          child: Container(
              child: Column(children: [
                SearchInputField(
                    AppConstants.str_search_for_clubs, searchController, true, (text) {
                      setState(() {

                      });
                }),
                DividerWidget(height: 1),
                Flexible(
                  child: StreamBuilder(
                    stream: ClubService().getClubByUIDQuery().snapshots(),
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
                              ClubModel clubModelTemp =
                              ClubModel.fromJson(querySnapshot.docs[index].data());
                              if (clubModelTemp.clubName
                                  .toLowerCase()
                                  .contains(searchController.text)) {
                                return ClubPeopleWidget(
                                    context,
                                    clubModelTemp.imageUrl,
                                    clubModelTemp.clubName,
                                    clubModelTemp.userList.length.toString(),
                                    clubModelTemp);
                              } else {
                                return Container();
                              }
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

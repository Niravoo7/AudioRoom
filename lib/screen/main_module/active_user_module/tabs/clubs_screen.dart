import 'package:audioroom/custom_widget/club_people_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/firestore/model/club_model.dart';
import 'package:audioroom/firestore/network/club_fire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:audioroom/helper/constants.dart';

// ignore: must_be_immutable
class ClubsScreen extends StatefulWidget {
  TextEditingController searchController;

  ClubsScreen(this.searchController);

  @override
  _ClubsScreenState createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                child: StreamBuilder(
                    stream: ClubService().getClubQuery().snapshots(),
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
                                  fontSize: 20));
                        }
                      } else {
                        return ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemCount: querySnapshot.size,
                            itemBuilder: (BuildContext context, int index) {
                              ClubModel clubModelTemp = ClubModel.fromJson(
                                  querySnapshot.docs[index].data());
                              if (clubModelTemp.clubName
                                  .toLowerCase()
                                  .contains(widget.searchController.text)) {
                                return ClubPeopleWidget(
                                    context,
                                    clubModelTemp.imageUrl,
                                    clubModelTemp.clubName,
                                    clubModelTemp.onlineMemberCount.toString(),
                                    clubModelTemp);
                              } else {
                                return Container();
                              }
                            });
                      }
                    }))));
  }
}

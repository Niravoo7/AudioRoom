import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
//import 'package:audioroom/firestore/model/notification_model.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/firestore/network/notification_fire.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class NotificationScreen extends StatefulWidget {
  NotificationScreen();

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(context, "Notifications", true, false, null),
        body: SafeArea(
            child: Container(
                child: StreamBuilder(
          stream: NotificationService().getNotificationQuery().snapshots(),
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
                    return Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 16, top: 16, bottom: 16),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppConstants.clrGrey),
                            child: Image.network(/*notificationModel.imageUrl*/"",
                                height: 40, width: 40),
                          ),
                          Flexible(
                            child: Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                width: MediaQuery.of(context).size.width,
                                child: TextWidget(/*notificationModel.description*/"",
                                    color: AppConstants.clrBlack,
                                    maxLines: 2,
                                    fontSize: AppConstants.size_medium_large,
                                    fontWeight: FontWeight.bold)),
                            flex: 1,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 16),
                            child: TextWidget(
                                strDateDifference(dateDifference(
                                    /*notificationModel.createDatetime*/DateTime.now())),
                                color: AppConstants.clrBlack,
                                fontSize: AppConstants.size_small_medium,
                                fontWeight: FontWeight.w500),
                          )
                        ]),
                        DividerWidget(
                            height: 1, width: MediaQuery.of(context).size.width)
                      ],
                    ));
                  });
            }
          },
        ))));
  }
}

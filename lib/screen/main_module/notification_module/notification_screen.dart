import 'package:audioroom/custom_widget/divider_widget.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/custom_widget/common_appbar.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/model/notification_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NotificationScreen extends StatefulWidget {
  NotificationScreen();

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notificationModels =[];

  @override
  void initState() {
    super.initState();
    notificationModels.add(new NotificationModel(
        "AudioRoom says we have added 3 invites to your account.",
        AppConstants.str_image_url,
        "12 mins ago"));
    notificationModels.add(new NotificationModel(
        "Alex Benkre followed you", AppConstants.str_image_url, "28 mins ago"));
    notificationModels.add(new NotificationModel(
        "Amy Doe followed you", AppConstants.str_image_url, "30 mins ago"));
    notificationModels.add(new NotificationModel(
        "Alex Benkre followed you", AppConstants.str_image_url, "1 mins ago"));
    notificationModels.add(new NotificationModel(
        "Amy Doe followed you", AppConstants.str_image_url, "2 mins ago"));
    notificationModels.add(new NotificationModel(
        "Alex Benkre followed you", AppConstants.str_image_url, "2 mins ago"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(context, "Notifications", true, false, null),
        body: SafeArea(
            child: Container(
                child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: notificationModels.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 16, top: 16, bottom: 16),
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Image.network(
                                  notificationModels[index].profilePic,
                                  height: 40,
                                  width: 40),
                            ),
                            Flexible(
                              child: Container(
                                  margin: EdgeInsets.only(left: 10,right: 10),
                                  width: MediaQuery.of(context).size.width,
                                  child: TextWidget(
                                      notificationModels[index].name,
                                      color: AppConstants.clrBlack,
                                      maxLines: 2,
                                      fontSize: AppConstants.size_medium_large,
                                      fontWeight: FontWeight.bold)),
                              flex: 1,
                            ),
                            Container(margin: EdgeInsets.only(right: 16),
                              child: TextWidget(notificationModels[index].mins,
                                  color: AppConstants.clrBlack,
                                  fontSize: AppConstants.size_small_medium,
                                  fontWeight: FontWeight.w500),
                            )
                          ]),
                          DividerWidget(
                              height: 1,
                              width: MediaQuery.of(context).size.width)
                        ],
                      ));
                    }))));
  }
}

import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/custom_widget/room_card_user_widget.dart';
import 'package:audioroom/firestore/model/room_model.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/print_log.dart';
import 'package:flutter/cupertino.dart';

// ignore: non_constant_identifier_names
Widget RoomCardWidget(
    BuildContext context, RoomModel roomModel, bool disableNotificationIcon) {
  PrintLog.printMessage("RoomCardWidget -> " +
      (roomModel.broadcaster.length + roomModel.moderator.length).toString());
  double crossAxisSpacing = 10;
  double mainAxisSpacing = 10;
  double screenWidth = MediaQuery.of(context).size.width - 35;
  int crossAxisCount = 3;
  double width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
      crossAxisCount;
  double cellHeight = 50;
  double aspectRatio = width / cellHeight;
  return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppConstants.clrTransparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: AppConstants.clrWidgetBGColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 8),
                    child: Image.asset(
                      AppConstants.ic_dark_home,
                      height: 18,
                      width: 18,
                      color: AppConstants.clrBlack,
                    ),
                  ),
                  TextWidget(roomModel.roomName,
                      color: AppConstants.clrBlack,
                      fontSize: AppConstants.size_small_medium,
                      fontWeight: FontWeight.normal),
                  disableNotificationIcon == true
                      ? Container(
                          padding: EdgeInsets.only(left: 10, right: 8),
                          child: Image.asset(
                            AppConstants.ic_clock,
                            height: 18,
                            width: 18,
                            color: AppConstants.clrBlack,
                          ),
                        )
                      : Container(),
                  disableNotificationIcon == true
                      ? TextWidget('Tomorrow at 3:30 PM',
                          color: AppConstants.clrBlack,
                          fontSize: AppConstants.size_small_medium,
                          fontWeight: FontWeight.normal)
                      : Container(),
                ],
              ),
              disableNotificationIcon == true
                  ? Image.asset(
                      AppConstants.ic_notification,
                      height: 18,
                      width: 18,
                      color: AppConstants.clrBlack,
                    )
                  : Container(),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 13),
            child: TextWidget(roomModel.roomDesc,
                color: AppConstants.clrBlack,
                fontSize: AppConstants.size_medium_large,
                fontWeight: FontWeight.w600,
                maxLines: 2),
          ),
          GridView.builder(
              padding: EdgeInsets.only(top: 8),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: mainAxisSpacing,
                  childAspectRatio: aspectRatio),
              itemCount:
                  roomModel.broadcaster.length + roomModel.moderator.length,
              itemBuilder: (context, index) {
                if (roomModel.broadcaster.length <= index) {
                  return RoomCardUserWidget(
                      uId: roomModel
                          .moderator[index - roomModel.broadcaster.length]);
                } else {
                  return RoomCardUserWidget(uId: roomModel.broadcaster[index]);
                }
              }),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 8),
                child: Image.asset(
                  AppConstants.ic_speaker,
                  height: 15,
                  width: 15,
                  color: AppConstants.clrBlack,
                ),
              ),
              TextWidget(roomModel.broadcaster.length.toString(),
                  color: AppConstants.clrBlack,
                  fontSize: AppConstants.size_small_medium,
                  fontWeight: FontWeight.normal),
              (roomModel.people != null && roomModel.people.length > 0)
                  ? Container(
                      padding: const EdgeInsets.only(right: 8, left: 10),
                      child: Image.asset(
                        AppConstants.ic_user,
                        height: 15,
                        width: 15,
                        color: AppConstants.clrBlack,
                      ),
                    )
                  : Container(),
              (roomModel.people != null && roomModel.people.length > 0)
                  ? TextWidget(roomModel.people.length.toString(),
                      color: AppConstants.clrBlack,
                      fontSize: AppConstants.size_small_medium,
                      fontWeight: FontWeight.normal)
                  : Container(),
            ],
          )
        ],
      ));
}

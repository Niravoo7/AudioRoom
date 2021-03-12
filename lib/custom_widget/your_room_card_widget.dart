import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/custom_widget/flexible_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/model/your_room_card_model.dart';
import 'package:flutter/cupertino.dart';

// ignore: non_constant_identifier_names
Widget YourRoomCardWidget(BuildContext context,
    YourRoomCardModel yourRoomCardModel, bool isSubWidget) {
  double crossAxisSpacing = 16;
  double mainAxisSpacing = 16;
  double screenWidth = MediaQuery.of(context).size.width - 35;
  int crossAxisCount = 4;
  double width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
      crossAxisCount;
  double cellHeight = ((MediaQuery.of(context).size.width - 115) / 4) + 35;
  double aspectRatio = width / cellHeight;
  return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppConstants.clrTransparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: AppConstants.clrWidgetBGColor)),
      child: Column(
        children: [
          (!isSubWidget)
              ? Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.asset(
                        AppConstants.ic_dark_home,
                        height: 14,
                        width: 14,
                        color: AppConstants.clrBlack,
                      ),
                    ),
                    TextWidget(yourRoomCardModel.title,
                        color: AppConstants.clrBlack,
                        fontSize: AppConstants.size_small_medium,
                        fontWeight: FontWeight.normal),
                    Container(
                      padding: const EdgeInsets.only(right: 8, left: 16),
                      child: Image.asset(
                        AppConstants.ic_speaker,
                        height: 10,
                        width: 10,
                        color: AppConstants.clrBlack,
                      ),
                    ),
                    TextWidget(yourRoomCardModel.speakerCounter,
                        color: AppConstants.clrBlack,
                        fontSize: AppConstants.size_small_medium,
                        fontWeight: FontWeight.normal),
                    FlexibleWidget(1),
                    Container(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.asset(
                        AppConstants.ic_edit,
                        height: 22,
                        width: 22,
                        color: AppConstants.clrBlack,
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        AppConstants.ic_lock,
                        height: 22,
                        width: 22,
                        color: AppConstants.clrBlack,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.asset(
                        AppConstants.ic_speaker,
                        height: 10,
                        width: 10,
                        color: AppConstants.clrBlack,
                      ),
                    ),
                    TextWidget(yourRoomCardModel.speakerCounter,
                        color: AppConstants.clrBlack,
                        fontSize: AppConstants.size_small_medium,
                        fontWeight: FontWeight.normal),
                    FlexibleWidget(1),
                  ],
                ),
          (!isSubWidget)
              ?Container(
            padding: EdgeInsets.only(top: 8),
            child: TextWidget(yourRoomCardModel.detail,
                color: AppConstants.clrBlack,
                fontSize: AppConstants.size_medium_large,
                fontWeight: FontWeight.w600,
                maxLines: 2),
          ):Container(),
          GridView.builder(
              padding: EdgeInsets.only(top: 8),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: mainAxisSpacing,
                  childAspectRatio: aspectRatio),
              itemCount: yourRoomCardModel.yourRoomCardPeopleModels.length,
              itemBuilder: (context, index1) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height:
                                (MediaQuery.of(context).size.width - 115) / 4,
                            width:
                                (MediaQuery.of(context).size.width - 115) / 4,
                            margin: EdgeInsets.only(bottom: 4),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.all(Radius.circular(8)),
                                color: AppConstants.clrTransparent,
                                image: DecorationImage(
                                    image: AssetImage(yourRoomCardModel
                                        .yourRoomCardPeopleModels[index1]
                                        .profile),
                                    fit: BoxFit.cover)),
                          ),
                          (yourRoomCardModel
                                  .yourRoomCardPeopleModels[index1].isMute && !isSubWidget)
                              ? Container(
                                  height: 16,
                                  width: 16,
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: AppConstants.clrWhite,
                                      shape: BoxShape.circle),
                                  child:
                                      Image.asset(AppConstants.ic_speaker_mute),
                                )
                              : Container()
                        ],
                      ),
                      Row(
                        children: [
                          (yourRoomCardModel
                                  .yourRoomCardPeopleModels[index1].isStar && !isSubWidget)
                              ? Container(
                                  height: 10,
                                  width: 10,
                                  margin: EdgeInsets.only(right: 4),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage(AppConstants.ic_star),
                                          fit: BoxFit.cover)),
                                )
                              : Container(),
                          Flexible(
                            child: TextWidget(
                                yourRoomCardModel
                                    .yourRoomCardPeopleModels[index1].name,
                                color: AppConstants.clrBlack,
                                fontSize: AppConstants.size_small_medium,
                                fontWeight: FontWeight.normal,
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis),
                            flex: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ],
      ));
}

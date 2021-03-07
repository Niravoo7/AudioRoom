import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/model/home_page_model.dart';
import 'package:flutter/cupertino.dart';

Widget cardWidgets(BuildContext context,PostListModel postListModel,bool disableNotificationIcon){
  double crossAxisSpacing = 10;
  double mainAxisSpacing = 10;
  double screenWidth = MediaQuery.of(context).size.width - 35;
  int crossAxisCount = 3;
  double width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
      crossAxisCount;
  double cellHeight = 36;
  double aspectRatio = width / cellHeight;
  return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppConstants.clrTransparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              width: 1,
              color: AppConstants.clrWidgetBGColor)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Image.asset(
                      AppConstants.ic_dark_home,
                      height: 18,
                      width: 18,
                      color: AppConstants.clrBlack,
                    ),
                  ),
                  TextWidget(postListModel.home,
                      color: AppConstants.clrBlack,
                      fontSize: AppConstants.size_small_medium,
                      fontWeight: FontWeight.normal),
                  disableNotificationIcon==true? Padding(
                    padding: EdgeInsets.only(left: 10, right: 8),
                    child: Image.asset(
                      AppConstants.ic_clock,
                      height: 18,
                      width: 18,
                      color: AppConstants.clrBlack,
                    ),
                  ):Container(),
                 disableNotificationIcon==true?   TextWidget('Tomorrow at 3:30 PM',
                      color: AppConstants.clrBlack,
                      fontSize: AppConstants.size_small_medium,
                      fontWeight: FontWeight.normal):Container(),
                ],
              ),
              disableNotificationIcon==true? Image.asset(
                AppConstants.ic_notification,
                height: 18,
                width: 18,
                color: AppConstants.clrBlack,
              ):Container(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 13),
            child: TextWidget(
                postListModel.detail,
                color: AppConstants.clrBlack,
                fontSize: AppConstants.size_medium_large,
                fontWeight: FontWeight.w600,
                maxLines: 2),
          ),
          GridView.builder(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: mainAxisSpacing,
                  childAspectRatio: aspectRatio),
              itemCount: postListModel.userListModel.length,
              itemBuilder: (context, index1) {
                return Row(
                  children: [
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(right: 5),
                        height: 33,
                        width: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                         // borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: AppConstants.clrTransparent,image: DecorationImage(image: AssetImage(postListModel.userListModel[index1].profile),fit: BoxFit.cover)),
                      ),
                    ),
                     Flexible(
                       child: TextWidget(postListModel.userListModel[index1].name,
                          color: AppConstants.clrBlack,
                          fontSize:
                          AppConstants.size_small_medium,
                          fontWeight: FontWeight.normal,textOverflow: TextOverflow.ellipsis),
                     ),
                  ],
                );
              }),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Image.asset(
                    AppConstants.ic_spiker,
                    height: 15,
                    width: 15,
                    color: AppConstants.clrBlack,
                  ),
                ),
                TextWidget(postListModel.spikerCounter,
                    color: AppConstants.clrBlack,
                    fontSize: AppConstants.size_small_medium,
                    fontWeight: FontWeight.normal),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8, left: 10),
                  child: Image.asset(
                    AppConstants.ic_user,
                    height: 15,
                    width: 15,
                    color: AppConstants.clrBlack,
                  ),
                ),
                TextWidget(postListModel.userCounter,
                    color: AppConstants.clrBlack,
                    fontSize: AppConstants.size_small_medium,
                    fontWeight: FontWeight.normal),
              ],
            ),
          )
        ],
      ));
}

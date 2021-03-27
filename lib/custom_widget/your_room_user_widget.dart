import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/firestore/model/user_model.dart';
import 'package:audioroom/firestore/network/user_fire.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class YourRoomUserWidget extends StatefulWidget {
  String uId;
  bool isSubWidget;
  bool isMute;
  bool isStar;

  YourRoomUserWidget({this.uId, this.isSubWidget, this.isMute, this.isStar});

  @override
  _YourRoomUserWidgetState createState() => _YourRoomUserWidgetState();
}

class _YourRoomUserWidgetState extends State<YourRoomUserWidget> {
  UserModel userModel;

  @override
  void initState() {
    super.initState();
    UserService().getUserByReferences(widget.uId).then((userModel) {
      if (userModel != null) {
        this.userModel = userModel;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userModel != null) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: (MediaQuery.of(context).size.width - 115) / 4,
                  width: (MediaQuery.of(context).size.width - 115) / 4,
                  margin: EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: AppConstants.clrGrey,
                      image: DecorationImage(
                          image: NetworkImage(userModel.imageUrl),
                          fit: BoxFit.cover)),
                ),
                (!widget.isSubWidget && widget.isMute)
                    ? Container(
                        height: 16,
                        width: 16,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: AppConstants.clrWhite,
                            shape: BoxShape.circle),
                        child: Image.asset(AppConstants.ic_speaker_mute),
                      )
                    : Container()
              ],
            ),
            Row(
              children: [
                (!widget.isSubWidget && widget.isStar)
                    ? Container(
                        height: 10,
                        width: 10,
                        margin: EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppConstants.ic_star),
                                fit: BoxFit.cover)),
                      )
                    : Container(),
                Flexible(
                  child: TextWidget(
                      userModel.firstName + " " + userModel.lastName,
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
    } else {
      return Container();
    }
  }
}

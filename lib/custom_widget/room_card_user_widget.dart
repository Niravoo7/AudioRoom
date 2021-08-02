import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/firestore/model/user_model.dart';
import 'package:audioroom/firestore/network/user_fire.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/print_log.dart';
import 'package:flutter/cupertino.dart';


// ignore: must_be_immutable
class RoomCardUserWidget extends StatefulWidget {
  String uId;

  RoomCardUserWidget({this.uId});

  @override
  _RoomCardUserWidgetState createState() => _RoomCardUserWidgetState();
}

class _RoomCardUserWidgetState extends State<RoomCardUserWidget> {
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
      PrintLog.printMessage("if " + widget.uId);
      return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: AppConstants.clrGrey,
                  image: DecorationImage(
                      image: NetworkImage(userModel.imageUrl),
                      fit: BoxFit.cover)),
            ),
            Flexible(
              child: TextWidget(userModel.firstName + " " + userModel.lastName,
                  color: AppConstants.clrBlack,
                  fontSize: AppConstants.size_small_medium,
                  fontWeight: FontWeight.normal,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis),
              flex: 1,
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}

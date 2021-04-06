import 'dart:async';
import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:audioroom/custom_widget/room_appbar.dart';
import 'package:audioroom/custom_widget/search_input_field.dart';
import 'package:audioroom/custom_widget/text_widget.dart';
import 'package:audioroom/custom_widget/flexible_widget.dart';
import 'package:audioroom/custom_widget/switch_widget.dart';
import 'package:audioroom/custom_widget/raise_hand_widget.dart';
import 'package:audioroom/custom_widget/club_invite_widget.dart';
import 'package:audioroom/custom_widget/your_room_user_widget.dart';
import 'package:audioroom/firestore/model/club_model.dart';
import 'package:audioroom/firestore/model/room_model.dart';
import 'package:audioroom/firestore/network/club_fire.dart';
import 'package:audioroom/firestore/network/room_fire.dart';
import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/print_log.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:audioroom/model/icon_model.dart';
import 'package:audioroom/model/your_room_card_model.dart';
import 'package:audioroom/network_api/rest_api.dart';
import 'package:audioroom/network_api/rest_url.dart';
import 'package:audioroom/network_api/model/token_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../firestore/model/notification_model.dart';
import '../../../firestore/network/notification_fire.dart';
import '../../../helper/constants.dart';

// ignore: must_be_immutable
class YourRoomScreen extends StatefulWidget {
  StartRoomModel startRoomModel;

  YourRoomScreen(this.startRoomModel);

  @override
  _YourRoomScreenState createState() => _YourRoomScreenState();
}

class _YourRoomScreenState extends State<YourRoomScreen>
    implements ApisInterface {
  final _infoStrings = <String>[];
  RtcEngine _engine;
  Apis _apis;
  bool isUpdateToken = false;
  bool isFirst = true;

  Timer timer;

  RoomModel roomModelLive;
  ClubModel clubModel;

  List<IconModel> icons = [];
  bool isRaisedHand = true;
  bool icListBottomSheetVisible = false;
  bool icAddUserBottomSheetVisible = false;
  bool icSpeakerBottomSheetVisible = false;

  bool isLock = false;

  TextEditingController titleController = new TextEditingController();

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    PrintLog.printMessage(
        "YourRoomScreen count -> ${widget.startRoomModel.roomType} ${widget.startRoomModel.roomName} ${widget.startRoomModel.roomDesc} ${widget.startRoomModel.roomModel}");
    /*for (int i = 0; i < widget.startRoomModel.peopleList.length; i++) {
      PrintLog.printMessage(
          "YourRoomScreen count -> $i ${widget.startRoomModel.peopleList[i]}");
    }*/

    _apis = new Apis(this);
    if (widget.startRoomModel.roomModel == null ||
        widget.startRoomModel.roomModel.broadcaster
            .contains(FirebaseAuth.instance.currentUser.uid) ||
        widget.startRoomModel.roomModel.moderator
            .contains(FirebaseAuth.instance.currentUser.uid)) {
      PrintLog.printMessage("YourRoomScreen count -> if");
      icons.add(new IconModel(AppConstants.ic_list, false));
      icons.add(new IconModel(AppConstants.ic_add_user, false));
      icons.add(new IconModel(AppConstants.ic_speaker, true));
      roomModelLive = new RoomModel();
      if (widget.startRoomModel.roomModel == null) {
        roomModelLive.channelName =
            widget.startRoomModel.roomName.toLowerCase().replaceAll(" ", "_");

        initToken();
      } else {
        roomModelLive.channelName = widget.startRoomModel.roomModel.roomName
            .toLowerCase()
            .replaceAll(" ", "_");
        roomModelLive = widget.startRoomModel.roomModel;
        initialize(widget.startRoomModel.roomModel.channelToken);
      }
    } else {
      PrintLog.printMessage("YourRoomScreen count -> else");

      icons.add(new IconModel(AppConstants.ic_raise_hand, false));
      icons.add(new IconModel(AppConstants.ic_speaker, false));

      roomModelLive = widget.startRoomModel.roomModel;
      initialize(widget.startRoomModel.roomModel.channelToken);
    }

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      RoomService()
          .getRoomByReferences(roomModelLive.channelName)
          .then((value) {
        if (value != null) {
          this.roomModelLive = value;
          setState(() {});
        }
      });
    });
  }

  void initToken() {
    var _data = {"uid": "0", "channelName": roomModelLive.channelName};
    var _body = json.encode(_data);
    _apis.onApis(RestUrl.URLGenerateToken, ApisType.post,
        headers: {"Content-Type": "application/json"}, body: _body);
  }

  void initRoomModel(String token) {
    if (widget.startRoomModel.roomModel == null) {
      if (!widget.startRoomModel.peopleList
          .contains(FirebaseAuth.instance.currentUser.uid)) {
        widget.startRoomModel.peopleList
            .add(FirebaseAuth.instance.currentUser.uid);
      }
      roomModelLive = new RoomModel(
          clubName: widget.startRoomModel.roomName,
          createDatetime: DateTime.now(),
          createrUid: FirebaseAuth.instance.currentUser.uid,
          isRoomLock: false,
          channelName:
              widget.startRoomModel.roomName.toLowerCase().replaceAll(" ", "_"),
          roomDesc: widget.startRoomModel.roomDesc,
          roomType: widget.startRoomModel.roomType,
          people: (widget.startRoomModel.roomType == "Global")
              ? null
              : widget.startRoomModel.peopleList,
          roomName: widget.startRoomModel.roomName,
          raiseHand: [],
          moderator: [],
          broadcaster: [FirebaseAuth.instance.currentUser.uid],
          mutePeople: [],
          audiance: [],
          hidePeople: [],
          channelToken: token);

      if (widget.startRoomModel.roomType != "Global") {
        for (int i = 0; i < widget.startRoomModel.peopleList.length; i++) {
          NotificationModel notificationModel = new NotificationModel(
              uId: widget.startRoomModel.peopleList[i],
              notificationType: "room",
              description:
                  "You are joined in ${widget.startRoomModel.roomName} room",
              imageUrl: AppConstants.str_image_url,
              createDatetime: DateTime.now(),
              title: "Room joined");
          NotificationService().createNotification(notificationModel);
        }
      }

      PrintLog.printMessage("roomModel 1 -> ${roomModelLive.toJson()}");

      RoomService().createRoom(roomModelLive).then((value) {
        if (value != null) {
          setState(() {
            initialize(token);
          });
        } else {
          Navigator.of(context).pop();
        }
      });
    } else {
      roomModelLive = widget.startRoomModel.roomModel;
    }
  }

  Future<void> initialize(String token) async {
    //print("nirav -> ${roomModelLive.channelName} ${AppConstants.var_APP_ID} $token ");
    //showToast("Success  ${widget.channelName}  $token");

    PrintLog.printMessage("roomModel 2 -> ${roomModelLive.toJson()}");
    ClubService()
        .getClubByReferences(
            roomModelLive.clubName.toLowerCase().replaceAll(" ", "_"))
        .then((value) {
      if (value != null) {
        this.clubModel = value;
      }
    });

    if (AppConstants.var_APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    if (!isUpdateToken) {
      PrintLog.printMessage("initialize -> 3");
    } else {
      PrintLog.printMessage("initialize -> 2");
      roomModelLive.channelToken = token;
      RoomService().updateRoom(roomModelLive);
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    // ignore: deprecated_member_use
    await _engine.enableWebSdkInteroperability(true);
    await _engine.joinChannel(token, roomModelLive.channelName, null, 0);
    if (!roomModelLive.broadcaster
            .contains(FirebaseAuth.instance.currentUser.uid) &&
        !roomModelLive.moderator
            .contains(FirebaseAuth.instance.currentUser.uid)) {
      _engine.muteLocalAudioStream(false);
    }
  }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(AppConstants.var_APP_ID);
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      final info = 'onError: $code';
      _infoStrings.add(info);
      _infoStrings.clear();
      isUpdateToken = true;
      _engine.leaveChannel();
      _engine.destroy();
      initToken();
    }, joinChannelSuccess: (channel, uid, elapsed) async {
      if (roomModelLive.createrUid != FirebaseAuth.instance.currentUser.uid &&
          !roomModelLive.broadcaster
              .contains(FirebaseAuth.instance.currentUser.uid) &&
          !roomModelLive.moderator
              .contains(FirebaseAuth.instance.currentUser.uid)) {
        if (!roomModelLive.audiance
            .contains(FirebaseAuth.instance.currentUser.uid)) {
          roomModelLive.audiance.add(FirebaseAuth.instance.currentUser.uid);
          roomModelLive.people.remove(FirebaseAuth.instance.currentUser.uid);
          RoomService().updateRoom(roomModelLive);
        }
      }
      setState(() {});
      /*audioRoomUserModel = new AudioRoomUserModel(
          isLeave: false,
          uid: await SharePref.prefGetString(SharePref.keyUserId, ""),
          userRoomId: uid,
          userName: await SharePref.prefGetString(SharePref.keyUserName, ""));
      String refId = await AudioRoomUsersService()
          .createAudioRoomUser(widget.channelRefID, audioRoomUserModel);
      audioRoomUserModel.refId = refId;
      setState(() {
        final info = 'You Joined';
        _infoStrings.add(info);
      });*/
    }, leaveChannel: (stats) {
      setState(() {});
      if (roomModelLive.createrUid != FirebaseAuth.instance.currentUser.uid) {
        roomModelLive.audiance.remove(FirebaseAuth.instance.currentUser.uid);
        if (roomModelLive.people != null &&
            !roomModelLive.people
                .contains(FirebaseAuth.instance.currentUser.uid)) {
          roomModelLive.people.add(FirebaseAuth.instance.currentUser.uid);
        }
        RoomService().updateRoom(roomModelLive);
      }
      /*audioRoomUserModel.isLeave = true;
      AudioRoomUsersService()
          .updateAudioRoomUser(widget.channelRefID, audioRoomUserModel);
      setState(() {
        _infoStrings.add('You Leaved');
      });*/
    }, userJoined: (uid, elapsed) async {
      setState(() {});
      /*PrintLog.printMessage(" Joined  $uid");
      String userName = await AudioRoomUsersService()
          .getUserNameFromUSerRoomId(widget.channelRefID, uid);
      setState(() {
        final info = '$userName Joined';
        _infoStrings.add(info);
      });*/
    }, userOffline: (uid, elapsed) async {
      setState(() {});
      /*String userName = await AudioRoomUsersService()
          .getUserNameFromUSerRoomId(widget.channelRefID, uid);
      setState(() {
        final info = '$userName Leaved';
        _infoStrings.add(info);
      });*/
    }));
  }

  Future<void> onBackPress() async {
    timer.cancel();
    if (roomModelLive.createrUid == FirebaseAuth.instance.currentUser.uid) {
      //RoomService().deleteRoom(roomModelLive.roomName.toLowerCase().replaceAll(" ", "_"));
    } else {
      roomModelLive.audiance.remove(FirebaseAuth.instance.currentUser.uid);

      if (roomModelLive.people != null &&
          !roomModelLive.people
              .contains(FirebaseAuth.instance.currentUser.uid)) {
        roomModelLive.people.add(FirebaseAuth.instance.currentUser.uid);
      }
      RoomService().updateRoom(roomModelLive);
      setState(() {});
    }
    Navigator.of(context).pop();
    await _engine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    double crossAxisSpacing = 16;
    double mainAxisSpacing = 16;
    double screenWidth = MediaQuery.of(context).size.width - 35;
    int crossAxisCount = 4;
    double width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    double cellHeight = ((MediaQuery.of(context).size.width - 115) / 4) + 35;
    double aspectRatio = width / cellHeight;

    return WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          onBackPress();
        },
        child: Scaffold(
            appBar:
                RoomAppBar(context, AppConstants.str_all_rooms, onBackPress),
            body: SafeArea(
                child: Container(
                    color: AppConstants.clrTitleBG,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      StreamBuilder(
                          stream: RoomService().getRoomByReferencesStream(
                              roomModelLive.channelName),
                          builder: (context, roomModelTemp) {
                            if (roomModelTemp.hasError) {
                              return Center(
                                  child: TextWidget(
                                      roomModelTemp.error.toString(),
                                      color: AppConstants.clrBlack,
                                      fontSize: 20));
                            }

                            if (roomModelTemp == null ||
                                roomModelTemp.data == 0) {
                              return Container();
                            } else {
                              RoomModel roomModel = roomModelTemp.data;
                              if (roomModel != null) {
                                return ListView(children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 16, right: 16, top: 16),
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          color: AppConstants.clrTransparent,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              width: 1,
                                              color: AppConstants
                                                  .clrWidgetBGColor)),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: Image.asset(
                                                    AppConstants.ic_dark_home,
                                                    height: 14,
                                                    width: 14,
                                                    color:
                                                        AppConstants.clrBlack,
                                                  ),
                                                ),
                                                TextWidget(roomModel.roomName,
                                                    color:
                                                        AppConstants.clrBlack,
                                                    fontSize: AppConstants
                                                        .size_small_medium,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8, left: 16),
                                                  child: Image.asset(
                                                    AppConstants.ic_speaker,
                                                    height: 10,
                                                    width: 10,
                                                    color:
                                                        AppConstants.clrBlack,
                                                  ),
                                                ),
                                                TextWidget(
                                                    roomModel.broadcaster.length
                                                        .toString(),
                                                    color:
                                                        AppConstants.clrBlack,
                                                    fontSize: AppConstants
                                                        .size_small_medium,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                FlexibleWidget(1),
                                                (roomModelLive.createrUid ==
                                                        FirebaseAuth.instance
                                                            .currentUser.uid)
                                                    ? GestureDetector(
                                                        child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 8),
                                                            child: Image.asset(
                                                                AppConstants
                                                                    .ic_edit,
                                                                height: 22,
                                                                width: 22,
                                                                color: AppConstants
                                                                    .clrBlack)),
                                                        onTap: () {
                                                          inputTextDialogue();
                                                        },
                                                      )
                                                    : Container(),
                                                (roomModelLive.createrUid ==
                                                        FirebaseAuth.instance
                                                            .currentUser.uid)
                                                    ? GestureDetector(
                                                        child: Container(
                                                            child: Image.asset(
                                                                AppConstants
                                                                    .ic_lock,
                                                                height: 22,
                                                                width: 22,
                                                                color: (isLock)
                                                                    ? AppConstants
                                                                        .clrPrimary
                                                                    : AppConstants
                                                                        .clrBlack)),
                                                        onTap: () {
                                                          isLock = !isLock;
                                                          setState(() {});
                                                          roomModelLive
                                                                  .isRoomLock =
                                                              isLock;
                                                          RoomService()
                                                              .updateRoom(
                                                                  roomModelLive);
                                                        },
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(top: 8),
                                              child: TextWidget(
                                                  roomModel.roomDesc,
                                                  color: AppConstants.clrBlack,
                                                  fontSize: AppConstants
                                                      .size_medium_large,
                                                  fontWeight: FontWeight.w600,
                                                  maxLines: 2),
                                            ),
                                            GridView.builder(
                                                padding:
                                                    EdgeInsets.only(top: 8),
                                                shrinkWrap: true,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount:
                                                            crossAxisCount,
                                                        crossAxisSpacing:
                                                            crossAxisSpacing,
                                                        mainAxisSpacing:
                                                            mainAxisSpacing,
                                                        childAspectRatio:
                                                            aspectRatio),
                                                itemCount: roomModel
                                                        .broadcaster.length +
                                                    roomModel.moderator.length,
                                                itemBuilder: (context, index) {
                                                  if (roomModel
                                                          .broadcaster.length <=
                                                      index) {
                                                    return YourRoomUserWidget(
                                                      uId: roomModel.moderator[
                                                          index -
                                                              roomModel
                                                                  .broadcaster
                                                                  .length],
                                                      isSubWidget: false,
                                                      isMute: roomModel
                                                              .mutePeople
                                                              .where((element) => (element ==
                                                                  roomModel.moderator[index -
                                                                      roomModel
                                                                          .broadcaster
                                                                          .length]))
                                                              .toList()
                                                              .length >
                                                          0,
                                                      isStar: false,
                                                    );
                                                  } else {
                                                    return YourRoomUserWidget(
                                                      uId: roomModel
                                                          .broadcaster[index],
                                                      isSubWidget: false,
                                                      isMute: roomModel
                                                              .mutePeople
                                                              .where((element) =>
                                                                  (element ==
                                                                      roomModel
                                                                              .broadcaster[
                                                                          index]))
                                                              .toList()
                                                              .length >
                                                          0,
                                                      isStar: true,
                                                    );
                                                  }
                                                })
                                          ])),
                                  (roomModel.audiance.length != null &&
                                          roomModel.audiance.length != 0)
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              left: 16, right: 16, top: 16),
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              color:
                                                  AppConstants.clrTransparent,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppConstants
                                                      .clrWidgetBGColor)),
                                          child: Column(children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: Image.asset(
                                                    AppConstants.ic_speaker,
                                                    height: 10,
                                                    width: 10,
                                                    color:
                                                        AppConstants.clrBlack,
                                                  ),
                                                ),
                                                TextWidget(
                                                    roomModel.audiance.length
                                                        .toString(),
                                                    color:
                                                        AppConstants.clrBlack,
                                                    fontSize: AppConstants
                                                        .size_small_medium,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                FlexibleWidget(1),
                                              ],
                                            ),
                                            GridView.builder(
                                                padding:
                                                    EdgeInsets.only(top: 8),
                                                shrinkWrap: true,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount:
                                                            crossAxisCount,
                                                        crossAxisSpacing:
                                                            crossAxisSpacing,
                                                        mainAxisSpacing:
                                                            mainAxisSpacing,
                                                        childAspectRatio:
                                                            aspectRatio),
                                                itemCount:
                                                    roomModel.audiance.length,
                                                itemBuilder: (context, index) {
                                                  return YourRoomUserWidget(
                                                    uId: roomModel
                                                        .audiance[index],
                                                    isSubWidget: true,
                                                    isMute: null,
                                                    isStar: null,
                                                  );
                                                })
                                          ]))
                                      : Container()
                                ]);
                              } else {
                                return Container();
                              }
                            }
                          }),
                      Container(),
                      (icListBottomSheetVisible)
                          ? icListBottomSheet()
                          : Container(),
                      (icAddUserBottomSheetVisible)
                          ? icAddUserBottomSheet()
                          : Container(),
                      (icSpeakerBottomSheetVisible)
                          ? icSpeakerBottomSheet()
                          : Container(),
                      Container(
                          height: 68,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: AppConstants.clrWhite,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              border: Border.all(
                                  color: AppConstants.clrSearchBG, width: 1)),
                          child: Row(children: [
                            GestureDetector(
                                child: Container(
                                    height: 36,
                                    decoration: BoxDecoration(
                                        color: AppConstants.clrTransparent,
                                        border: Border.all(
                                            color: AppConstants.clrPrimary,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              right: 8, left: 28),
                                          child: Image.asset(
                                            AppConstants.ic_leave_group,
                                            height: 17,
                                            color: AppConstants.clrPrimary,
                                          )),
                                      TextWidget(AppConstants.str_leave_quietly,
                                          color: AppConstants.clrPrimary,
                                          fontSize:
                                              AppConstants.size_small_medium,
                                          fontWeight: FontWeight.normal),
                                      SizedBox(width: 28)
                                    ])),
                                onTap: onBackPress),
                            FlexibleWidget(1),
                            Container(
                                height: 36,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: icons.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(
                                                top: 8, bottom: 8, left: 20),
                                            child: Image.asset(
                                              icons[index].icon,
                                              height: 20,
                                              color: icons[index].isDark
                                                  ? AppConstants.clrPrimary
                                                  : AppConstants.clrBlack,
                                            ),
                                          ),
                                          onTap: () {
                                            switch (icons[index].icon) {
                                              case AppConstants.ic_list:
                                                PrintLog.printMessage(
                                                    "ic_list");

                                                /*RoomService().getRoomByReferences(roomModelLive.channelName).then((value) {
                                              if(value!=null)
                                                {
                                                  this.roomModelLive=value;
                                                }
                                            });*/

                                                icListBottomSheetVisible =
                                                    !icListBottomSheetVisible;
                                                icAddUserBottomSheetVisible =
                                                    false;
                                                icSpeakerBottomSheetVisible =
                                                    false;
                                                icons[index].isDark =
                                                    !icons[index].isDark;
                                                setState(() {});
                                                /*showBarModalBottomSheet(
                                                  expand: true,
                                                  context: context,
                                                  backgroundColor: Colors.transparent,
                                                  builder: (context) =>
                                                      icListBottomSheet(),
                                                );*/
                                                break;
                                              case AppConstants.ic_add_user:
                                                PrintLog.printMessage(
                                                    "ic_add_user");

                                                icListBottomSheetVisible =
                                                    false;
                                                icAddUserBottomSheetVisible =
                                                    !icAddUserBottomSheetVisible;
                                                icSpeakerBottomSheetVisible =
                                                    false;
                                                icons[index].isDark =
                                                    !icons[index].isDark;
                                                setState(() {});
                                                break;
                                              case AppConstants.ic_speaker:
                                                PrintLog.printMessage(
                                                    "ic_speaker  ${roomModelLive.moderator.contains(FirebaseAuth.instance.currentUser.uid)}  ${roomModelLive.broadcaster.contains(FirebaseAuth.instance.currentUser.uid)}  ${!roomModelLive.mutePeople.contains(FirebaseAuth.instance.currentUser.uid)}");
                                                /*icListBottomSheetVisible = false;
                                            icAddUserBottomSheetVisible = false;
                                            icSpeakerBottomSheetVisible =
                                                !icSpeakerBottomSheetVisible;
                                            setState(() {});*/
                                                if ((roomModelLive.moderator
                                                            .contains(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser
                                                                    .uid) ||
                                                        roomModelLive
                                                            .broadcaster
                                                            .contains(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser
                                                                    .uid)) &&
                                                    !roomModelLive.mutePeople
                                                        .contains(FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            .uid)) {
                                                  icons[index].isDark =
                                                      !icons[index].isDark;
                                                  PrintLog.printMessage(
                                                      "ic_speaker  ${!icons[index].isDark}");
                                                  _engine.muteLocalAudioStream(
                                                      !icons[index].isDark);
                                                  setState(() {});
                                                }

                                                break;

                                              case AppConstants.ic_raise_hand:
                                                PrintLog.printMessage(
                                                    "ic_raise_hand");
                                                if (!icons[index].isDark) {
                                                  if (!roomModelLive.raiseHand
                                                      .contains(FirebaseAuth
                                                          .instance
                                                          .currentUser
                                                          .uid)) {
                                                    roomModelLive.raiseHand.add(
                                                        FirebaseAuth.instance
                                                            .currentUser.uid);
                                                  }
                                                } else {
                                                  roomModelLive.raiseHand
                                                      .remove(FirebaseAuth
                                                          .instance
                                                          .currentUser
                                                          .uid);
                                                }
                                                icons[index].isDark =
                                                    !icons[index].isDark;
                                                RoomService()
                                                    .updateRoom(roomModelLive);

                                                setState(() {});
                                                break;
                                            }
                                          });
                                    }))
                          ]))
                    ])))));
  }

  @override
  void onError(String url, int responseCode, String errorMessage, response) {
    showToast("error -> " + errorMessage);
    PrintLog.printMessage("responseCode -> " + responseCode.toString());
    PrintLog.printMessage("error Message -> " + errorMessage.toString());
    PrintLog.printMessage("error response -> " + response.toString());
  }

  @override
  Future<void> onSuccess(String url, response) async {
    PrintLog.printMessage("success url -> " + url.toString());
    PrintLog.printMessage("success response -> " + response.body.toString());
    TokenModel tokenModel = TokenModel.fromJson(jsonDecode(response.body));
    PrintLog.printMessage(
        "success response -> " + tokenModel.toJson().toString());

    if ((widget.startRoomModel.roomModel == null) && isFirst) {
      initRoomModel(tokenModel.data.token);
      isFirst = false;
    }
  }

  Widget icListBottomSheet() {
    return Container(
        padding: EdgeInsets.only(bottom: 66),
        decoration: BoxDecoration(
            color: AppConstants.clrWhite,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            border: Border.all(color: AppConstants.clrSearchBG, width: 1)),
        child: Wrap(children: [
          Container(
              padding: EdgeInsets.all(16),
              child: Row(children: [
                TextWidget(AppConstants.str_people_who_raised_hand,
                    color: AppConstants.clrBlack,
                    fontSize: AppConstants.size_medium_large,
                    fontWeight: FontWeight.bold),
                FlexibleWidget(1),
                SwitchWidget(isRaisedHand, () {
                  isRaisedHand = !isRaisedHand;
                  setState(() {});
                })
              ])),
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              itemCount: roomModelLive.raiseHand.length,
              itemBuilder: (BuildContext context, int index) {
                return RaiseHandWidget(roomModelLive.raiseHand[index], () {
                  PrintLog.printMessage("RaiseHandWidget -> ");
                  roomModelLive.audiance.remove(roomModelLive.raiseHand[index]);
                  if (!roomModelLive.moderator
                      .contains(roomModelLive.raiseHand[index])) {
                    roomModelLive.moderator.add(roomModelLive.raiseHand[index]);
                  }
                  roomModelLive.raiseHand
                      .remove(roomModelLive.raiseHand[index]);
                  RoomService().updateRoom(roomModelLive);
                  setState(() {});
                });
              })
        ]));
  }

  Widget icAddUserBottomSheet() {
    return Container(
        padding: EdgeInsets.only(bottom: 66),
        decoration: BoxDecoration(
            color: AppConstants.clrWhite,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            border: Border.all(color: AppConstants.clrSearchBG, width: 1)),
        child: Wrap(children: [
          Container(
            padding: EdgeInsets.all(16),
            child: TextWidget(AppConstants.str_invite_people,
                color: AppConstants.clrBlack,
                fontSize: AppConstants.size_medium_large,
                fontWeight: FontWeight.bold),
          ),
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              itemCount: clubModel.userList.length,
              itemBuilder: (BuildContext context, int index) {
                if (clubModel.userList[index] ==
                    FirebaseAuth.instance.currentUser.uid) {
                  return Container();
                } else {
                  return ClubInviteWidget(clubModel.userList[index],
                      roomModelLive.people.contains(clubModel.userList[index]),
                      (isInvited) {
                    if (isInvited) {
                      if (roomModelLive.people != null &&
                          !roomModelLive.people
                              .contains(clubModel.userList[index])) {
                        roomModelLive.people.add(clubModel.userList[index]);
                        RoomService().updateRoom(roomModelLive);
                        setState(() {});
                      }
                    }
                  });
                }
              })
        ]));
  }

  Widget icSpeakerBottomSheet() {
    return Container(
        padding: EdgeInsets.only(bottom: 70, top: 16, left: 16, right: 16),
        decoration: BoxDecoration(
            color: AppConstants.clrWhite,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            border: Border.all(color: AppConstants.clrSearchBG, width: 1)),
        child: Wrap(children: [
          Row(children: [
            Container(
                height: 66,
                width: 66,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: AppConstants.clrProfileBG,
                    image: DecorationImage(
                        image: NetworkImage(AppConstants.str_image_url),
                        fit: BoxFit.fill),
                    shape: BoxShape.circle)),
            Flexible(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  TextWidget("Sera Scholfield",
                      color: AppConstants.clrBlack,
                      fontSize: AppConstants.size_medium_large,
                      fontWeight: FontWeight.bold),
                  TextWidget("@serafield",
                      color: AppConstants.clrBlack,
                      fontSize: AppConstants.size_small_medium,
                      fontWeight: FontWeight.w400),
                ]))
          ]),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              GestureDetector(
                  onTap: () {},
                  child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        TextWidget("501",
                            color: AppConstants.clrBlack,
                            fontSize: AppConstants.size_medium,
                            fontWeight: FontWeight.bold),
                        TextWidget(
                          AppConstants.str_followers,
                          color: AppConstants.clrBlack,
                          fontSize: AppConstants.size_medium,
                          fontWeight: FontWeight.w400,
                        )
                      ]))),
              SizedBox(width: 16),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        TextWidget("38",
                            color: AppConstants.clrBlack,
                            fontSize: AppConstants.size_medium,
                            fontWeight: FontWeight.bold),
                        TextWidget(
                          AppConstants.str_following,
                          color: AppConstants.clrBlack,
                          fontSize: AppConstants.size_medium,
                          fontWeight: FontWeight.w400,
                        )
                      ]))),
              SizedBox(width: 16),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        TextWidget("12",
                            color: AppConstants.clrBlack,
                            fontSize: AppConstants.size_medium,
                            fontWeight: FontWeight.bold),
                        TextWidget(
                          AppConstants.str_clubs_joined,
                          color: AppConstants.clrBlack,
                          fontSize: AppConstants.size_medium,
                          fontWeight: FontWeight.w400,
                        )
                      ])))
            ]),
          ),
          Container(
            height: 44,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppConstants.clrPrimary,
                borderRadius: BorderRadius.circular(10)),
            child: TextWidget(AppConstants.str_make_a_speaker,
                color: AppConstants.clrWhite,
                fontSize: AppConstants.size_medium_large,
                fontWeight: FontWeight.bold),
          ),
          Container(
            height: 44,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppConstants.clrWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppConstants.clrPrimary, width: 1)),
            child: TextWidget(AppConstants.str_move_to_audience,
                color: AppConstants.clrPrimary,
                fontSize: AppConstants.size_medium_large,
                fontWeight: FontWeight.bold),
          ),
          Container(
            height: 44,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppConstants.clrWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppConstants.clrPrimary, width: 1)),
            child: TextWidget(AppConstants.str_view_full_profile,
                color: AppConstants.clrPrimary,
                fontSize: AppConstants.size_medium_large,
                fontWeight: FontWeight.bold),
          )
        ]));
  }

  void inputTextDialogue() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)), //this right here
            child: Container(
              child: Wrap(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    child: SearchInputField(
                        AppConstants.str_write_a_title_for_the_conversation,
                        titleController,
                        false,
                        (text) {}),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: AppConstants.clrGrey, width: 1)),
                            child: TextWidget(AppConstants.str_ok,
                                fontSize: AppConstants.size_text_medium,
                                color: AppConstants.clrBlack),
                          ),
                          onTap: () {
                            roomModelLive.roomDesc = titleController.text;
                            RoomService().updateRoom(roomModelLive);
                            Navigator.of(ctx).pop();
                          },
                        ),
                      ),
                      Flexible(
                        child: GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: AppConstants.clrGrey, width: 1)),
                            child: TextWidget(AppConstants.str_cancle,
                                fontSize: AppConstants.size_text_medium,
                                color: AppConstants.clrBlack),
                          ),
                          onTap: () {
                            Navigator.of(ctx).pop();
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

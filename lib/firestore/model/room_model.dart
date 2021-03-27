import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

RoomModel roomModelFromJson(String str) => RoomModel.fromJson(json.decode(str));

String roomModelToJson(RoomModel data) => json.encode(data.toJson());

class RoomModel {
  RoomModel({
    this.moderator,
    this.broadcaster,
    this.audiance,
    this.createDatetime,
    this.roomDesc,
    this.createrUid,
    this.roomName,
    this.clubName,
    this.channelName,
    this.roomType,
    this.channelToken,
    this.isRoomLock,
    this.people,
    this.raiseHand,
    this.mutePeople,
    this.hidePeople,
  });

  String refId;
  List<String> moderator;
  List<String> broadcaster;
  List<String> audiance;
  DateTime createDatetime;
  String roomDesc;
  String createrUid;
  String roomName;
  String clubName;
  String channelName;
  String roomType;
  String channelToken;
  bool isRoomLock;
  List<String> people;
  List<String> raiseHand;
  List<String> mutePeople;
  List<String> hidePeople;

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
        moderator: json["moderator"] == null
            ? null
            : List<String>.from(json["moderator"].map((x) => x)),
        broadcaster: json["broadcaster"] == null
            ? null
            : List<String>.from(json["broadcaster"].map((x) => x)),
        audiance: json["audiance"] == null
            ? null
            : List<String>.from(json["audiance"].map((x) => x)),
        createDatetime: json["create_datetime"] != null
            ? (json["create_datetime"] is String)
                ? (json["create_datetime"] != "")
                    ? DateTime.parse(json["create_datetime"])
                    : null
                : json["create_datetime"].toDate()
            : null,
        roomDesc: json["room_desc"] == null ? null : json["room_desc"],
        createrUid: json["creater_uid"] == null ? null : json["creater_uid"],
        roomName: json["room_name"] == null ? null : json["room_name"],
        clubName: json["club_name"] == null ? null : json["club_name"],
        channelName: json["channel_name"] == null ? null : json["channel_name"],
        roomType: json["room_type"] == null ? null : json["room_type"],
        channelToken: json["channel_token"] == null ? null : json["channel_token"],
        isRoomLock: json["is_room_lock"] == null ? null : json["is_room_lock"],
        people: json["people"] == null
            ? null
            : List<String>.from(json["people"].map((x) => x)),
        raiseHand: json["raise_hand"] == null
            ? null
            : List<String>.from(json["raise_hand"].map((x) => x)),
        mutePeople: json["mute_people"] == null
            ? null
            : List<String>.from(json["mute_people"].map((x) => x)),
        hidePeople: json["hide_people"] == null
            ? null
            : List<String>.from(json["hide_people"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "moderator": moderator == null
            ? null
            : List<dynamic>.from(moderator.map((x) => x)),
        "broadcaster": broadcaster == null
            ? null
            : List<dynamic>.from(broadcaster.map((x) => x)),
        "audiance": audiance == null
            ? null
            : List<dynamic>.from(audiance.map((x) => x)),
        "create_datetime":
            (createDatetime != null) ? createDatetime.toString() : null,
        "room_desc": roomDesc == null ? null : roomDesc,
        "creater_uid": createrUid == null ? null : createrUid,
        "room_name": roomName == null ? null : roomName,
        "club_name": clubName == null ? null : clubName,
        "channel_name": channelName == null ? null : channelName,
        "room_type": roomType == null ? null : roomType,
        "channel_token": channelToken == null ? null : channelToken,
        "is_room_lock": isRoomLock == null ? null : isRoomLock,
        "people":
            people == null ? null : List<dynamic>.from(people.map((x) => x)),
        "raise_hand": raiseHand == null
            ? null
            : List<dynamic>.from(raiseHand.map((x) => x)),
        "mute_people": mutePeople == null
            ? null
            : List<dynamic>.from(mutePeople.map((x) => x)),
        "hide_people": hidePeople == null
            ? null
            : List<dynamic>.from(hidePeople.map((x) => x)),
      };

  Map<String, dynamic> toJsonTimeStamp() => {
        "moderator": moderator == null
            ? null
            : List<dynamic>.from(moderator.map((x) => x)),
        "broadcaster": broadcaster == null
            ? null
            : List<dynamic>.from(broadcaster.map((x) => x)),
        "audiance": audiance == null
            ? null
            : List<dynamic>.from(audiance.map((x) => x)),
        "create_datetime": (createDatetime != null)
            ? Timestamp.fromDate(createDatetime)
            : null,
        "room_desc": roomDesc == null ? null : roomDesc,
        "creater_uid": createrUid == null ? null : createrUid,
        "room_name": roomName == null ? null : roomName,
        "club_name": clubName == null ? null : clubName,
        "channel_name": channelName == null ? null : channelName,
        "room_type": roomType == null ? null : roomType,
        "channel_token": channelToken == null ? null : channelToken,
        "is_room_lock": isRoomLock == null ? null : isRoomLock,
        "people":
            people == null ? null : List<dynamic>.from(people.map((x) => x)),
        "raise_hand": raiseHand == null
            ? null
            : List<dynamic>.from(raiseHand.map((x) => x)),
        "mute_people": mutePeople == null
            ? null
            : List<dynamic>.from(mutePeople.map((x) => x)),
        "hide_people": hidePeople == null
            ? null
            : List<dynamic>.from(hidePeople.map((x) => x)),
      };
}

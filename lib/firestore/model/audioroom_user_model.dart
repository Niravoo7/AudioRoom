import 'dart:convert';

AudioRoomUserModel audioRoomUserModelFromJson(String str) =>
    AudioRoomUserModel.fromJson(json.decode(str));

String audioRoomUserModelToJson(AudioRoomUserModel data) =>
    json.encode(data.toJson());

class AudioRoomUserModel {
  AudioRoomUserModel({
    this.userName,
    this.uid,
    this.userRoomId,
    this.isLeave,
  });

  String userName;
  String uid;
  int userRoomId;
  bool isLeave;
  String refId;

  factory AudioRoomUserModel.fromJson(Map<String, dynamic> json) =>
      AudioRoomUserModel(
        userName: json["user_name"] == null ? null : json["user_name"],
        uid: json["uid"] == null ? null : json["uid"],
        userRoomId: json["user_room_id"] == null ? null : json["user_room_id"],
        isLeave: json["is_leave"] == null ? null : json["is_leave"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName == null ? null : userName,
        "uid": uid == null ? null : uid,
        "user_room_id": userRoomId == null ? null : userRoomId,
        "is_leave": isLeave == null ? null : isLeave,
      };
}

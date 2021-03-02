import 'dart:convert';

AudioRoomModel audioRoomModelFromJson(String str) =>
    AudioRoomModel.fromJson(json.decode(str));

String audioRoomModelToJson(AudioRoomModel data) => json.encode(data.toJson());

class AudioRoomModel {
  AudioRoomModel({
    this.channelDelete,
    this.channelToken,
    this.channelName,
    this.channelIcon,
    this.createdUid,
  });

  bool channelDelete;
  String channelToken;
  String channelName;
  String channelIcon;
  String createdUid;
  String refId;

  factory AudioRoomModel.fromJson(Map<String, dynamic> json) => AudioRoomModel(
        channelDelete:
            json["channel_delete"] == null ? null : json["channel_delete"],
        channelToken:
            json["channel_token"] == null ? null : json["channel_token"],
        channelName: json["channel_name"] == null ? null : json["channel_name"],
        channelIcon: json["channel_icon"] == null ? null : json["channel_icon"],
        createdUid: json["created_uid"] == null ? null : json["created_uid"],
      );

  Map<String, dynamic> toJson() => {
        "channel_delete": channelDelete == null ? null : channelDelete,
        "channel_token": channelToken == null ? null : channelToken,
        "channel_name": channelName == null ? null : channelName,
        "channel_icon": channelIcon == null ? null : channelIcon,
        "created_uid": createdUid == null ? null : createdUid,
      };
}

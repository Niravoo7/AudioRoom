import 'dart:convert';

FollowModel followModelFromJson(String str) =>
    FollowModel.fromJson(json.decode(str));

String followModelToJson(FollowModel data) => json.encode(data.toJson());

class FollowModel {
  FollowModel({
    this.followBy,
    this.status,
    this.followTo,
  });


  String refId;
  String followBy;
  int status;
  String followTo;

  factory FollowModel.fromJson(Map<String, dynamic> json) => FollowModel(
        followBy: json["follow_by"] == null ? null : json["follow_by"],
        status: json["status"] == null ? null : json["status"],
        followTo: json["follow_to"] == null ? null : json["follow_to"],
      );

  Map<String, dynamic> toJson() => {
        "follow_by": followBy == null ? null : followBy,
        "status": status == null ? null : status,
        "follow_to": followTo == null ? null : followTo,
      };
}

import 'dart:convert';

ClubModel clubModelFromJson(String str) => ClubModel.fromJson(json.decode(str));

String clubModelToJson(ClubModel data) => json.encode(data.toJson());

class ClubModel {
  ClubModel({
    this.onlineMemberCount,
    this.userList,
    this.imageUrl,
    this.memberCount,
    this.clubName,
  });

  String refId;
  int onlineMemberCount;
  List<String> userList;
  String imageUrl;
  int memberCount;
  String clubName;

  factory ClubModel.fromJson(Map<String, dynamic> json) => ClubModel(
        onlineMemberCount: json["online_member_count"] == null
            ? null
            : json["online_member_count"],
        userList: json["user_list"] == null
            ? null
            : List<String>.from(json["user_list"].map((x) => x)),
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        memberCount: json["member_count"] == null ? null : json["member_count"],
        clubName: json["club_name"] == null ? null : json["club_name"],
      );

  Map<String, dynamic> toJson() => {
        "online_member_count":
            onlineMemberCount == null ? null : onlineMemberCount,
        "user_list": userList == null
            ? null
            : List<dynamic>.from(userList.map((x) => x)),
        "image_url": imageUrl == null ? null : imageUrl,
        "member_count": memberCount == null ? null : memberCount,
        "club_name": clubName == null ? null : clubName,
      };
}

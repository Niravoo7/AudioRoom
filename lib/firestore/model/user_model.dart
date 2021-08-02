import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.twitterName,
    this.clubJoined,
    this.phoneNumber,
    this.isDelete,
    this.isOnline,
    this.instagramName,
    this.followers,
    this.lastName,
    this.recommendedBy,
    this.aboutInfo,
    this.imageUrl,
    this.displayName,
    this.tagName,
    this.following,
    this.joinedDate,
    this.offlineDate,
    this.firstName,
    this.uId,
    this.token,
  });

  String refId;
  String twitterName;
  int clubJoined;
  String phoneNumber;
  bool isDelete;
  bool isOnline;
  String instagramName;
  int followers;
  String lastName;
  String recommendedBy;
  String aboutInfo;
  String imageUrl;
  String displayName;
  String tagName;
  int following;
  DateTime joinedDate;
  DateTime offlineDate;
  String firstName;
  String uId;
  String token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        twitterName: json["twitter_name"] == null ? null : json["twitter_name"],
        clubJoined: json["club_joined"] == null ? null : json["club_joined"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        isDelete: json["is_delete"] == null ? null : json["is_delete"],
        isOnline: json["is_online"] == null ? null : json["is_online"],
        instagramName:
            json["instagram_name"] == null ? null : json["instagram_name"],
        followers: json["followers"] == null ? null : json["followers"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        recommendedBy:
            json["recommended_by"] == null ? null : json["recommended_by"],
        aboutInfo: json["about_info"] == null ? null : json["about_info"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        displayName: json["display_name"] == null ? null : json["display_name"],
        tagName: json["tag_name"] == null ? null : json["tag_name"],
        following: json["following"] == null ? null : json["following"],
        joinedDate: json["joined_date"] != null
            ? (json["joined_date"] is String)
                ? (json["joined_date"] != "")
                    ? DateTime.parse(json["joined_date"])
                    : null
                : json["joined_date"].toDate()
            : null,
        offlineDate: json["offline_date"] != null
            ? (json["offline_date"] is String)
                ? (json["offline_date"] != "")
                    ? DateTime.parse(json["offline_date"])
                    : null
                : json["offline_date"].toDate()
            : null,
        firstName: json["first_name"] == null ? null : json["first_name"],
        uId: json["uid"] == null ? null : json["uid"],
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "twitter_name": twitterName == null ? null : twitterName,
        "club_joined": clubJoined == null ? null : clubJoined,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "is_delete": isDelete == null ? null : isDelete,
        "is_online": isOnline == null ? null : isOnline,
        "instagram_name": instagramName == null ? null : instagramName,
        "followers": followers == null ? null : followers,
        "last_name": lastName == null ? null : lastName,
        "recommended_by": recommendedBy == null ? null : recommendedBy,
        "about_info": aboutInfo == null ? null : aboutInfo,
        "image_url": imageUrl == null ? null : imageUrl,
        "display_name": displayName == null ? null : displayName,
        "tag_name": tagName == null ? null : tagName,
        "following": following == null ? null : following,
        "joined_date": (joinedDate != null) ? joinedDate.toString() : null,
        "offline_date": (offlineDate != null) ? offlineDate.toString() : null,
        "first_name": firstName == null ? null : firstName,
        "uid": uId == null ? null : uId,
        "token": token == null ? null : token,
      };

  Map<String, dynamic> toJsonTimeStamp() => {
        "twitter_name": twitterName == null ? null : twitterName,
        "club_joined": clubJoined == null ? null : clubJoined,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "is_delete": isDelete == null ? null : isDelete,
        "is_online": isOnline == null ? null : isOnline,
        "instagram_name": instagramName == null ? null : instagramName,
        "followers": followers == null ? null : followers,
        "last_name": lastName == null ? null : lastName,
        "recommended_by": recommendedBy == null ? null : recommendedBy,
        "about_info": aboutInfo == null ? null : aboutInfo,
        "image_url": imageUrl == null ? null : imageUrl,
        "display_name": displayName == null ? null : displayName,
        "tag_name": tagName == null ? null : tagName,
        "following": following == null ? null : following,
        "joined_date":
            (joinedDate != null) ? Timestamp.fromDate(joinedDate) : null,
        "offline_date":
            (offlineDate != null) ? Timestamp.fromDate(offlineDate) : null,
        "first_name": firstName == null ? null : firstName,
        "uid": uId == null ? null : uId,
        "token": token == null ? null : token,
      };
}

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.uId,
    this.title,
    this.notificationType,
    this.createDatetime,
    this.description,
    this.imageUrl,
  });

  String refId;
  String uId;
  String title;
  String notificationType;
  DateTime createDatetime;
  String description;
  String imageUrl;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        uId: json["uid"] == null ? null : json["uid"],
        title: json["title"] == null ? null : json["title"],
        notificationType: json["notification_type"] == null
            ? null
            : json["notification_type"],
        createDatetime: json["create_datetime"] != null
            ? (json["create_datetime"] is String)
                ? (json["create_datetime"] != "")
                    ? DateTime.parse(json["create_datetime"])
                    : null
                : json["create_datetime"].toDate()
            : null,
        description: json["description"] == null ? null : json["description"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uId == null ? null : uId,
        "title": title == null ? null : title,
        "notification_type": notificationType == null ? null : notificationType,
        "create_datetime":
            (createDatetime != null) ? createDatetime.toString() : null,
        "description": description == null ? null : description,
        "image_url": imageUrl == null ? null : imageUrl,
      };

  Map<String, dynamic> toJsonTimeStamp() => {
        "uid": uId == null ? null : uId,
        "title": title == null ? null : title,
        "notification_type": notificationType == null ? null : notificationType,
        "create_datetime": (createDatetime != null)
            ? Timestamp.fromDate(createDatetime)
            : null,
        "description": description == null ? null : description,
        "image_url": imageUrl == null ? null : imageUrl,
      };
}

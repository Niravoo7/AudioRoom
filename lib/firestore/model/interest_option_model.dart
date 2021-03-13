import 'dart:convert';

InterestOptionModel interestOptionModelFromJson(String str) =>
    InterestOptionModel.fromJson(json.decode(str));

String interestOptionModelToJson(InterestOptionModel data) =>
    json.encode(data.toJson());

class InterestOptionModel {
  InterestOptionModel({
    this.title,
  });

  String title;
  String refId;

  factory InterestOptionModel.fromJson(Map<String, dynamic> json) =>
      InterestOptionModel(
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
      };
}

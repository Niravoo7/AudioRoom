import 'dart:convert';

InterestModel interestModelFromJson(String str) =>
    InterestModel.fromJson(json.decode(str));

String interestModelToJson(InterestModel data) => json.encode(data.toJson());

class InterestModel {
  InterestModel({
    this.categoryTitle,
  });

  String categoryTitle;
  String refId;

  factory InterestModel.fromJson(Map<String, dynamic> json) => InterestModel(
        categoryTitle:
            json["category_title"] == null ? null : json["category_title"],
      );

  Map<String, dynamic> toJson() => {
        "category_title": categoryTitle == null ? null : categoryTitle,
      };
}

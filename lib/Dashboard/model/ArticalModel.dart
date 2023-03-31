// To parse this JSON data, do
//
//     final communityCategoryModel = communityCategoryModelFromJson(jsonString);

import 'dart:convert';

ArticaleModel articleModelFromJson(String str) =>
    ArticaleModel.fromJson(json.decode(str));

String articleCategoryModelToJson(ArticaleModel data) =>
    json.encode(data.toJson());

class ArticaleModel {
  ArticaleModel({
    this.status,
    this.message,
    this.limit,
    this.page,
    this.data,
  });

  int? status;
  String? message;
  int? limit;
  int? page;
  List<ArticleDatum>? data;

  factory ArticaleModel.fromJson(Map<String, dynamic> json) => ArticaleModel(
        status: json["status"],
        message: json["message"],
        limit: json["limit"],
        page: json["page"],
        data: List<ArticleDatum>.from(
            json["Data"].map((x) => ArticleDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "limit": limit,
        "page": page,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ArticleDatum {
  ArticleDatum({
    this.id,
    this.title,
    this.description,
    this.image,
  });

  String? id;
  String? title;
  String? description;
  String? image;

  factory ArticleDatum.fromJson(Map<String, dynamic> json) => ArticleDatum(
        id: json["id"],
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
      };
}

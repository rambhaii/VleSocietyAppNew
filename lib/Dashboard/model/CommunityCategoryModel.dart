// To parse this JSON data, do
//
//     final communityCategoryModel = communityCategoryModelFromJson(jsonString);

import 'dart:convert';

CommunityCategoryModel communityCategoryModelFromJson(String str) => CommunityCategoryModel.fromJson(json.decode(str));

String communityCategoryModelToJson(CommunityCategoryModel data) => json.encode(data.toJson());

class CommunityCategoryModel {
  CommunityCategoryModel({
    this.status,
    this.message,
    this.limit,
    this.page,
    this.data,
  });

  int ?status;
  String? message;
  String? limit;
  int? page;
  List<Datum>? data;

  factory CommunityCategoryModel.fromJson(Map<String, dynamic> json) => CommunityCategoryModel(
    status: json["status"],
    message: json["message"],
    limit: json["limit"],
    page: json["page"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "limit": limit,
    "page": page,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.image,
    this.followStatus,
  });

  String ?id;
  String ?title;
  String ?image;
  String ?followStatus;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"]??"",
    image: json["image"]??"",
    followStatus: json["followStatus"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "followStatus": followStatus,
  };
}

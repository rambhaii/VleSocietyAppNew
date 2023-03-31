// To parse this JSON data, do
//
//     final awardsModel = awardsModelFromJson(jsonString);

import 'dart:convert';

AwardsModel awardsModelFromJson(String str) => AwardsModel.fromJson(json.decode(str));

String awardsModelToJson(AwardsModel data) => json.encode(data.toJson());

class AwardsModel {
  AwardsModel({
    this.status,
    this.message,
    this.limit,
    this.page,
    this.data,
  });

  int? status;
  String? message;
  String? limit;
  int? page;
  List<Datum>? data;

  factory AwardsModel.fromJson(Map<String, dynamic> json) => AwardsModel(
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
    this.description,
    this.image,
  });

  String? id;
  String? title;
  String? description;
  String? image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
  };
}

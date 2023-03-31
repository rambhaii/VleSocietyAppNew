// To parse this JSON data, do
//
//     final aboutCscModel = aboutCscModelFromJson(jsonString);

import 'dart:convert';

AboutCscModel aboutCscModelFromJson(String str) => AboutCscModel.fromJson(json.decode(str));

String aboutCscModelToJson(AboutCscModel data) => json.encode(data.toJson());

class AboutCscModel {
  AboutCscModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory AboutCscModel.fromJson(Map<String, dynamic> json) => AboutCscModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Data": data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.title,
    this.description,
    this.image,
  });

  String? id;
  String? title;
  String? description;
  String? image;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
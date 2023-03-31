// To parse this JSON data, do
//
//     final privacyModel = privacyModelFromJson(jsonString);

import 'dart:convert';

PrivacyModel privacyModelFromJson(String str) => PrivacyModel.fromJson(json.decode(str));

String privacyModelToJson(PrivacyModel data) => json.encode(data.toJson());

class PrivacyModel {
  PrivacyModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory PrivacyModel.fromJson(Map<String, dynamic> json) => PrivacyModel(
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
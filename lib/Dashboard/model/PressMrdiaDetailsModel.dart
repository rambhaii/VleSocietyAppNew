// To parse this JSON data, do
//
//     final pressMediaDetailsModel = pressMediaDetailsModelFromJson(jsonString);

import 'dart:convert';

PressMediaDetailsModel pressMediaDetailsModelFromJson(String str) => PressMediaDetailsModel.fromJson(json.decode(str));

String pressMediaDetailsModelToJson(PressMediaDetailsModel data) => json.encode(data.toJson());

class PressMediaDetailsModel {
  PressMediaDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory PressMediaDetailsModel.fromJson(Map<String, dynamic> json) => PressMediaDetailsModel(
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
    this.imageList,
  });

  String? id;
  String? title;
  String? description;
  String? image;
  List<ImageList>? imageList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    imageList: List<ImageList>.from(json["imageList"].map((x) => ImageList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "imageList": List<dynamic>.from(imageList!.map((x) => x.toJson())),
  };
}

class ImageList {
  ImageList({
    this.id,
    this.image,
  });

  String? id;
  String? image;

  factory ImageList.fromJson(Map<String, dynamic> json) => ImageList(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}

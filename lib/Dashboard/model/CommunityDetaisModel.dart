// To parse this JSON data, do
//
//     final communityDetailsModel = communityDetailsModelFromJson(jsonString);

import 'dart:convert';

CommunityDetailsModel communityDetailsModelFromJson(String str) => CommunityDetailsModel.fromJson(json.decode(str));

String communityDetailsModelToJson(CommunityDetailsModel data) => json.encode(data.toJson());

class CommunityDetailsModel {
  CommunityDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  int ?status;
  String? message;
  Data ?data;

  factory CommunityDetailsModel.fromJson(Map<String, dynamic> json) => CommunityDetailsModel(
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
    this.postCategoryMasterId,
    this.description,
    this.addDate,
    this.postCategory,
    this.image,
    this.addById,
    this.followStatus,
    this.ttlView,
    this.ttlAnswer,
    this.addBy,
    this.imageList,
  });

  String ?id;
  String ?postCategoryMasterId;
  String ?description;
  String? addDate;
  String ?postCategory;
  String ?image;
  String ?addById;
  String ?followStatus;
  String ?ttlView;
  String ?ttlAnswer;
  String ?addBy;
  List<ImageList> ?imageList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"]??"",
    postCategoryMasterId: json["post_category_master_id"]??"",
    description: json["description"]??"",
    addDate: json["add_date"]??"",
    postCategory: json["postCategory"]??"",
    image: json["image"]??"",
    addById: json["add_by_id"]??"",
    followStatus: json["followStatus"]??"",
    ttlView: json["ttlView"]??"",
    ttlAnswer: json["ttlAnswer"]??"",
    addBy: json["addBy"]??"",
    imageList: List<ImageList>.from(json["imageList"].map((x) => ImageList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post_category_master_id": postCategoryMasterId,
    "description": description,
    "add_date": addDate,
    "postCategory": postCategory,
    "image": image,
    "add_by_id": addById,
    "followStatus": followStatus,
    "ttlView": ttlView,
    "ttlAnswer": ttlAnswer,
    "addBy": addBy,
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
    id: json["id"]??"",
    image: json["image"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}

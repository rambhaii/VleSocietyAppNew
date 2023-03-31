// To parse this JSON data, do
//
//     final searchKeyModel = searchKeyModelFromJson(jsonString);

import 'dart:convert';

SearchKeyModel searchKeyModelFromJson(String str) => SearchKeyModel.fromJson(json.decode(str));

String searchKeyModelToJson(SearchKeyModel data) => json.encode(data.toJson());

class SearchKeyModel {
  SearchKeyModel({
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

  factory SearchKeyModel.fromJson(Map<String, dynamic> json) => SearchKeyModel(
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
    this.postCategoryMasterId,
    this.description,
    this.addDate,
    this.postCategory,
    this.image,
    this.addById,
    this.followStatus,
    this.ttlView,
    this.ttlAnswer,
    this.ttlMedia,
    this.ttlLike,
    this.aslike,
    this.imageList,
    this.addBy,
    this.addByPic,
  });

  String? id;
  String? postCategoryMasterId;
  String? description;
  DateTime? addDate;
  String? postCategory;
  String? image;
  String? addById;
  String? followStatus;
  String? ttlView;
  String? ttlAnswer;
  String? ttlMedia;
  String? ttlLike;
  String? aslike;
  List<dynamic>? imageList;
  String? addBy;
  String? addByPic;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    postCategoryMasterId: json["post_category_master_id"],
    description: json["description"],
    addDate: DateTime.parse(json["add_date"]),
    postCategory: json["postCategory"],
    image: json["image"],
    addById: json["add_by_id"],
    followStatus: json["followStatus"],
    ttlView: json["ttlView"],
    ttlAnswer: json["ttlAnswer"],
    ttlMedia: json["ttlMedia"],
    ttlLike: json["ttlLike"],
    aslike: json["aslike"],
    imageList: List<dynamic>.from(json["imageList"].map((x) => x)),
    addBy: json["addBy"],
    addByPic: json["addByPic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post_category_master_id": postCategoryMasterId,
    "description": description,
    "add_date": addDate!.toIso8601String(),
    "postCategory": postCategory,
    "image": image,
    "add_by_id": addById,
    "followStatus": followStatus,
    "ttlView": ttlView,
    "ttlAnswer": ttlAnswer,
    "ttlMedia": ttlMedia,
    "ttlLike": ttlLike,
    "aslike": aslike,
    "imageList": List<dynamic>.from(imageList!.map((x) => x)),
    "addBy": addBy,
    "addByPic": addByPic,
  };
}

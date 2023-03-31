// To parse this JSON data, do
//
//     final myAskModel = myAskModelFromJson(jsonString);

import 'dart:convert';

MyAskModel myAskModelFromJson(String str) => MyAskModel.fromJson(json.decode(str));

String myAskModelToJson(MyAskModel data) => json.encode(data.toJson());

class MyAskModel {
  MyAskModel({
    this.status,
    this.message,
    this.limit,
    this.page,
    this.data,
  });

  int ?status;
  String ?message;
  String ?limit;
  int ?page;
  List<MyDatum> ?data;

  factory MyAskModel.fromJson(Map<String, dynamic> json) => MyAskModel(
    status: json["status"],
    message: json["message"],
    limit: json["limit"],
    page: json["page"],
    data: List<MyDatum>.from(json["Data"].map((x) => MyDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "limit": limit,
    "page": page,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MyDatum {
  MyDatum({
    this.id,
    this.postCategoryMasterId,
    this.description,
    this.addDate,
    this.postCategory,
    this.addById,
    this.image,
    this.followStatus,
    this.ttlView,
    this.ttlAnswer,
  });

  String ?id;
  String ?postCategoryMasterId;
  String ?description;
  String? addDate;
  String ?postCategory;
  String ?addById;
  String ?image;
  String ?followStatus;
  String ?ttlView;
  String ?ttlAnswer;

  factory MyDatum.fromJson(Map<String, dynamic> json) => MyDatum(
    id: json["id"],
    postCategoryMasterId: json["post_category_master_id"]??"",
    description: json["description"]??"",
    addDate: json["add_date"]??"",
    postCategory: json["postCategory"]??"",
    addById: json["add_by_id"]??"",
    image: json["image"]??"",
    followStatus: json["followStatus"]??"",
    ttlView: json["ttlView"]??"",
    ttlAnswer: json["ttlAnswer"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post_category_master_id": postCategoryMasterId,
    "description": description,
    "add_date": addDate,
    "postCategory": postCategory,
    "add_by_id": addById,
    "image": image,
    "followStatus": followStatus,
    "ttlView": ttlView,
    "ttlAnswer": ttlAnswer,
  };
}

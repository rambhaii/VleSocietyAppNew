// To parse this JSON data, do
//
//     final userProfileData = userProfileDataFromJson(jsonString);

import 'dart:convert';

CommunityModel communityModelFromJson(String str) => CommunityModel.fromJson(json.decode(str));

String communityModelToJson(CommunityModel data) => json.encode(data.toJson());

class CommunityModel {
  CommunityModel({
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
  List<CommunityDatum>? data;

  factory CommunityModel.fromJson(Map<String, dynamic> json) => CommunityModel(
    status: json["status"],
    message: json["message"],
    limit: json["limit"],
    page: json["page"],
    data: List<CommunityDatum>.from(json["Data"].map((x) => CommunityDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "limit": limit,
    "page": page,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CommunityDatum {
  CommunityDatum({
    this.id,
    this.postCategoryMasterId,
    this.description,
    this.addDate,
    this.postCategory,
    this.image,
    this.addById,
    this.followStatus,
    this.aslike,
    this.ttlView,
    this.ttlLike,
    this.ttlAnswer,
    this.addBy,
    this.addByPic,
    this.isSlected,
    this.likeslected,
    this.ttlMedia,
    this.ttlShare,
    this.is_verify
  });

  String? id;
  String? postCategoryMasterId;
  String? description;
  String? addDate;
  String ?postCategory;
  String? image;
  String? addById;
  String? followStatus;
  String? aslike;
  String? ttlView;
  String? ttlLike;
  String? ttlAnswer;
  String? addBy;
  String? addByPic;
  bool? isSlected;
  bool? likeslected;
  String? ttlMedia;
  String? ttlShare;
  String? is_verify;

  factory CommunityDatum.fromJson(Map<String, dynamic> json) => CommunityDatum(
    id: json["id"],
    postCategoryMasterId: json["post_category_master_id"]??"",
    description: json["description"]??"",
    addDate: json["add_date"]??"",
    postCategory: json["postCategory"]??"",
    image: json["image"]??"",
    addById: json["add_by_id"]??"",
    followStatus: json["followStatus"]??"",
    aslike: json["aslike"]??"",
    ttlView: json["ttlView"]??"",
    ttlLike: json["ttlLike"]??"",
    ttlAnswer: json["ttlAnswer"]??"",
    addBy: json["addBy"]??"",
    addByPic: json["addByPic"]??"",
    isSlected:json["followStatus"]!=null?json["followStatus"]=="Following"?false:true:false,
    likeslected:json["aslike"]!=null?json["aslike"]=="0"?false:true:false,
    ttlMedia: json["ttlMedia"]??"",
    ttlShare: json["ttlShare"]??"",
    is_verify: json["is_verify"]??"",
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
    "aslike": aslike,
    "ttlView": ttlView,
    "ttlLike": ttlLike,
    "ttlAnswer": ttlAnswer,
    "addBy": addBy,
    "addByPic": addByPic,
    "isSlected": isSlected,
    "likeslected": likeslected,
    "ttlShare": ttlShare,
    "is_verify": is_verify,
  };
}

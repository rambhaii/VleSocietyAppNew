// To parse this JSON data, do
//
//     final feedArticalModel = feedArticalModelFromJson(jsonString);

import 'dart:convert';

FeedArticalModel feedArticalModelFromJson(String str) => FeedArticalModel.fromJson(json.decode(str));

String feedArticalModelToJson(FeedArticalModel data) => json.encode(data.toJson());

class FeedArticalModel {
  FeedArticalModel({
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
  List<Datum1>? data;

  factory FeedArticalModel.fromJson(Map<String, dynamic> json) => FeedArticalModel(
    status: json["status"],
    message: json["message"],
    limit: json["limit"],
    page: json["page"],
    data: List<Datum1>.from(json["Data"].map((x) => Datum1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "limit": limit,
    "page": page,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum1 {
  Datum1({
    this.id,
    this.title,
    this.url,
    this.description,
    this.postType,
    this.commentCount,
    this.postDate,
  });

  String? id;
  String? title;
  String? url;
  String? description;
  String? postType;
  String? commentCount;
  DateTime? postDate;

  factory Datum1.fromJson(Map<String, dynamic> json) => Datum1(
    id: json["id"],
    title: json["title"],
    url: json["url"],
    description: json["description"],
    postType: json["post_type"],
    commentCount: json["comment_count"],
    postDate: DateTime.parse(json["post_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url": url,
    "description": description,
    "post_type": postType,
    "comment_count": commentCount,
    "post_date": postDate!.toIso8601String(),
  };
}

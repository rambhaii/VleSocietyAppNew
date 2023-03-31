// To parse this JSON data, do
//
//     final likeDisLike = likeDisLikeFromJson(jsonString);

import 'dart:convert';

LikeDisLike likeDisLikeFromJson(String str) => LikeDisLike.fromJson(json.decode(str));

String likeDisLikeToJson(LikeDisLike data) => json.encode(data.toJson());

class LikeDisLike {
  LikeDisLike({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<dynamic>? data;

  factory LikeDisLike.fromJson(Map<String, dynamic> json) => LikeDisLike(
    status: json["status"],
    message: json["message"],
    data: List<dynamic>.from(json["Data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Data": List<dynamic>.from(data!.map((x) => x)),
  };
}

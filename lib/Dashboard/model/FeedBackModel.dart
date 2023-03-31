// To parse this JSON data, do
//
//     final feedBackModel = feedBackModelFromJson(jsonString);

import 'dart:convert';

FeedBackModel feedBackModelFromJson(String str) => FeedBackModel.fromJson(json.decode(str));

String feedBackModelToJson(FeedBackModel data) => json.encode(data.toJson());

class FeedBackModel {
  FeedBackModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<dynamic>? data;

  factory FeedBackModel.fromJson(Map<String, dynamic> json) => FeedBackModel(
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

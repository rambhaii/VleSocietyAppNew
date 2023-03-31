// To parse this JSON data, do
//
//     final followModel = followModelFromJson(jsonString);

import 'dart:convert';

FollowModel followModelFromJson(String str) => FollowModel.fromJson(json.decode(str));

String followModelToJson(FollowModel data) => json.encode(data.toJson());

class FollowModel {
  FollowModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<dynamic>? data;

  factory FollowModel.fromJson(Map<String, dynamic> json) => FollowModel(
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

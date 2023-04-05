// To parse this JSON data, do
//
//     final referalModel = referalModelFromJson(jsonString);

import 'dart:convert';

ReferalModel referalModelFromJson(String str) => ReferalModel.fromJson(json.decode(str));

String referalModelToJson(ReferalModel data) => json.encode(data.toJson());

class ReferalModel {
  ReferalModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data ?data;

  factory ReferalModel.fromJson(Map<String, dynamic> json) => ReferalModel(
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
    this.addBy,
    this.modifyBy,
    this.title,
    this.points,
    this.status,
    this.addDate,
    this.modifyDate,
    this.referalUse,
  });

  String? id;
  String? addBy;
  String? modifyBy;
  String? title;
  String? points;
  String? status;
  DateTime? addDate;
  String? modifyDate;
  String? referalUse;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    addBy: json["add_by"],
    modifyBy: json["modify_by"],
    title: json["title"],
    points: json["points"],
    status: json["status"],
    addDate: DateTime.parse(json["add_date"]),
    modifyDate: json["modify_date"],
    referalUse: json["referal_use"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "add_by": addBy,
    "modify_by": modifyBy,
    "title": title,
    "points": points,
    "status": status,
    "add_date": addDate!.toIso8601String(),
    "modify_date": modifyDate,
    "referal_use": referalUse,
  };
}

// To parse this JSON data, do
//
//     final pointsModelDetails = pointsModelDetailsFromJson(jsonString);

import 'dart:convert';

PointsModelDetails pointsModelDetailsFromJson(String str) => PointsModelDetails.fromJson(json.decode(str));

String pointsModelDetailsToJson(PointsModelDetails data) => json.encode(data.toJson());

class PointsModelDetails {
  int? status;
  String? message;
  List<Datum>? data;

  PointsModelDetails({
    this.status,
    this.message,
    this.data,
  });

  factory PointsModelDetails.fromJson(Map<String, dynamic> json) => PointsModelDetails(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? addBy;
  String? modifyBy;
  String? title;
  String? points;
  String? description;
  String? icon;
  String? status;
  DateTime? addDate;
  String? modifyDate;

  Datum({
    this.id,
    this.addBy,
    this.modifyBy,
    this.title,
    this.points,
    this.description,
    this.icon,
    this.status,
    this.addDate,
    this.modifyDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    addBy: json["add_by"],
    modifyBy: json["modify_by"],
    title: json["title"],
    points: json["points"],
    description: json["description"],
    icon: json["icon"],
    status: json["status"],
    addDate: DateTime.parse(json["add_date"]),
    modifyDate: json["modify_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "add_by": addBy,
    "modify_by": modifyBy,
    "title": title,
    "points": points,
    "description": description,
    "icon": icon,
    "status": status,
    "add_date": addDate!.toIso8601String(),
    "modify_date": modifyDate,
  };
}

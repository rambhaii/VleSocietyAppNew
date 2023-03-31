// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.status,
    this.message,
    this.limit,
    this.page,
    this.data,
  });

  int? status;
  String? message;
  String ?limit;
  int? page;
  List<Datum>? data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
    this.title,
    this.typeId,
    this.type,
    this.addDate,
  });

  String? id;
  String? title;
  String? typeId;
  String? type;
  DateTime? addDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    typeId: json["type_id"],
    type: json["type"],
    addDate: DateTime.parse(json["add_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "type_id": typeId,
    "type": type,
    "add_date": addDate!.toIso8601String(),
  };
}

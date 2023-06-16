/*
// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  int? status;
  String? message;
  String? limit;
  int? page;
  List<Datum>? data;

  NotificationModel({
    this.status,
    this.message,
    this.limit,
    this.page,
    this.data,
  });

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
  String? id;
  String? title;
  String? typeId;
  String? type;
  DateTime? addDate;

  Datum({
    this.id,
    this.title,
    this.typeId,
    this.type,
    this.addDate,
  });

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
*/
// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonStri



// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  int? status;
  String? message;
  String? limit;
  int? page;
  List<Datum>? data;

  NotificationModel({
    this.status,
    this.message,
    this.limit,
    this.page,
    this.data,
  });

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
  String? id;
  String? typeId;
  String? datumAddBy;
  String? title;
  String? type;
  String? status;
  String? addDate;
  String? modifyDate;
  String? addBy;
  String? isVerify;
  String? profile;
  String? description;
  String? addByPic;

  Datum({
    this.id,
    this.typeId,
    this.datumAddBy,
    this.title,
    this.type,
    this.status,
    this.addDate,
    this.modifyDate,
    this.addBy,
    this.isVerify,
    this.profile,
    this.description,
    this.addByPic,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    typeId: json["type_id"],
    datumAddBy: json["add_by"],
    title: json["title"],
    type: json["type"],
    status: json["status"],
    addDate: json["add_date"],
    modifyDate: json["modify_date"],
    addBy: json["addBy"],
    isVerify: json["is_verify"],
    profile: json["profile"],
    description: json["description"],
    addByPic: json["addByPic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type_id": typeId,
    "add_by": datumAddBy,
    "title": title,
    "type": type,
    "status": status,
    "add_date": addDate,
    "modify_date": modifyDate,
    "addBy": addBy,
    "is_verify": isVerify,
    "profile": profile,
    "description": description,
    "addByPic": addByPic,
  };
}


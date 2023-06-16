// To parse this JSON data, do
//
//     final userType = userTypeFromJson(jsonString);

import 'dart:convert';

UserType userTypeFromJson(String str) => UserType.fromJson(json.decode(str));

String userTypeToJson(UserType data) => json.encode(data.toJson());

class UserType {
  int? status;
  String? message;
  List<DatumUser>? data;

  UserType({
    this.status,
    this.message,
    this.data,
  });

  factory UserType.fromJson(Map<String, dynamic> json) => UserType(
    status: json["status"],
    message: json["message"],
    data: List<DatumUser>.from(json["Data"].map((x) => DatumUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DatumUser {
  String? id;
  String? typeName;
  String? status;
  DateTime? addDate;
  String? modifyDate;

  DatumUser({
    this.id,
    this.typeName,
    this.status,
    this.addDate,
    this.modifyDate,
  });

  factory DatumUser.fromJson(Map<String, dynamic> json) => DatumUser(
    id: json["id"],
    typeName: json["type_name"],
    status: json["status"],
    addDate: DateTime.parse(json["add_date"]),
    modifyDate: json["modify_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type_name": typeName,
    "status": status,
    "add_date": addDate!.toIso8601String(),
    "modify_date": modifyDate,
  };
}

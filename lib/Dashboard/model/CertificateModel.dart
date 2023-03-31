// To parse this JSON data, do
//
//     final certificateModel = certificateModelFromJson(jsonString);

import 'dart:convert';

CertificateModel certificateModelFromJson(String str) => CertificateModel.fromJson(json.decode(str));

String certificateModelToJson(CertificateModel data) => json.encode(data.toJson());

class CertificateModel {
  CertificateModel({
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
  List<Datum>? data;

  factory CertificateModel.fromJson(Map<String, dynamic> json) => CertificateModel(
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
    this.tblUserId,
    this.title,
    this.certificate,
    this.status,
    this.addDate,
  });

  String? id;
  String? tblUserId;
  String? title;
  String? certificate;
  String? status;
  DateTime? addDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    tblUserId: json["tbl_user_id"],
    title: json["title"],
    certificate: json["certificate"],
    status: json["status"],
    addDate: DateTime.parse(json["add_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tbl_user_id": tblUserId,
    "title": title,
    "certificate": certificate,
    "status": status,
    "add_date": addDate!.toIso8601String(),
  };
}

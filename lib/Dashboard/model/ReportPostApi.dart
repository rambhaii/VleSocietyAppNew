// To parse this JSON data, do
//
//     final reportPostApi = reportPostApiFromJson(jsonString);

import 'dart:convert';

ReportPostApi reportPostApiFromJson(String str) => ReportPostApi.fromJson(json.decode(str));

String reportPostApiToJson(ReportPostApi data) => json.encode(data.toJson());

class ReportPostApi {
  ReportPostApi({
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

  factory ReportPostApi.fromJson(Map<String, dynamic> json) => ReportPostApi(
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
  });

  String? id;
  String? title;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}

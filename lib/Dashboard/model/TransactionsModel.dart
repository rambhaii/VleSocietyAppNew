// To parse this JSON data, do
//
//     final transactionsModel = transactionsModelFromJson(jsonString);

import 'dart:convert';

TransactionsModel transactionsModelFromJson(String str) => TransactionsModel.fromJson(json.decode(str));

String transactionsModelToJson(TransactionsModel data) => json.encode(data.toJson());

class TransactionsModel {
  TransactionsModel({
    this.status,
    this.message,
    this.totalPoints,
    this.avlPoint,
    this.totalDebit,
    this.limit,
    this.totalRedeem,
    this.page,
    this.data,
  });

  int? status;
  String? message;
  String? totalPoints;
  int? avlPoint;
  String? totalDebit;
  String? limit;
  String? totalRedeem;
  int? page;
  List<Datum>? data;

  factory TransactionsModel.fromJson(Map<String, dynamic> json) => TransactionsModel(
    status: json["status"],
    message: json["message"],
    totalPoints: json["totalPoints"],
    avlPoint: json["avlPoint"],
    totalDebit: json["totalDebit"],
    limit: json["limit"],
    totalRedeem: json["totalRedeem"],
    page: json["page"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "totalPoints": totalPoints,
    "avlPoint": avlPoint,
    "totalDebit": totalDebit,
    "limit": limit,
    "totalRedeem": totalRedeem,
    "page": page,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.points,
    this.status,
    this.addDate,
  });

  String? id;
  String? title;
  String? points;
  String? status;
  DateTime? addDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    points: json["points"],
    status: json["status"],
    addDate: DateTime.parse(json["add_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "points": points,
    "status": status,
    "add_date": addDate!.toIso8601String(),
  };
}

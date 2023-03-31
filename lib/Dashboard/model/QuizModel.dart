// To parse this JSON data, do
//
//     final quzeModel = quzeModelFromJson(jsonString);

import 'dart:convert';

QuzeModel quzeModelFromJson(String str) => QuzeModel.fromJson(json.decode(str));

String quzeModelToJson(QuzeModel data) => json.encode(data.toJson());

class QuzeModel {
  QuzeModel({
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

  factory QuzeModel.fromJson(Map<String, dynamic> json) => QuzeModel(
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
    this.ptPrQuestion,
    this.image,
    this.description,
    this.status,
    this.addDate,
    this.noOfQuestion,
    this.totalPoints,
  });

  String? id;
  String? title;
  String? ptPrQuestion;
  String? image;
  String? description;
  String? status;
  DateTime? addDate;
  String? noOfQuestion;
  String? totalPoints;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    ptPrQuestion: json["pt_pr_question"],
    image: json["image"],
    description: json["description"],
    status: json["status"],
    addDate: DateTime.parse(json["add_date"]),
    noOfQuestion: json["noOfQuestion"],
    totalPoints: json["totalPoints"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "pt_pr_question": ptPrQuestion,
    "image": image,
    "description": description,
    "status": status,
    "add_date": addDate!.toIso8601String(),
    "noOfQuestion": noOfQuestion,
    "totalPoints": totalPoints,
  };
}

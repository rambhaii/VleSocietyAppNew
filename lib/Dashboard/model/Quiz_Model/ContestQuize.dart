// To parse this JSON data, do
//
//     final contestQuize = contestQuizeFromJson(jsonString);

import 'dart:convert';

ContestQuize contestQuizeFromJson(String str) => ContestQuize.fromJson(json.decode(str));

String contestQuizeToJson(ContestQuize data) => json.encode(data.toJson());

class ContestQuize {
  ContestQuize({
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

  factory ContestQuize.fromJson(Map<String, dynamic> json) => ContestQuize(
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
    this.image,
    this.description,
    this.status,
    this.addDate,
  });

  String? id;
  String? title;
  String? image;
  String? description;
  String? status;
  DateTime? addDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    description: json["description"],
    status: json["status"],
    addDate: DateTime.parse(json["add_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "description": description,
    "status": status,
    "add_date": addDate!.toIso8601String(),
  };
}

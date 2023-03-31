// To parse this JSON data, do
//
//     final testimonialModel = testimonialModelFromJson(jsonString);

import 'dart:convert';

TestimonialModel testimonialModelFromJson(String str) => TestimonialModel.fromJson(json.decode(str));

String testimonialModelToJson(TestimonialModel data) => json.encode(data.toJson());

class TestimonialModel {
  TestimonialModel({
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

  factory TestimonialModel.fromJson(Map<String, dynamic> json) => TestimonialModel(
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
    this.name,
    this.location,
    this.description,
    this.addDate,
    this.profile,
  });

  String? id;
  String? name;
  String? location;
  String? description;
  DateTime? addDate;
  String? profile;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    location: json["location"],
    description: json["description"],
    addDate: DateTime.parse(json["add_date"]),
    profile: json["profile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "location": location,
    "description": description,
    "add_date": addDate?.toIso8601String(),
    "profile": profile,
  };
}

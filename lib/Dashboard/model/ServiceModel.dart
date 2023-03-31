// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

ServiceModel serviceModelFromJson(String str) => ServiceModel.fromJson(json.decode(str));

String serviceModelToJson(ServiceModel data) => json.encode(data.toJson());

class ServiceModel {
  ServiceModel({
    this.status,
    this.message,
    this.limit,
    this.page,
    this.data,
  });

  int ?status;
  String ?message;
  String ?limit;
  int ?page;
  List<ServiceDatum>? data;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    status: json["status"],
    message: json["message"],
    limit: json["limit"],
    page: json["page"],
    data: List<ServiceDatum>.from(json["Data"].map((x) => ServiceDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "limit": limit,
    "page": page,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ServiceDatum {
  ServiceDatum({
    this.id,
    this.title,
    this.url,
    this.image,
    this.description,
    this.is_gosite,
    this.service_master_parent,
    this.parentTitle,
  });

  String? id;
  String? title;
  String? url;
  String? image;
  String? description;
  String? is_gosite;
  String? service_master_parent;
  String? parentTitle;

  factory ServiceDatum.fromJson(Map<String, dynamic> json) => ServiceDatum(
    id: json["id"]??"",
    title: json["title"]??"",
    url: json["url"]??"",
    image: json["image"]??"",
    description: json["description"]??"",
    is_gosite: json["is_gosite"]??"",
    service_master_parent: json["service_master_parent"]??"",
    parentTitle: json["parentTitle"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url": url,
    "image": image,
    "description": description,
    "is_gosite": is_gosite,
    "service_master_parent": service_master_parent,
    "parentTitle": parentTitle,
  };
}

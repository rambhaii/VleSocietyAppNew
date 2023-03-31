// To parse this JSON data, do
//
//     final serviceCategoryModel = serviceCategoryModelFromJson(jsonString);

import 'dart:convert';

ServiceCategoryModel serviceCategoryModelFromJson(String str) => ServiceCategoryModel.fromJson(json.decode(str));

String serviceCategoryModelToJson(ServiceCategoryModel data) => json.encode(data.toJson());

class ServiceCategoryModel {
  ServiceCategoryModel({
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
  List<ServiceDatum>? data;

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) => ServiceCategoryModel(
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
    this.isGosite,
    this.serviceMasterParent,
    this.parentTitle,
  });

  String? id;
  String? title;
  String ?url;
  String ?image;
  String ?description;
  String ?isGosite;
  String ?serviceMasterParent;
  String ?parentTitle;

  factory ServiceDatum.fromJson(Map<String, dynamic> json) => ServiceDatum(
    id: json["id"],
    title: json["title"],
    url: json["url"],
    image: json["image"],
    description: json["description"],
    isGosite: json["is_gosite"],
    serviceMasterParent: json["service_master_parent"],
    parentTitle: json["parentTitle"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url": url,
    "image": image,
    "description": description,
    "is_gosite": isGosite,
    "service_master_parent": serviceMasterParent,
    "parentTitle": parentTitle,
  };
}

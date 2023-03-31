// To parse this JSON data, do
//
//     final governMentServices = governMentServicesFromJson(jsonString);

import 'dart:convert';

GovernMentServices governMentServicesFromJson(String str) => GovernMentServices.fromJson(json.decode(str));

String governMentServicesToJson(GovernMentServices data) => json.encode(data.toJson());

class GovernMentServices {
  GovernMentServices({
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

  factory GovernMentServices.fromJson(Map<String, dynamic> json) => GovernMentServices(
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
    this.url,
    this.image,
    this.description,
    this.isGosite,
    this.serviceMasterParent,
    this.parentTitle,
    this.noOfList,
  });

  String? id;
  String? title;
  String? url;
  String? image;
  String? description;
  String? isGosite;
  String? serviceMasterParent;
  dynamic? parentTitle;
  String? noOfList;

  factory Datum.fromJson(Map<String, dynamic> json) =>
      Datum
    (
    id: json["id"],
    title: json["title"],
    url: json["url"],
    image: json["image"],
    description: json["description"],
    isGosite: json["is_gosite"],
    serviceMasterParent: json["service_master_parent"],
    parentTitle: json["parentTitle"],
    noOfList: json["noOfList"],
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
    "noOfList": noOfList,
  };
}

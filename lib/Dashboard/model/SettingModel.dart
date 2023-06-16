// To parse this JSON data, do
//
//     final settingModel = settingModelFromJson(jsonString);

import 'dart:convert';

SettingModel settingModelFromJson(String str) => SettingModel.fromJson(json.decode(str));

String settingModelToJson(SettingModel data) => json.encode(data.toJson());

class SettingModel {
  int? status;
  String? message;
  Data? data;

  SettingModel({
    this.status,
    this.message,
    this.data,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Data": data!.toJson(),
  };
}

class Data {
  String? id;
  String? adminMasterId;
  String? title;
  String? feviconIcon;
  String? logo;
  String? website;
  String? websiteLink;
  String? email;
  String? mobile;
  String? address;
  String? shortDescription;
  String? instaLink;
  String? twitterLink;
  String? fbLink;
  String? adsStatus;
  String? status;
  DateTime? addDate;
  String? modifyDate;

  Data({
    this.id,
    this.adminMasterId,
    this.title,
    this.feviconIcon,
    this.logo,
    this.website,
    this.websiteLink,
    this.email,
    this.mobile,
    this.address,
    this.shortDescription,
    this.instaLink,
    this.twitterLink,
    this.fbLink,
    this.adsStatus,
    this.status,
    this.addDate,
    this.modifyDate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    adminMasterId: json["admin_master_id"],
    title: json["title"],
    feviconIcon: json["fevicon_icon"],
    logo: json["logo"],
    website: json["website"],
    websiteLink: json["website_link"],
    email: json["email"],
    mobile: json["mobile"],
    address: json["address"],
    shortDescription: json["short_description"],
    instaLink: json["insta_link"],
    twitterLink: json["twitter_link"],
    fbLink: json["fb_link"],
    adsStatus: json["ads_status"],
    status: json["status"],
    addDate: DateTime.parse(json["add_date"]),
    modifyDate: json["modify_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "admin_master_id": adminMasterId,
    "title": title,
    "fevicon_icon": feviconIcon,
    "logo": logo,
    "website": website,
    "website_link": websiteLink,
    "email": email,
    "mobile": mobile,
    "address": address,
    "short_description": shortDescription,
    "insta_link": instaLink,
    "twitter_link": twitterLink,
    "fb_link": fbLink,
    "ads_status": adsStatus,
    "status": status,
    "add_date": addDate!.toIso8601String(),
    "modify_date": modifyDate,
  };
}

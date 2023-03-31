// To parse this JSON data, do
//
//     final userProfileData = userProfileDataFromJson(jsonString);

import 'dart:convert';

UserProfileData userProfileDataFromJson(String str) => UserProfileData.fromJson(json.decode(str));

String userProfileDataToJson(UserProfileData data) => json.encode(data.toJson());

class UserProfileData {
  UserProfileData({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String ?message;
  Data ?data;

  factory UserProfileData.fromJson(Map<String, dynamic> json) => UserProfileData(
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
  Data({
    this.id,
    this.userLogin,
    this.userEmail,
    this.roleMasterId,
    this.uType,
    this.userUrl,
    this.userRegistered,
    this.userStatus,
    this.displayName,
    this.mobileNo,
    this.zipCode,
    this.block,
    this.regBy,
    this.profile,
  });

  String ?id;
  String ?userLogin;
  String ?userEmail;
  String ?roleMasterId;
  String ?uType;
  String ?userUrl;
  String ?userRegistered;
  String ?userStatus;
  String ?displayName;
  String ?mobileNo;
  String ?zipCode;
  String ?block;
  String ?regBy;
  String ?profile;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["ID"],
    userLogin: json["user_login"]??"",
    userEmail: json["user_email"]??"",
    roleMasterId: json["role_master_id"]??"",
    uType: json["u_type"]??"",
    userUrl: json["user_url"]??"",
    userRegistered: json["user_registered"]??"",
    userStatus: json["user_status"]??"",
    displayName: json["display_name"]??"",
    mobileNo: json["mobile_no"]??"",
    zipCode: json["zip_code"]??"",
    block: json["block"]??"",
    regBy: json["reg_by"]??"",
    profile: json["profile"]??"",
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "user_login": userLogin,
    "user_email": userEmail,
    "role_master_id": roleMasterId,
    "u_type": uType,
    "user_url": userUrl,
    "user_registered": userRegistered,
    "user_status": userStatus,
    "display_name": displayName,
    "mobile_no": mobileNo,
    "zip_code": zipCode,
    "block": block,
    "reg_by": regBy,
    "profile": profile,
  };
}

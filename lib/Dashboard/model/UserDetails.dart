// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

import 'dart:convert';

UserDetails userDetailsFromJson(String str) => UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
  UserDetails({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
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
    this.stateId,
    this.cityId,
    this.points,
    this.regBy,
    this.profile,
    this.dob,
  });

  String? id;
  String? userLogin;
  String? userEmail;
  String? roleMasterId;
  String? uType;
  String? userUrl;
  DateTime? userRegistered;
  String? userStatus;
  String? displayName;
  String? mobileNo;
  String? zipCode;
  String? block;
  String? stateId;
  String? cityId;
  String? points;
  String? regBy;
  String? profile;
  String? dob;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["ID"],
    userLogin: json["user_login"],
    userEmail: json["user_email"],
    roleMasterId: json["role_master_id"],
    uType: json["u_type"],
    userUrl: json["user_url"],
    userRegistered: DateTime.parse(json["user_registered"]),
    userStatus: json["user_status"],
    displayName: json["display_name"],
    mobileNo: json["mobile_no"],
    zipCode: json["zip_code"],
    block: json["block"],
    stateId: json["state_id"],
    cityId: json["city_id"],
    points: json["points"],
    regBy: json["reg_by"],
    profile: json["profile"],
    dob: json["dob"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "user_login": userLogin,
    "user_email": userEmail,
    "role_master_id": roleMasterId,
    "u_type": uType,
    "user_url": userUrl,
    "user_registered": userRegistered!.toIso8601String(),
    "user_status": userStatus,
    "display_name": displayName,
    "mobile_no": mobileNo,
    "zip_code": zipCode,
    "block": block,
    "state_id": stateId,
    "city_id": cityId,
    "points": points,
    "reg_by": regBy,
    "profile": profile,
    "dob": dob,
  };
}

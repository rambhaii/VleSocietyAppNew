// To parse this JSON data, do
//
//     final redeemPointsModel = redeemPointsModelFromJson(jsonString);

import 'dart:convert';

RedeemPointsModel redeemPointsModelFromJson(String str) => RedeemPointsModel.fromJson(json.decode(str));

String redeemPointsModelToJson(RedeemPointsModel data) => json.encode(data.toJson());

class RedeemPointsModel {
  int? status;
  String? message;
  int? limit;
  int? page;
  List<Datum>? data;

  RedeemPointsModel({
    this.status,
    this.message,
    this.limit,
    this.page,
    this.data,
  });

  factory RedeemPointsModel.fromJson(Map<String, dynamic> json) => RedeemPointsModel(
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
  String? id;
  String? usersId;
  String? amount;
  String? redeemType;
  String? upiId;
  String? bankMasterId;
  String? branch;
  String? ifscCode;
  String? address;
  String? remark;
  String? txnId;
  String? invPic;
  String? status;
  DateTime? addDate;
  String? modifyDate;

  Datum({
    this.id,
    this.usersId,
    this.amount,
    this.redeemType,
    this.upiId,
    this.bankMasterId,
    this.branch,
    this.ifscCode,
    this.address,
    this.remark,
    this.txnId,
    this.invPic,
    this.status,
    this.addDate,
    this.modifyDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    usersId: json["users_id"],
    amount: json["amount"],
    redeemType: json["redeem_type"],
    upiId: json["upi_id"],
    bankMasterId: json["bank_master_id"],
    branch: json["branch"],
    ifscCode: json["ifsc_code"],
    address: json["address"],
    remark: json["remark"],
    txnId: json["txn_id"],
    invPic: json["inv_pic"],
    status: json["status"],
    addDate: DateTime.parse(json["add_date"]),
    modifyDate: json["modify_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "users_id": usersId,
    "amount": amount,
    "redeem_type": redeemType,
    "upi_id": upiId,
    "bank_master_id": bankMasterId,
    "branch": branch,
    "ifsc_code": ifscCode,
    "address": address,
    "remark": remark,
    "txn_id": txnId,
    "inv_pic": invPic,
    "status": status,
    "add_date": addDate!.toIso8601String(),
    "modify_date": modifyDate,
  };
}

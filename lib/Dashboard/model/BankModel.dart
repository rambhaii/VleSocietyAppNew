// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

String bankModelToJson(BankModel data) => json.encode(data.toJson());

class BankModel {
  int? status;
  String? message;
  List<BankDatum>? data;

  BankModel({
    this.status,
    this.message,
    this.data,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
    status: json["status"],
    message: json["message"],
    data: List<BankDatum>.from(json["Data"].map((x) => BankDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BankDatum {
  String? id;
  String? bankName;
  String? bankIfsc;
  String? bankBranch;

  BankDatum({
    this.id,
    this.bankName,
    this.bankIfsc,
    this.bankBranch,
  });

  factory BankDatum.fromJson(Map<String, dynamic> json) => BankDatum(
    id: json["id"],
    bankName: json["bank_name"],
    bankIfsc: json["bank_ifsc"],
    bankBranch: json["bank_branch"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bank_name": bankName,
    "bank_ifsc": bankIfsc,
    "bank_branch": bankBranch,
  };
}

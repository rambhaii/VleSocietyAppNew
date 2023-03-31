// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  CityModel({
     this.status,
     this.message,
     this.data,
  });

  int ?status;
  String ?message;
  List<CityDatum> ?data;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    status: json["status"],
    message: json["message"],
    data: List<CityDatum>.from(json["Data"].map((x) => CityDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CityDatum {
  CityDatum({
    required this.id,
    required this.name,
  });

  String ?id;
  String ?name;

  factory CityDatum.fromJson(Map<String, dynamic> json) => CityDatum(
    id: json["id"]??"",
    name: json["name"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

// To parse this JSON data, do
//
//     final bookingsModel = bookingsModelFromJson(jsonString);

import 'dart:convert';

StateModel stateModelFromJson(String str) => StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  StateModel({
    this.status,
    this.message,
    this.data,
  });

  int ?status;
  String? message;
  List<StateDatum>? data;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    status: json["status"]??0,
    message: json["message"]??"",
    data: List<StateDatum>.from((json["Data"]??[]).map((x) => StateDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StateDatum {
  StateDatum({
    this.stateId,
    this.stateTitle,
  });

  String ?stateId;
  String ?stateTitle;

  factory StateDatum.fromJson(Map<String, dynamic> json) => StateDatum(
    stateId: json["state_id"]??"",
    stateTitle: json["state_title"]??"",
  );

  Map<String, dynamic> toJson() => {
    "state_id": stateId,
    "state_title": stateTitle,
  };
}

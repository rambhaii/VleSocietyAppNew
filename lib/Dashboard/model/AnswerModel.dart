// To parse this JSON data, do
//
//     final answarModel = answarModelFromJson(jsonString);

import 'dart:convert';

AnswarModel answarModelFromJson(String str) => AnswarModel.fromJson(json.decode(str));

String answarModelToJson(AnswarModel data) => json.encode(data.toJson());

class AnswarModel {
  AnswarModel({
    this.status,
    this.message,
    this.limit,
    this.page,
    this.data,
  });

  int ?status;
  String? message;
  String? limit;
  int? page;
  List<AnswerDatum> ?data;

  factory AnswarModel.fromJson(Map<String, dynamic> json) => AnswarModel(
    status: json["status"],
    message: json["message"],
    limit: json["limit"],
    page: json["page"],
    data: List<AnswerDatum>.from(json["Data"].map((x) => AnswerDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "limit": limit,
    "page": page,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AnswerDatum {
  AnswerDatum({
    this.id,
    this.datumAddBy,
    this.postCommunityId,
    this.answer,
    this.addDate,
    this.addById,
    this.ttlLike,
    this.aslike,
    this.addBy,
    this.addByPic,
  });

  String ?id;
  String ?datumAddBy;
  String ?postCommunityId;
  String ?answer;
  String ?addDate;
  String ?addById;
  String ?ttlLike;
  String ?aslike;
  String ?addBy;
  String ?addByPic;

  factory AnswerDatum.fromJson(Map<String, dynamic> json) => AnswerDatum(
    id: json["id"],
    datumAddBy: json["add_by"]??"",
    postCommunityId: json["post_community_id"]??"",
    answer: json["answer"],
    addDate: json["add_date"]??"",
    addById: json["add_by_id"]??"",
    ttlLike: json["ttlLike"]??"",
    aslike: json["aslike"]??"",
    addBy: json["addBy"]??"",
    addByPic: json["addByPic"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "add_by": datumAddBy,
    "post_community_id": postCommunityId,
    "answer": answer,
    "add_date": addDate,
    "add_by_id": addById,
    "ttlLike": ttlLike,
    "aslike": aslike,
    "addBy": addBy,
    "addByPic": addByPic,
  };
}

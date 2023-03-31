// To parse this JSON data, do
//
//     final quizqModel = quizqModelFromJson(jsonString);

import 'dart:convert';

QuizqModel quizqModelFromJson(String str) => QuizqModel.fromJson(json.decode(str));

String quizqModelToJson(QuizqModel data) => json.encode(data.toJson());

class QuizqModel {
  QuizqModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory QuizqModel.fromJson(Map<String, dynamic> json) => QuizqModel(
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
    this.title,
    this.ptPrQuestion,
    this.image,
    this.description,
    this.status,
    this.addDate,
    this.noOfQuestion,
    this.totalPoints,
    this.questionList,
  });

  String? id;
  String? title;
  String? ptPrQuestion;
  String? image;
  String? description;
  String? status;
  DateTime? addDate;
  String? noOfQuestion;
  String? totalPoints;
  List<QuestionList>? questionList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    ptPrQuestion: json["pt_pr_question"],
    image: json["image"],
    description: json["description"],
    status: json["status"],
    addDate: DateTime.parse(json["add_date"]),
    noOfQuestion: json["noOfQuestion"],
    totalPoints: json["totalPoints"],
    questionList: List<QuestionList>.from(json["questionList"].map((x) => QuestionList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "pt_pr_question": ptPrQuestion,
    "image": image,
    "description": description,
    "status": status,
    "add_date": addDate!.toIso8601String(),
    "noOfQuestion": noOfQuestion,
    "totalPoints": totalPoints,
    "questionList": List<dynamic>.from(questionList!.map((x) => x.toJson())),
  };
}

class QuestionList {
  QuestionList({
    this.id,
    this.question,
    this.optA,
    this.optB,
    this.optC,
    this.optD,
    this.answer,
    this.correctAns,
  });

  String? id;
  String? question;
  String? optA;
  String? optB;
  String? optC;
  String? optD;
  String? answer;
  String? correctAns;

  factory QuestionList.fromJson(Map<String, dynamic> json) => QuestionList(
    id: json["id"],
    question: json["question"],
    optA: json["opt_a"],
    optB: json["opt_b"],
    optC: json["opt_c"],
    optD: json["opt_d"],
    answer: json["answer"],
    correctAns: "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "opt_a": optA,
    "opt_b": optB,
    "opt_c": optC,
    "opt_d": optD,
    "answer": answer,
    "correctAns": correctAns,
  };
}

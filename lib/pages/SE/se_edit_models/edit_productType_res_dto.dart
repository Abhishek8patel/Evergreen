// To parse this JSON data, do
//
//     final editWorkingTypeRes = editWorkingTypeResFromJson(jsonString);

import 'dart:convert';

EditWorkingTypeRes editWorkingTypeResFromJson(String str) => EditWorkingTypeRes.fromJson(json.decode(str));

String editWorkingTypeResToJson(EditWorkingTypeRes data) => json.encode(data.toJson());

class EditWorkingTypeRes {
  String id;
  dynamic? image0;
  dynamic? image1;
  dynamic? image2;
  String productId;
  String siteId;
  String? problemId;
  String userId;
  dynamic? solution;
  String workingStatus;
  int? currentValue;
  dynamic? problemCovered;
  String date;
  String datetime;
  int? v;

  EditWorkingTypeRes({
    required this.id,
     this.image0,
     this.image1,
     this.image2,
    required this.productId,
    required this.siteId,
     this.problemId,
    required this.userId,
     this.solution,
    required this.workingStatus,
     this.currentValue,
     this.problemCovered,
    required this.date,
    required this.datetime,
     this.v,
  });

  factory EditWorkingTypeRes.fromJson(Map<String, dynamic> json) => EditWorkingTypeRes(
    id: json["_id"],
    image0: json["image_0"],
    image1: json["image_1"],
    image2: json["image_2"],
    productId: json["product_id"],
    siteId: json["site_id"],
    problemId: json["problem_id"],
    userId: json["user_id"],
    solution: json["solution"],
    workingStatus: json["working_status"],
    currentValue: json["current_value"],
    problemCovered: json["problem_covered"],
    date: json["date"],
    datetime: json["datetime"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "image_0": image0,
    "image_1": image1,
    "image_2": image2,
    "product_id": productId,
    "site_id": siteId,
    "problem_id": problemId,
    "user_id": userId,
    "solution": solution,
    "working_status": workingStatus,
    "current_value": currentValue,
    "problem_covered": problemCovered,
    "date": date,
    "datetime": datetime,
    "__v": v,
  };
}

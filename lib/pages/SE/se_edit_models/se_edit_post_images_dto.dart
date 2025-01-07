// To parse this JSON data, do
//
//     final editImagePostSeRes = editImagePostSeResFromJson(jsonString);

import 'dart:convert';

EditImagePostSeRes editImagePostSeResFromJson(String str) => EditImagePostSeRes.fromJson(json.decode(str));

String editImagePostSeResToJson(EditImagePostSeRes data) => json.encode(data.toJson());

class EditImagePostSeRes {
  String message;
  ProductReport productReport;

  EditImagePostSeRes({
    required this.message,
    required this.productReport,
  });

  factory EditImagePostSeRes.fromJson(Map<String, dynamic> json) => EditImagePostSeRes(
    message: json["message"],
    productReport: ProductReport.fromJson(json["product_report"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "product_report": productReport.toJson(),
  };
}

class ProductReport {
  String id;
  String? image0;
  String? image1;
  String? image2;
  String productId;
  String siteId;
  String problemId;
  String userId;
  dynamic solution;
  String workingStatus;
  int? currentValue;
  dynamic problemCovered;
  String date;
  String datetime;
  int v;

  ProductReport({
    required this.id,
     this.image0,
     this.image1,
     this.image2,
    required this.productId,
    required this.siteId,
    required this.problemId,
    required this.userId,
    required this.solution,
    required this.workingStatus,
     this.currentValue,
    required this.problemCovered,
    required this.date,
    required this.datetime,
    required this.v,
  });

  factory ProductReport.fromJson(Map<String, dynamic> json) => ProductReport(
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

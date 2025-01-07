// To parse this JSON data, do
//
//     final postCorrectValueRes = postCorrectValueResFromJson(jsonString);

import 'dart:convert';

PostCorrectValueRes postCorrectValueResFromJson(String str) => PostCorrectValueRes.fromJson(json.decode(str));

String postCorrectValueResToJson(PostCorrectValueRes data) => json.encode(data.toJson());

class PostCorrectValueRes {
  String message;
  ProductReport productReport;

  PostCorrectValueRes({
    required this.message,
    required this.productReport,
  });

  factory PostCorrectValueRes.fromJson(Map<String, dynamic> json) => PostCorrectValueRes(
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
  dynamic image0;
  dynamic image1;
  dynamic image2;
  String productId;
  String siteId;
  dynamic problemId;
  String userId;
  dynamic solution;
  String workingStatus;
  int currentValue;
  dynamic problemCovered;
  String date;
  String datetime;
  int v;
  String mainReportId;

  ProductReport({
    required this.id,
    required this.image0,
    required this.image1,
    required this.image2,
    required this.productId,
    required this.siteId,
    required this.problemId,
    required this.userId,
    required this.solution,
    required this.workingStatus,
    required this.currentValue,
    required this.problemCovered,
    required this.date,
    required this.datetime,
    required this.v,
    required this.mainReportId,
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
    mainReportId: json["main_report_id"],
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
    "main_report_id": mainReportId,
  };
}

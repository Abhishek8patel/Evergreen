// To parse this JSON data, do
//
//     final postImgRes = postImgResFromJson(jsonString);

import 'dart:convert';

PostImgRes postImgResFromJson(String str) => PostImgRes.fromJson(json.decode(str));

String postImgResToJson(PostImgRes data) => json.encode(data.toJson());

class PostImgRes {
  String message;
  ProductReport productReport;

  PostImgRes({
    required this.message,
    required this.productReport,
  });

  factory PostImgRes.fromJson(Map<String, dynamic> json) => PostImgRes(
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
  String problemId;
  String userId;
  dynamic solution;
  String workingStatus;
  dynamic currentValue;
  dynamic problemCovered;
  String date;
  String datetime;
  int v;

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

// To parse this JSON data, do
//
//     final svAddWorkingTypeRes = svAddWorkingTypeResFromJson(jsonString);

import 'dart:convert';

SvAddWorkingTypeRes svAddWorkingTypeResFromJson(String str) => SvAddWorkingTypeRes.fromJson(json.decode(str));

String svAddWorkingTypeResToJson(SvAddWorkingTypeRes data) => json.encode(data.toJson());

class SvAddWorkingTypeRes {
  String message;
  ProductReport productReport;
  Report? report;

  SvAddWorkingTypeRes({
    required this.message,
    required this.productReport,
    this.report,
  });

  factory SvAddWorkingTypeRes.fromJson(Map<String, dynamic> json) {
    return SvAddWorkingTypeRes(
      message: json["message"],
      productReport: ProductReport.fromJson(json["product_report"]),
      report: json["report"] != null ? Report.fromJson(json["report"]) : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "message": message,
        "product_report": productReport.toJson(),
        "report": report?.toJson(),
      };

}

class ProductReport {
  dynamic image0;
  dynamic image1;
  dynamic image2;
  String productId;
  String siteId;
  dynamic problemId;
  String userId;
  dynamic solution;
  String workingStatus;
  dynamic currentValue;
  dynamic problemCovered;
  String date;
  String datetime;
  int v;
  String productReportId;

  ProductReport({
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
    required this.productReportId,
  });

  factory ProductReport.fromJson(Map<String, dynamic> json) => ProductReport(
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
    productReportId: json["product_report_id"],
  );

  Map<String, dynamic> toJson() => {
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
    "product_report_id": productReportId,
  };
}

class Report {
  String id;
  String userId;
  String siteId;
  List<String> productReportId;
  String datetime;
  String date;
  bool verifiedStatus;
  dynamic verifiedUserId;
  dynamic verifiedAdminId;
  dynamic verifiedUser;
  bool mailSend;
  bool allDataSubmit;
  int v;

  Report({
    required this.id,
    required this.userId,
    required this.siteId,
    required this.productReportId,
    required this.datetime,
    required this.date,
    required this.verifiedStatus,
    required this.verifiedUserId,
    required this.verifiedAdminId,
    required this.verifiedUser,
    required this.mailSend,
    required this.allDataSubmit,
    required this.v,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    id: json["_id"],
    userId: json["userId"],
    siteId: json["site_id"],
    productReportId: List<String>.from(json["product_report_id"].map((x) => x)),
    datetime: json["datetime"],
    date: json["date"],
    verifiedStatus: json["verified_status"],
    verifiedUserId: json["verified_userId"],
    verifiedAdminId: json["verified_adminId"],
    verifiedUser: json["verified_user"],
    mailSend: json["mail_send"],
    allDataSubmit: json["all_data_submit"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "site_id": siteId,
    "product_report_id": List<dynamic>.from(productReportId.map((x) => x)),
    "datetime": datetime,
    "date": date,
    "verified_status": verifiedStatus,
    "verified_userId": verifiedUserId,
    "verified_adminId": verifiedAdminId,
    "verified_user": verifiedUser,
    "mail_send": mailSend,
    "all_data_submit": allDataSubmit,
    "__v": v,
  };
}

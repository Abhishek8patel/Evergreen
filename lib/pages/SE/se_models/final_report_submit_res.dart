// To parse this JSON data, do
//
//     final finalReportSubmitRes = finalReportSubmitResFromJson(jsonString);

import 'dart:convert';

FinalReportSubmitRes finalReportSubmitResFromJson(String str) => FinalReportSubmitRes.fromJson(json.decode(str));

String finalReportSubmitResToJson(FinalReportSubmitRes data) => json.encode(data.toJson());

class FinalReportSubmitRes {
  String message;
  Report report;

  FinalReportSubmitRes({
    required this.message,
    required this.report,
  });

  factory FinalReportSubmitRes.fromJson(Map<String, dynamic> json) => FinalReportSubmitRes(
    message: json["message"],
    report: Report.fromJson(json["report"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "report": report.toJson(),
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

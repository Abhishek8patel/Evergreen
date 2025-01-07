// To parse this JSON data, do
//
//     final seReportHomeDto = seReportHomeDtoFromJson(jsonString);

import 'dart:convert';

SeReportHomeDto seReportHomeDtoFromJson(String str) => SeReportHomeDto.fromJson(json.decode(str));

String seReportHomeDtoToJson(SeReportHomeDto data) => json.encode(data.toJson());

class SeReportHomeDto {
  String id;
  SiteId siteId;
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
  SubmittedBy submittedBy;

  SeReportHomeDto({
    required this.id,
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
    required this.submittedBy,
  });

  factory SeReportHomeDto.fromJson(Map<String, dynamic> json) => SeReportHomeDto(
    id: json["_id"],
    siteId: SiteId.fromJson(json["site_id"]),
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
    submittedBy: SubmittedBy.fromJson(json["submitted_by"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "site_id": siteId.toJson(),
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
    "submitted_by": submittedBy.toJson(),
  };
}

class SiteId {
  String id;
  String siteName;

  SiteId({
    required this.id,
    required this.siteName,
  });

  factory SiteId.fromJson(Map<String, dynamic> json) => SiteId(
    id: json["_id"],
    siteName: json["site_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "site_name": siteName,
  };
}

class SubmittedBy {
  String id;
  String fullName;
  String role;

  SubmittedBy({
    required this.id,
    required this.fullName,
    required this.role,
  });

  factory SubmittedBy.fromJson(Map<String, dynamic> json) => SubmittedBy(
    id: json["_id"],
    fullName: json["full_name"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "full_name": fullName,
    "role": role,
  };
}

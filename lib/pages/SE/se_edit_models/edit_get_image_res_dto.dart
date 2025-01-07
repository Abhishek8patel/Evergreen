// To parse this JSON data, do
//
//     final getEditImageSeRes = getEditImageSeResFromJson(jsonString);

import 'dart:convert';

GetEditImageSeRes getEditImageSeResFromJson(String str) => GetEditImageSeRes.fromJson(json.decode(str));

String getEditImageSeResToJson(GetEditImageSeRes data) => json.encode(data.toJson());

class GetEditImageSeRes {
  String id;
  UserId userId;
  String siteId;
  List<ProductReportId> productReportId;
  String datetime;
  String date;
  bool verifiedStatus;
  dynamic verifiedUserId;
  dynamic verifiedAdminId;
  dynamic verifiedUser;
  bool mailSend;
  bool allDataSubmit;
  int v;

  GetEditImageSeRes({
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

  factory GetEditImageSeRes.fromJson(Map<String, dynamic> json) => GetEditImageSeRes(
    id: json["_id"],
    userId: UserId.fromJson(json["userId"]),
    siteId: json["site_id"],
    productReportId: List<ProductReportId>.from(json["product_report_id"].map((x) => ProductReportId.fromJson(x))),
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
    "userId": userId.toJson(),
    "site_id": siteId,
    "product_report_id": List<dynamic>.from(productReportId.map((x) => x.toJson())),
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

class ProductReportId {
  String id;
  String? image0;
  String? image1;
  String? image2;
  ProductId productId;
  ProblemId? problemId;
  dynamic solution;
  dynamic problemCovered;

  ProductReportId({
    required this.id,
     this.image0,
     this.image1,
     this.image2,
    required this.productId,
    required this.problemId,
    required this.solution,
    required this.problemCovered,
  });

  factory ProductReportId.fromJson(Map<String, dynamic> json) => ProductReportId(
    id: json["_id"],
    image0: json["image_0"],
    image1: json["image_1"],
    image2: json["image_2"],
    productId: ProductId.fromJson(json["product_id"]),
    problemId: json["problem_id"] == null ? null : ProblemId.fromJson(json["problem_id"]),
    solution: json["solution"],
    problemCovered: json["problem_covered"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "image_0": image0,
    "image_1": image1,
    "image_2": image2,
    "product_id": productId.toJson(),
    "problem_id": problemId?.toJson(),
    "solution": solution,
    "problem_covered": problemCovered,
  };
}

class ProblemId {
  String id;
  String problem;

  ProblemId({
    required this.id,
    required this.problem,
  });

  factory ProblemId.fromJson(Map<String, dynamic> json) => ProblemId(
    id: json["_id"],
    problem: json["problem"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "problem": problem,
  };
}

class ProductId {
  String id;
  String productName;

  ProductId({
    required this.id,
    required this.productName,
  });

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
    id: json["_id"],
    productName: json["product_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "product_name": productName,
  };
}

class UserId {
  String id;
  String fullName;

  UserId({
    required this.id,
    required this.fullName,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    fullName: json["full_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "full_name": fullName,
  };
}

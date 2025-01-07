// To parse this JSON data, do
//
//     final getEdittedProductDto = getEdittedProductDtoFromJson(jsonString);

import 'dart:convert';

GetEdittedProductDto getEdittedProductDtoFromJson(String str) => GetEdittedProductDto.fromJson(json.decode(str));

String getEdittedProductDtoToJson(GetEdittedProductDto data) => json.encode(data.toJson());

class GetEdittedProductDto {
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

  GetEdittedProductDto({
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

  factory GetEdittedProductDto.fromJson(Map<String, dynamic> json) => GetEdittedProductDto(
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
  ProductId? productId;
  String workingStatus;

  ProductReportId({
    required this.id,
     this.productId,
    required this.workingStatus,
  });

  factory ProductReportId.fromJson(Map<String, dynamic> json) => ProductReportId(
    id: json["_id"],
    productId: ProductId.fromJson(json["product_id"]),
    workingStatus: json["working_status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "product_id": productId!.toJson(),
    "working_status": workingStatus,
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

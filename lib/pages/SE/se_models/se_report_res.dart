// To parse this JSON data, do
//
//     final seReportRes = seReportResFromJson(jsonString);

import 'dart:convert';

SeReportRes seReportResFromJson(String str) => SeReportRes.fromJson(json.decode(str));

String seReportResToJson(SeReportRes data) => json.encode(data.toJson());

class SeReportRes {
  String? id;
  List<Product> product;
  String userId;
  String siteId;
  bool status;

  SeReportRes({
     this.id,
    required this.product,
    required this.userId,
    required this.siteId,
    required this.status,
  });

  factory SeReportRes.fromJson(Map<String, dynamic> json) => SeReportRes(
    id: json["_id"],
    product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
    userId: json["userId"],
    siteId: json["site_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "product": List<dynamic>.from(product.map((x) => x.toJson())),
    "userId": userId,
    "site_id": siteId,
    "status": status,
  };
}

class Product {
  String id;
  List<String> images;
  String problemId;
  dynamic solution;
  String workingStatus;
  int currentValue;
  dynamic problemCovered;

  Product({
    required this.id,
    required this.images,
    required this.problemId,
    required this.solution,
    required this.workingStatus,
    required this.currentValue,
    required this.problemCovered,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    images: List<String>.from(json["images"].map((x) => x)),
    problemId: json["problem_id"],
    solution: json["solution"],
    workingStatus: json["working_status"],
    currentValue: json["current_value"],
    problemCovered: json["problem_covered"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "images": List<dynamic>.from(images.map((x) => x)),
    "problem_id": problemId,
    "solution": solution,
    "working_status": workingStatus,
    "current_value": currentValue,
    "problem_covered": problemCovered,
  };
}

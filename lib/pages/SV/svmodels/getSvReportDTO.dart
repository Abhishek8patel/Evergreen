// To parse this JSON data, do
//
//     final getReportDto = getReportDtoFromJson(jsonString);

import 'dart:convert';

GetReportDto getReportDtoFromJson(String str) => GetReportDto.fromJson(json.decode(str));

String getReportDtoToJson(GetReportDto data) => json.encode(data.toJson());

class GetReportDto {
  List<UserDatum> userData;
  String message;

  GetReportDto({
    required this.userData,
    required this.message,
  });

  factory GetReportDto.fromJson(Map<String, dynamic> json) => GetReportDto(
    userData: List<UserDatum>.from(json["userData"].map((x) => UserDatum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "userData": List<dynamic>.from(userData.map((x) => x.toJson())),
    "message": message,
  };
}

class UserDatum {
  String id;
  List<Product> product;
  String userId;
  String siteId;
  String datetime;
  bool verifiedStatus;
  dynamic verifiedUser;
  int v;

  UserDatum({
    required this.id,
    required this.product,
    required this.userId,
    required this.siteId,
    required this.datetime,
    required this.verifiedStatus,
    required this.verifiedUser,
    required this.v,
  });

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
    id: json["_id"],
    product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
    userId: json["userId"],
    siteId: json["site_id"],
    datetime: json["datetime"],
    verifiedStatus: json["verified_status"],
    verifiedUser: json["verified_user"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "product": List<dynamic>.from(product.map((x) => x.toJson())),
    "userId": userId,
    "site_id": siteId,
    "datetime": datetime,
    "verified_status": verifiedStatus,
    "verified_user": verifiedUser,
    "__v": v,
  };
}

class Product {
  String id;
  String parameterMin;
  String parameterMax;
  String productName;
  List<String> images;
  String problemId;
  dynamic solution;
  String workingStatus;
  dynamic problemCovered;
  int currentValue;
  List<String> defaultSolution;

  Product({
    required this.id,
    required this.parameterMin,
    required this.parameterMax,
    required this.productName,
    required this.images,
    required this.problemId,
    required this.solution,
    required this.workingStatus,
    required this.problemCovered,
    required this.currentValue,
    required this.defaultSolution,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    parameterMin: json["parameter_min"],
    parameterMax: json["parameter_max"],
    productName: json["product_name"],
    images: List<String>.from(json["images"].map((x) => x)),
    problemId: json["problem_id"],
    solution: json["solution"],
    workingStatus: json["working_status"],
    problemCovered: json["problem_covered"],
    currentValue: json["current_value"],
    defaultSolution: List<String>.from(json["default_solution"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "parameter_min": parameterMin,
    "parameter_max": parameterMax,
    "product_name": productName,
    "images": List<dynamic>.from(images.map((x) => x)),
    "problem_id": problemId,
    "solution": solution,
    "working_status": workingStatus,
    "problem_covered": problemCovered,
    "current_value": currentValue,
    "default_solution": List<dynamic>.from(defaultSolution.map((x) => x)),
  };
}

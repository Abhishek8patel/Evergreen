// To parse this JSON data, do
//
//     final notEmptyValuesRes = notEmptyValuesResFromJson(jsonString);

import 'dart:convert';

NotEmptyValuesRes notEmptyValuesResFromJson(String str) => NotEmptyValuesRes.fromJson(json.decode(str));

String notEmptyValuesResToJson(NotEmptyValuesRes data) => json.encode(data.toJson());

class NotEmptyValuesRes {
  String message;
  List<Product> products;

  NotEmptyValuesRes({
    required this.message,
    required this.products,
  });

  factory NotEmptyValuesRes.fromJson(Map<String, dynamic> json) => NotEmptyValuesRes(
    message: json["message"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  String id;
  String productName;
  String parameterMin;
  String parameterMax;
  dynamic currentValue;
  String productReportId;

  Product({
    required this.id,
    required this.productName,
    required this.parameterMin,
    required this.parameterMax,
    required this.currentValue,
    required this.productReportId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    productName: json["product_name"],
    parameterMin: json["parameter_min"],
    parameterMax: json["parameter_max"],
    currentValue: json["current_value"],
    productReportId: json["product_report_id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "product_name": productName,
    "parameter_min": parameterMin,
    "parameter_max": parameterMax,
    "current_value": currentValue,
    "product_report_id": productReportId,
  };
}

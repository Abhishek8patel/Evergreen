// To parse this JSON data, do
//
//     final chemicalListDto = chemicalListDtoFromJson(jsonString);

import 'dart:convert';

ChemicalListDto chemicalListDtoFromJson(String str) => ChemicalListDto.fromJson(json.decode(str));

String chemicalListDtoToJson(ChemicalListDto data) => json.encode(data.toJson());

class ChemicalListDto {
  String siteId;
  String siteName;
  List<Product> products;

  ChemicalListDto({
    required this.siteId,
    required this.siteName,
    required this.products,
  });

  factory ChemicalListDto.fromJson(Map<String, dynamic> json) => ChemicalListDto(
    siteId: json["site_id"],
    siteName: json["site_name"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "site_id": siteId,
    "site_name": siteName,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  String id;
  String productName;
  int usedQuantity;
  int remainingQuantity;
  int productQuantity;
  dynamic maintenanceDate;
  String maintenanceAlert;

  Product({
    required this.id,
    required this.productName,
    required this.usedQuantity,
    required this.remainingQuantity,
    required this.productQuantity,
    required this.maintenanceDate,
    required this.maintenanceAlert,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    productName: json["product_name"],
    usedQuantity: json["used_quantity"]?.toInt() ?? 0,
    remainingQuantity: json["remaining_quantity"]?.toInt() ?? 0,
    productQuantity: json["product_quantity"],
    maintenanceDate: json["maintenance_date"],
    maintenanceAlert: json["maintenance_alert"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "product_name": productName,
    "used_quantity": usedQuantity,
    "remaining_quantity": remainingQuantity,
    "product_quantity": productQuantity,
    "maintenance_date": maintenanceDate,
    "maintenance_alert": maintenanceAlert,
  };
}

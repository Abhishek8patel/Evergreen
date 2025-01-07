// To parse this JSON data, do
//
//     final siteProductResponse = siteProductResponseFromJson(jsonString);

import 'dart:convert';

SiteProductResponse siteProductResponseFromJson(String str) => SiteProductResponse.fromJson(json.decode(str));

String siteProductResponseToJson(SiteProductResponse data) => json.encode(data.toJson());

class SiteProductResponse {
  int totalCount;
  List<Product> products;

  SiteProductResponse({
    required this.totalCount,
    required this.products,
  });

  factory SiteProductResponse.fromJson(Map<String, dynamic> json) => SiteProductResponse(
    totalCount: json["totalCount"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  String id;
  String productName;

  Product({
    required this.id,
    required this.productName,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    productName: json["product_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "product_name": productName,
  };
}
